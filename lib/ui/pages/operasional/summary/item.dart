import 'package:flutter/material.dart';
import 'package:tisaneconnect/app/navigation.dart';
import 'package:tisaneconnect/ui/components/button/primary_button.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello World'),
            const SizedBox(height: 10),
            PrimaryButton(
              label: "Go back",
              radius: 20,
              onTap: () {
                nav.goBack();
              },
            ),
          ],
        ),
      ),
    );
  }
}