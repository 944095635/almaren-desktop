import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.text,
    required this.active,
    required this.icon,
    required this.activeIcon,
    required this.onTap,
  });

  final bool active;
  final String text;
  final String icon;
  final String activeIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        spacing: 8,
        children: [
          SvgPicture.asset(
            active ? activeIcon : icon,
            width: 28,
            height: 28,
            color: active
                ? Colors.black87
                : Color(
                    0xFF888888,
                  ),
          ),
          // Text(
          //   text,
          //   style: TextStyle(
          //     fontSize: 10,
          //     color: active ? Colors.black : Colors.black54,
          //     fontWeight: active ? FontWeight.bold : FontWeight.normal,
          //   ),
          // ),
        ],
      ),
    );
  }
}
