import 'package:flutter/material.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:tisaneconnect/app/navigation.dart';
import 'package:tisaneconnect/ui/components/button/primary_button.dart';
import 'package:tisaneconnect/ui/pages/operasional/summary/item.dart';

class SummaryOperasional extends StatefulWidget {
  const SummaryOperasional({super.key});

  @override
  State<SummaryOperasional> createState() => _SummaryOperasionalState();
}

class _SummaryOperasionalState extends State<SummaryOperasional> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.background,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: padTop() + 50
              ),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                    PrimaryButton(
                      label: "Raw Herbal",
                      radius: 20,
                      onTap: () {
                        nav.goPush(Product());
                      },
                    ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      PrimaryButton(
                      label: "Tea House",
                      radius: 20,
                      onTap: () {
                        nav.goPush(Product());
                      },
                    ),
                    ],
                  )
                ],
              ),
            ))
        ],
      ),
    );
  }
}