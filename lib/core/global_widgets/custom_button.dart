import 'package:flutter/material.dart';
import 'package:qr_code_app/core/style/global_text_style.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
  });



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
        EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white70),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Text(
              title,
              style: globalTextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}