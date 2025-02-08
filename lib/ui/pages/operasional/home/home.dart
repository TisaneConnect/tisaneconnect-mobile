import 'package:flutter/material.dart';

class HomeOperasional extends StatefulWidget {
  const HomeOperasional({super.key});

  @override
  State<HomeOperasional> createState() => _HomeOperasionalState();
}

class _HomeOperasionalState extends State<HomeOperasional> {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}

enum OrderStatus { Done, Process, Canceled }

class Order {
  final String id;
  String description;
  OrderStatus status;

  Order({required this.id, required this.description, required this.status});
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Order> orders = [
    Order(id: "1", description: "Order 1", status: OrderStatus.Done),
    Order(id: "2", description: "Order 2", status: OrderStatus.Process),
    Order(id: "3", description: "Order 3", status: OrderStatus.Canceled),
    Order(id: "4", description: "Order 4", status: OrderStatus.Process),
    Order(id: "5", description: "Order 5", status: OrderStatus.Process),
    Order(id: "6", description: "Order 6", status: OrderStatus.Process),
    Order(id: "7", description: "Order 7", status: OrderStatus.Process),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text("ORDER LIST"),
        backgroundColor: Colors.green[300],
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          buildOrderSection(context, "Done", OrderStatus.Done),
          buildOrderSection(context, "Process", OrderStatus.Process),
          buildOrderSection(context, "Canceled", OrderStatus.Canceled),
        ],
      ),
    );
  }

  Widget buildOrderSection(
      BuildContext context, String title, OrderStatus status) {
    List<Order> filteredOrders =
        orders.where((order) => order.status == status).toList();
    List<Order> limitedOrders =
        filteredOrders.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (filteredOrders.length > 3)
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderListScreen(
                        status: status,
                        orders: filteredOrders, // Semua data ditampilkan
                        onUpdate: (updatedOrder) {
                          setState(() {
                            for (var order in orders) {
                              if (order.id == updatedOrder.id) {
                                order.status = updatedOrder.status;
                              }
                            }
                          });
                        },
                      ),
                    ),
                  );
                },
                child: Text("View All"),
              ),
          ],
        ),
        ...limitedOrders.map((order) => buildOrderItem(order)).toList(),
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
          SizedBox(height: 10),
          if (order.status == OrderStatus.Process)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  order.status = OrderStatus.Done;
                });
              },
              child: Text("Mark as Done"),
            ),
        ],
      ),
    );
  }
}

class OrderListScreen extends StatefulWidget {
  final OrderStatus status;
  final List<Order> orders;
  final Function(Order) onUpdate;

  OrderListScreen(
      {required this.status, required this.orders, required this.onUpdate});

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late List<Order> filteredOrders;

  @override
  void initState() {
    super.initState();
    filteredOrders = List.from(widget.orders); // Salin data agar bisa diubah
  }

  @override
  Widget build(BuildContext context) {
    String statusTitle = widget.status.toString().split('.').last.toUpperCase();

    return Scaffold(
      appBar: AppBar(title: Text("Orders - $statusTitle")),
      body: filteredOrders.isEmpty
          ? Center(child: Text("No Orders Available"))
          : ListView(
              padding: EdgeInsets.all(16),
              children:
                  filteredOrders.map((order) => buildOrderItem(order)).toList(),
            ),
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
          SizedBox(height: 10),
          if (order.status == OrderStatus.Process)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  order.status = OrderStatus.Done;
                  filteredOrders
                      .remove(order); 
                });
                widget.onUpdate(order); 
              },
              child: Text("Mark as Done"),
            ),
        ],
      ),
    );
  }
}
