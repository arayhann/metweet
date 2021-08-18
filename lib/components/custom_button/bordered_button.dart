import 'package:flutter/material.dart';
import 'package:metweet/utils/themes.dart';

class BorderedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color color;
  final Color textColor;
  final Widget? leading;

  BorderedButton({
    required this.text,
    required this.onTap,
    this.leading,
    this.color = primaryColor,
    this.textColor = primaryColor,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: OutlinedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith(
              (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            side: MaterialStateProperty.resolveWith(
              (states) => BorderSide(color: color, width: 1),
            )),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leading != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: leading,
              ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
