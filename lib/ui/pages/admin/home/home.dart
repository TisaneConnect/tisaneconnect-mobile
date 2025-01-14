import 'package:flutter/material.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:select_field/select_field.dart';
import 'package:tisaneconnect/ui/components/select_field/select_field_primary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Option<String>> courierOptions = [
    Option<String>(value: 'JNE', label: 'JNE'),
    Option<String>(value: 'POS', label: 'POS'),
    Option<String>(value: 'TIKI', label: 'TIKI'),
  ];

  final List<Option<String>> paymentOptions = [
    Option<String>(value: 'Credit Card', label: 'Credit Card'),
    Option<String>(value: 'PayPal', label: 'PayPal'),
    Option<String>(value: 'COD', label: 'COD'),
  ];

  final List<Option<String>> categoryOptions = [
    Option<String>(value: 'Electronics', label: 'Electronics'),
    Option<String>(value: 'Fashion', label: 'Fashion'),
    Option<String>(value: 'Books', label: 'Books'),
  ];

  final List<Option<String>> statusOptions = [
    Option<String>(value: 'Pending', label: 'Pending'),
    Option<String>(value: 'Processing', label: 'Processing'),
    Option<String>(value: 'Completed', label: 'Completed'),
  ];

  Option<String>? selectedCourier;
  Option<String>? selectedPayment;
  Option<String>? selectedCategory;
  Option<String>? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        backgroundColor: ColorAssets.background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: screenWidth() / 10,
                  right: screenWidth() / 10,
                  top: padTop() + 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight() * 0.1,
                    ),
                    const SizedBox(height: 40),

                    CustomSelectField(
                      hint: 'Pilih Kurir',
                      options: courierOptions,
                      onOptionSelected: (option) {
                        setState(() {
                          selectedCourier = option;
                        });
                      },
                      initialOption: selectedCourier,
                    ),
                    const SizedBox(height: 20),

                    const SizedBox(height: 20),

                    const SizedBox(height: 20),
                    
                    QtyCounter(),
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}

class QtyCounter extends StatefulWidget {
  const QtyCounter({super.key});

  @override
  State<QtyCounter> createState() => _QtyCounterState();
}

class _QtyCounterState extends State<QtyCounter> {
  int number = 0;
  void tambahQty() {
    setState(() {
      number = number + 1;
    });
  }

  void tambah10Qty() {
    setState(() {
      number = number + 10;
    });
  }
  void kurangQty() {
    setState(() {
      if (number > 0){
        number = number -1;
      }
    });
  }

  void kurang10Qty() {
    setState(() {
      if (number > 0 && number < 11) {
        number = 0;
      } else if (number > 10) {
        number = number - 10;
      }
    });
  }

  void hapusQty() {
    setState(() {
      number = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButtonWithAction(
                onPressed: () {
                  kurang10Qty(); // Panggil fungsi yang sesuai
                },
                icon: Icons.exposure_minus_1_outlined,
                color: ColorAssets.black,
                iconSize: 30,
              ),
              IconButtonWithAction(
                onPressed: () {
                  kurangQty(); // Panggil fungsi yang sesuai
                },
                icon: Icons.exposure_minus_1_outlined,
                color: ColorAssets.black,
                iconSize: 30,
              ),
              Text(
                number.toString(),
                style: TextStyle(fontSize: 25),
              ),

              IconButtonWithAction(
                onPressed: () {
                  tambahQty(); // Panggil fungsi yang sesuai
                },
                icon: Icons.exposure_plus_1_outlined,
                color: ColorAssets.black,
                iconSize: 30,
              ),
              IconButtonWithAction(
                onPressed: () {
                  tambah10Qty(); // Panggil fungsi yang sesuai
                },
                icon: Icons.exposure_plus_1_outlined,
                color: ColorAssets.black,
                iconSize: 30,
              ),
              IconButtonWithAction(
                onPressed: () {
                  hapusQty(); // Panggil fungsi yang sesuai
                },
                icon: Icons.restore_from_trash,
                color: ColorAssets.error,
                iconSize: 30,
              )
            ],
          )
        ],
      ),
    );
  }
}


class IconButtonWithAction extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  final double iconSize;

  const IconButtonWithAction({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.color,
    required this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color,
      ),
      iconSize: iconSize,
    );
  }
}
