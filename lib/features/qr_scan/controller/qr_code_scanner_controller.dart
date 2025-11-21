import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as contacts;
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_app/core/conts/app_colors.dart';
import 'package:qr_code_app/core/global_widgets/custom_button.dart';
import 'package:qr_code_app/core/style/global_text_style.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCodeScannerController extends GetxController {
    RxBool hasPermission = false.obs;
    RxBool isFlashOn = false.obs;
    RxBool isScanning = false.obs;

    late MobileScannerController scannerController;

    @override
    void onInit() {
        super.onInit();
        scannerController = MobileScannerController();
        checkPermission();
    }

    Future<void> checkPermission() async {
        final status = await Permission.camera.request();
        hasPermission.value = status.isGranted;
    }

    Future<void> processScanData(String? data) async {
        if (data == null || isScanning.value) return;

        isScanning.value = true;
        scannerController.stop();

        String type = 'text';

        if (data.startsWith('BEGIN:VCARD')) {
            type = 'contact';
        } else if (data.startsWith('http://') || data.startsWith('https://')) {
            type = 'url';
        }

        showDraggableSheet(type, data);
    }

    Future<void> launchURL(String url) async {
        if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
        }
    }

    Future<void> saveContact(String vcardData) async {
        final lines = vcardData.split('\n');

        String? name, phone, email;

        for (var raw in lines) {
            final line = raw.trim();
            if (line.startsWith('FN:')) name = line.substring(3).trim();
            if (line.startsWith('TEL:')) phone = line.substring(4).trim();
            if (line.startsWith('EMAIL:')) email = line.substring(6).trim();
        }

        final contact = contacts.Contact()
            ..name = contacts.Name(first: name ?? '')
            ..phones = (phone != null && phone.isNotEmpty) ? [contacts.Phone(phone)] : <contacts.Phone>[]
            ..emails = (email != null && email.isNotEmpty) ? [contacts.Email(email)] : <contacts.Email>[];

        try {
            await contact.insert();
            Get.snackbar("Success", "Contact saved");
        } catch (e) {
            Get.snackbar("Error", "Failed to save contact: $e");
        }
    }

    void showDraggableSheet(String type, String data) {
        showModalBottomSheet(
            context: Get.context!,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) {
                return DraggableScrollableSheet(
                    initialChildSize: 0.4,
                    minChildSize: 0.2,
                    maxChildSize: 0.85,
                    expand: false,
                    builder: (_, controller) {
                        return Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                gradient: AppColors.appGradient2,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20),
                                ),
                            ),
                            child: SingleChildScrollView(
                                controller: controller,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Center(
                                            child: Container(
                                                width: 40,
                                                height: 4,
                                                margin: const EdgeInsets.only(bottom: 10),
                                                decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius: BorderRadius.circular(10),
                                                ),
                                            ),
                                        ),

                                        Text(
                                            "Scanned Result: ",
                                            style: globalTextStyle(
                                                fontSize: 18,
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w700,
                                            ),
                                        ),

                                        const SizedBox(height: 3),
                                        Text(
                                            data,
                                            style: globalTextStyle(
                                                fontSize: 15,
                                                color: AppColors.grey,
                                                fontWeight: FontWeight.w400,
                                            ),
                                        ),

                                        const SizedBox(height: 20),

                                        if (type == 'url')
                                            CustomButton(
                                                onTap: (){
                                                    launchURL(data);
                                                },
                                                title: "Open URL",
                                                icon: Icons.open_in_new,
                                            ),

                                        if (type == 'contact')
                                            CustomButton(
                                                onTap: (){
                                                    saveContact(data);
                                                },
                                                title: "Save Contact",
                                                icon: Icons.person_add,
                                            ),

                                        const SizedBox(height: 40),

                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                                CustomButton(
                                                    onTap: (){
                                                        Share.share(data);
                                                    },
                                                    title: "Share",
                                                    icon: Icons.share,
                                                ),
                                                CustomButton(
                                                    onTap: (){
                                                        Get.back();
                                                    },
                                                    title: "Scan Again",
                                                    icon: Icons.qr_code_scanner,
                                                ),
                                            ],
                                        ),
                                    ],
                                ),
                            ),
                        );
                    },
                );
            },
        ).whenComplete(() {
            isScanning.value = false;
            scannerController.start();
        });
    }
}

