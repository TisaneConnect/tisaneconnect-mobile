import 'package:flutter/material.dart';
import 'package:tisaneconnect/app/color.dart';
class Product extends StatelessWidget {
  final String jenis;

  const Product({super.key, required this.jenis});

  @override
  Widget build(BuildContext context) {
    // Simulasi data, ganti dengan data dari database
    final List<Order> orders =
        dummyOrders.where((o) => o.jenis == jenis).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Items - $jenis"),
        backgroundColor: Colors.green[300],
        centerTitle: true,
      ),
      backgroundColor: ColorAssets.background,
      body: ListView.builder(
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
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.description,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            Text("Toko: ${order.toko}", style: TextStyle(fontSize: 14)),
            Text("Platform: ${order.platform}", style: TextStyle(fontSize: 14)),
            Text("Ekspedisi: ${order.ekspedisi}",
                style: TextStyle(fontSize: 14)),
            Text("Jenis: ${order.jenis}", style: TextStyle(fontSize: 14)),
            Text("Item: ${order.namaItem}", style: TextStyle(fontSize: 14)),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

// Simulasi model Order, ganti dengan model dari database
class Order {
  final String description;
  final String toko;
  final String platform;
  final String ekspedisi;
  final String jenis;
  final String namaItem;

  Order({
    required this.description,
    required this.toko,
    required this.platform,
    required this.ekspedisi,
    required this.jenis,
    required this.namaItem,
  });
}

// Dummy Data
List<Order> dummyOrders = [
  Order(
      description: "Herbal A",
      toko: "Toko A",
      platform: "Shopee",
      ekspedisi: "JNE",
      jenis: "Raw Herbal",
      namaItem: "Jahe"),
  Order(
      description: "Tea B",
      toko: "Toko B",
      platform: "Tokopedia",
      ekspedisi: "SiCepat",
      jenis: "Tea House",
      namaItem: "Green Tea"),
];
