import 'package:flutter/material.dart';

class PopAppBar extends StatelessWidget {
  final String title;
  final bool justTitle;
  final bool isHavePopIcon;
  final Widget? action;
  final VoidCallback? onPop;

  PopAppBar(
      {required this.title,
      this.action,
      this.onPop,
      this.justTitle = false,
      this.isHavePopIcon = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                isHavePopIcon ? Icons.arrow_back_ios : Icons.close,
                color: justTitle ? Colors.transparent : Colors.white,
              ),
              onPressed: justTitle
                  ? null
                  : onPop == null
                      ? () => Navigator.of(context).pop()
                      : onPop,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            action == null
                ? IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.transparent,
                    ),
                    onPressed: null,
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: action,
                  ),
          ],
        ),
      ),
    );
  }
}
