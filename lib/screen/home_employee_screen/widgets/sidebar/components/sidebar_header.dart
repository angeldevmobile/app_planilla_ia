import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class SidebarHeader extends StatelessWidget {
  final bool isCollapsed;
  const SidebarHeader({super.key, required this.isCollapsed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
      child: isCollapsed
          ? Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'images/fourfiloi_icon.png',
                  width: 38,
                  height: 38,
                ),
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'images/fourfiloi_icon.png',
                    width: 38,
                    height: 38,
                  ),
                ),
                const SizedBox(width: 25),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VITALIS',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kSecondaryColor,
                      ),
                    ),
                    Text(
                      'CLINICA',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
