import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tisaneconnect/app/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Product extends StatefulWidget {
  final String jenis;
  const Product({Key? key, required this.jenis}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List<Order> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
        'auth_token'); // Pastikan sesuai dengan key di AuthController
  }

  Future<void> fetchOrders() async {
    String? token = await getToken(); // Ambil token dari storage

    if (token == null) {
      print("❌ Token tidak ditemukan");
      setState(() {
        isLoading = false;
      });
      return;
    }

    final url = "http://103.139.193.137:5000/process/done/${widget.jenis}";
    print("🌍 Fetching orders from: $url");
    print("🔑 Token: $token");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    print("🔄 Response status code: ${response.statusCode}");
    print("📜 Response body: ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      setState(() {
        orders = data.map((order) => Order.fromJson(order)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Items - ${widget.jenis}"),
        backgroundColor: Colors.green[300],
        centerTitle: true,
      ),
      backgroundColor: ColorAssets.background,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : orders.isEmpty
              ? Center(child: Text("No orders found"))
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return OrderCard(order: orders[index]);
                  },
                ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.namaItem,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            Text("Toko: ${order.toko}", style: TextStyle(fontSize: 14)),
            Text("Platform: ${order.platform}", style: TextStyle(fontSize: 14)),
            Text("Ekspedisi: ${order.ekspedisi}",
                style: TextStyle(fontSize: 14)),
            Text("Jenis: ${order.jenis}", style: TextStyle(fontSize: 14)),
            Text("Jumlah: ${order.jumlah}",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600)), // Tambahkan jumlah
            Text("Status: ${order.status}",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue)), // Tambahkan status
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class Order {
  final String toko;
  final String platform;
  final String ekspedisi;
  final String jenis;
  final String namaItem;
  final int jumlah; // Ubah dari String ke int
  final String status; // Tambahkan status

  Order({
    required this.toko,
    required this.platform,
    required this.ekspedisi,
    required this.jenis,
    required this.namaItem,
    required this.jumlah,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      toko: json['toko'] ?? '',
      platform: json['platform'] ?? '',
      ekspedisi: json['ekspedisi'] ?? '',
      jenis: json['jenis'] ?? '',
      namaItem: json['namaItem'] ?? '',
      jumlah: json['jumlah'] != null
          ? int.tryParse(json['jumlah'].toString()) ?? 0
          : 0, // Konversi ke int
      status: json['status'] ?? '', // Tambahkan status
    );
  }
}
