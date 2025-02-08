import 'package:flutter/material.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    this.index = 0,
    required this.onTap,
  });
  final Function(int) onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menus = [
      {
        "icon": Icons.home_rounded,
        "label": "Home",
      },
      {
        "icon": Icons.person_rounded,
        "label": "Profil",
      },
    ];

    if (user["role"] != "superadmin") {
      menus.insert(
        1,
        {
          "icon": Icons.receipt_long_rounded,
          "label": "Summary",
        },
      );
    }
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: onTap,
      backgroundColor: ColorAssets.warning,
      selectedItemColor: ColorAssets.white,
      unselectedItemColor: ColorAssets.black.withOpacity(0.4),
      items: [
        ...menus.map(
          (e) => BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                    index == menus.indexOf(e) ? ColorAssets.neutrals100 : null,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                e["icon"],
              ),
            ),
            label: "",
            tooltip: e["label"],
          ),
        )
      ],
      currentIndex: index,
    );
  }
}
