import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tisaneconnect/app/color.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    super.key,
    this.index = 0,
    required this.onTap,
  });

  final Function(int) onTap;
  final int index;

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  String userRole = "";

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('user_role') ?? "";
    });
  }

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

    if (userRole != "superadmin") {
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
      onTap: widget.onTap,
      backgroundColor: ColorAssets.warning,
      selectedItemColor: ColorAssets.white,
      unselectedItemColor: ColorAssets.black.withOpacity(0.4),
      items: menus
          .map(
            (e) => BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: widget.index == menus.indexOf(e)
                      ? ColorAssets.neutrals100
                      : null,
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
          .toList(),
      currentIndex: widget.index,
    );
  }
}
