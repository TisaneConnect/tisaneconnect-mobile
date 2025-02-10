import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeOperasional extends StatefulWidget {
  @override
  _HomeOperasionalState createState() => _HomeOperasionalState();
}

class _HomeOperasionalState extends State<HomeOperasional> {
  late Future<List<Order>> futureOrders;

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  void loadOrders() {
    setState(() {
      futureOrders = fetchOrders();
    });
  }

  Future<List<Order>> fetchOrders() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    try {
      final response = await http.get(
        Uri.parse("http://103.139.193.137:5000/process"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);

        List<Order> orders =
            jsonResponse.map((data) => Order.fromJson(data)).toList();

        print("Fetched Orders: ${orders.length}");

        return orders;
      } else {
        throw Exception('Failed to load orders: ${response.body}');
      }
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text("ORDER LIST"),
        backgroundColor: Colors.green[300],
        centerTitle: true,
      ),
      body: FutureBuilder<List<Order>>(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading data"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Orders Available"));
          } else {
            List<Order> orders = snapshot.data!;

            List<Order> doneOrders =
                orders.where((order) => order.status == "Done").toList();
            List<Order> processOrders =
                orders.where((order) => order.status == "Process").toList();

            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                if (processOrders.isNotEmpty)
                  buildOrderSection(context, "Process", processOrders),
                if (doneOrders.isNotEmpty)
                  buildOrderSection(context, "Done", doneOrders),
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildOrderSection(
      BuildContext context, String title, List<Order> orders) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title (${orders.length})",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        SizedBox(height: 8),
        ...orders.map((order) => buildOrderItem(order)).toList(),
        SizedBox(height: 16),
      ],
    );
  }

  Widget buildOrderItem(Order order) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(order.description,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          SizedBox(height: 5),
          Text("Toko: ${order.toko}", style: TextStyle(fontSize: 14)),
          Text("Platform: ${order.platform}",
              style: TextStyle(fontSize: 14)), // Tambahkan platform
          Text("Ekspedisi: ${order.ekspedisi}", style: TextStyle(fontSize: 14)),
          Text("Jenis: ${order.jenis}", style: TextStyle(fontSize: 14)),
          Text("Item: ${order.namaItem}", style: TextStyle(fontSize: 14)),
          SizedBox(height: 5),
          Text(
            "Status: ${order.status}",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          ),
          SizedBox(height: 5),
          Text(
            "Jumlah: ${order.quantity}",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          if (order.status == "Process")
            ElevatedButton(
              onPressed: () => markAsDone(order.id),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Text("Mark as Done"),
            ),
        ],
      ),
    );
  }

  Future<void> markAsDone(String orderId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    try {
      final response = await http.put(
        Uri.parse("http://103.139.193.137:5000/process/done/$orderId"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          loadOrders();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Order #$orderId marked as Done!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update order: ${response.body}")),
        );
      }
    } catch (e) {
      print("Error updating order: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating order")),
      );
    }
  }
}

class Order {
  final String id;
  final String description;
  final String status;
  final int quantity;
  final String toko;
  final String platform;
  final String ekspedisi;
  final String jenis;
  final String namaItem;

  Order({
    required this.id,
    required this.description,
    required this.status,
    required this.quantity,
    required this.toko,
    required this.platform,
    required this.ekspedisi,
    required this.jenis,
    required this.namaItem,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'].toString(),
      description: "Order ${json['id']}",
      status: json['status'],
      quantity: json['jumlah'] ?? 0,
      toko: json['nama_toko'] ?? 'Unknown',
      platform: json['nama_platform'] ?? 'Unknown', // Tambahkan platform
      ekspedisi: json['nama_ekspedisi'] ?? 'Unknown',
      jenis: json['jenis'] ?? 'Unknown',
      namaItem: json['nama_item'] ?? 'Unknown',
    );
  }
}
