import 'package:flutter/material.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';

import 'package:tisaneconnect/ui/components/bottom_navigation/bottom_navigation.dart';
import 'package:tisaneconnect/ui/pages/admin/home/home.dart';
import 'package:tisaneconnect/ui/pages/operasional/home/home.dart';
import 'package:tisaneconnect/ui/pages/operasional/summary/summary.dart';
import 'package:tisaneconnect/ui/pages/profile/profile.dart';
import 'package:tisaneconnect/ui/pages/superadmin/home/home.dart';

class Template extends StatefulWidget {
  const Template({super.key});

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  int index = 0;
  List<Widget> widgets = [
    ProfilePage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (user["role"] == "superadmin") {
      widgets.insert(0, HomeSuperAdmin());
    } else {
      if (user["role"] == "user") {
        widgets.insert(0, HomeOperasional());
      } else if (user["role"] == "admin") {
        widgets.insert(0, HomeAdmin());
      }

      widgets.insert(1, SummaryOperasional());
    }
    print(widgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.background,
      bottomNavigationBar: BottomNavigation(
        onTap: (e) {
          setState(() {
            index = e;
          });
        },
        index: index,
      ),
      body: widgets[index],
    );
  }
}
