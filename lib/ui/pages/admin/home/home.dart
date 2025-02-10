import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:select_field/select_field.dart';
import 'package:tisaneconnect/app/font_style.dart';
import 'package:tisaneconnect/ui/components/button/primary_button.dart';
import 'package:tisaneconnect/ui/components/select_field/select_field_primary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  List<Option<String>> storeOptions = [];
  List<Option<String>> platformOptions = [];
  List<Option<String>> courierOptions = [];
  List<Option<String>> categoryOptions = [];
  List<Option<String>> productOptions = [];

  Option<String>? selectedStore;
  Option<String>? selectedPlatform;
  Option<String>? selectedCourier;
  Option<String>? selectedCategory;
  Option<String>? selectedProduct;

  bool isLoading = true;

  final TextEditingController _qtyController = TextEditingController(text: "0");

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    try {
      await Future.wait([
        fetchStores(),
        fetchPlatforms(),
        fetchCouriers(),
        fetchCategories(),
        fetchProducts(),
      ]);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchStores() async {
    try {
      final response =
          await http.get(Uri.parse('http://103.139.193.137:5000/toko'));
      if (response.statusCode == 200) {
        print('Data toko: ${response.body}'); // Debugging
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          storeOptions = data
              .map((store) => Option<String>(
                  value: store['id'].toString(),
                  label:
                      store['nama_toko'].toString())) // Perbaiki key jika perlu
              .toList();
        });
      }
    } catch (e) {
      print('Error fetching stores: $e');
    }
  }

  Future<void> fetchPlatforms() async {
    try {
      final response =
          await http.get(Uri.parse('http://103.139.193.137:5000/platform'));
      if (response.statusCode == 200) {
        print('Data platforms: ${response.body}');
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          platformOptions = data
              .map((platform) => Option<String>(
                  value: platform['id'].toString(),
                  label: platform['nama_platform'].toString()))
              .toList();
        });
      }
    } catch (e) {
      print('Error fetching platforms: $e');
    }
  }

  Future<void> fetchCouriers() async {
    try {
      final response =
          await http.get(Uri.parse('http://103.139.193.137:5000/ekspedisi'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          courierOptions = data
              .map((courier) => Option<String>(
                  value: courier['id'].toString(),
                  label: courier['nama_ekspedisi'].toString()))
              .toList();
        });
      }
    } catch (e) {
      print('Error fetching couriers: $e');
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response =
          await http.get(Uri.parse('http://103.139.193.137:5000/jenis'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          categoryOptions = data
              .map((category) => Option<String>(
                  value: category['id'].toString(),
                  label: category['jenis'].toString()))
              .toList();
        });
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('http://103.139.193.137:5000/item'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          productOptions = data
              .map((product) => Option<String>(
                  value: product['id'].toString(),
                  label: product['nama_item'].toString()))
              .toList();
        });
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

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
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
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
                          onChanged: (value) {
                            _qtyController.text = value;
                          },
                        ),
                        const SizedBox(height: 40),
                        PrimaryButton(
                          label: "Send To Operator",
                          radius: 100,
                          onTap: sendToOperator,
                        )
                      ],
                    ),
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> sendToOperator() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (selectedStore == null ||
        selectedPlatform == null ||
        selectedCourier == null ||
        selectedCategory == null ||
        selectedProduct == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Harap pilih semua data yang diperlukan!")),
      );
      return;
    }

    final int jumlah = int.tryParse(_qtyController.text) ?? 0;
    if (jumlah <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Jumlah harus lebih dari 0")),
      );
      return;
    }

    final Map<String, dynamic> data = {
      "toko_id": selectedStore!.value,
      "platform_id": selectedPlatform!.value,
      "ekspedisi_id": selectedCourier!.value,
      "jenis_id": selectedCategory!.value,
      "item_id": selectedProduct!.value,
      "jumlah": jumlah,
    };

    try {
      final response = await http.post(
        Uri.parse("http://103.139.193.137:5000/process"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Tambahkan token jika diperlukan
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Data berhasil dikirim ke operator!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal mengirim data: ${response.body}")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan!")),
      );
    }
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
