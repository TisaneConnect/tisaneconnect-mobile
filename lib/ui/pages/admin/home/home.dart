import 'package:flutter/material.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:select_field/select_field.dart';
import 'package:tisaneconnect/app/font_style.dart';
import 'package:tisaneconnect/ui/components/button/primary_button.dart';
import 'package:tisaneconnect/ui/components/select_field/select_field_primary.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  final List<Option<String>> storeOptions = [
    Option<String>(value: 'Raw Tisane', label: 'Raw Tisane'),
    Option<String>(value: 'Raw Tisane 2', label: 'Raw Tisane 2'),
  ];

  final List<Option<String>> platformOptions = [
    Option<String>(value: 'Shopee', label: 'Shopee'),
    Option<String>(value: 'Tokopedia', label: 'Tokopedia'),
    Option<String>(value: 'Tiktok Shop', label: 'Tiktok Shop'),
  ];

  final List<Option<String>> courierOptions = [
    Option<String>(value: 'JNE', label: 'JNE'),
    Option<String>(value: 'POS', label: 'POS'),
    Option<String>(value: 'TIKI', label: 'TIKI'),
  ];

  final List<Option<String>> categoryOptions = [
    Option<String>(value: 'Electronics', label: 'Electronics'),
    Option<String>(value: 'Fashion', label: 'Fashion'),
    Option<String>(value: 'Books', label: 'Books'),
  ];

  final List<Option<String>> productOptions = [
    Option<String>(value: 'Teh Herbal', label: 'Teh Herbal'),
    Option<String>(value: 'Teh Herbal X', label: 'Teh Herbal X'),
    Option<String>(value: 'Completed', label: 'Completed'),
  ];

  Option<String>? selectedStore;
  Option<String>? selectedPlatform;
  Option<String>? selectedCourier;
  Option<String>? selectedCategory;
  Option<String>? selectedProduct;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        backgroundColor: ColorAssets.background,
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                  Text(
                    "Input Data Ke Operasional",
                    style: StyleAsset.bold(fontSize: 30),
                  ),
                  const SizedBox(height: 40),
                  CustomSelectField(
                    hint: 'Pilih Toko',
                    options: storeOptions,
                    onOptionSelected: (option) {
                      setState(() {
                        selectedStore = option;
                      });
                    },
                    initialOption: selectedStore,
                  ),
                  const SizedBox(height: 40),
                  CustomSelectField(
                    hint: 'Pilih Platform',
                    options: platformOptions,
                    onOptionSelected: (option) {
                      setState(() {
                        selectedPlatform = option;
                      });
                    },
                    initialOption: selectedPlatform,
                  ),
                  const SizedBox(height: 40),
                  CustomSelectField(
                    hint: 'Pilih Expedisi',
                    options: courierOptions,
                    onOptionSelected: (option) {
                      setState(() {
                        selectedCourier = option;
                      });
                    },
                    initialOption: selectedCourier,
                  ),
                  const SizedBox(height: 40),
                  CustomSelectField(
                    hint: 'Pilih Jenis',
                    options: categoryOptions,
                    onOptionSelected: (option) {
                      setState(() {
                        selectedCategory = option;
                      });
                    },
                    initialOption: selectedCategory,
                  ),
                  const SizedBox(height: 40),
                  CustomSelectField(
                    hint: 'Pilih Nama Barang',
                    options: productOptions,
                    onOptionSelected: (option) {
                      setState(() {
                        selectedProduct = option;
                      });
                    },
                    initialOption: selectedProduct,
                  ),
                  const SizedBox(height: 40),
                  QtyCounter(
                    onChanged: (e) {
                      print(e);
                    },
                  ),
                  const SizedBox(height: 40),
                  PrimaryButton(
                      label: "Send To Operator", radius: 100, onTap: () {})
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class QtyCounter extends StatefulWidget {
  const QtyCounter({super.key, required this.onChanged});
  final Function(String) onChanged;

  @override
  State<QtyCounter> createState() => _QtyCounterState();
}

class _QtyCounterState extends State<QtyCounter> {
  int number = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = number.toString();
  }

  void _updateNumber(int newValue) {
    setState(() {
      number = newValue;
      _controller.text = number.toString();
    });
    widget.onChanged(_controller.text);
  }

  void tambahQty() => _updateNumber(number + 1);

  void tambah10Qty() => _updateNumber(number + 10);

  void kurangQty() => _updateNumber(number > 0 ? number - 1 : 0);

  void kurang10Qty() => _updateNumber(number > 10 ? number - 10 : 0);

  void hapusQty() => _updateNumber(0);

  void _onTextFieldChanged(String value) {
    widget.onChanged(value);
    int? parsedValue = int.tryParse(value);
    if (parsedValue != null) {
      setState(() {
        number = parsedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButtonWithAction(
                icon: Icons.exposure_minus_1_outlined,
                color: Colors.black,
                iconSize: 30,
                onPressed: kurang10Qty,
              ),
              IconButtonWithAction(
                icon: Icons.exposure_minus_1_outlined,
                color: Colors.black,
                iconSize: 30,
                onPressed: kurangQty,
              ),

              // TextFormField untuk input manual
              SizedBox(
                width: 60, // Lebar field
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                  onChanged: _onTextFieldChanged,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              IconButtonWithAction(
                icon: Icons.exposure_plus_1_outlined,
                color: Colors.black,
                iconSize: 30,
                onPressed: tambahQty,
              ),
              IconButtonWithAction(
                icon: Icons.exposure_plus_1_outlined,
                color: Colors.black,
                iconSize: 30,
                onPressed: tambah10Qty,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButtonWithAction(
                icon: Icons.restore_from_trash,
                iconSize: 30,
                color: ColorAssets.error,
                onPressed: hapusQty,
              ),
            ],
          ),
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
