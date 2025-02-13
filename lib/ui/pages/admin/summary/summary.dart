import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/navigation.dart';
import 'package:tisaneconnect/ui/components/button/primary_button.dart';
import 'package:tisaneconnect/ui/pages/operasional/summary/product.dart';

class SummaryOperasional extends StatefulWidget {
  const SummaryOperasional({super.key});

  @override
  State<SummaryOperasional> createState() => _SummaryOperasionalState();
}

class _SummaryOperasionalState extends State<SummaryOperasional> {
  List<String> jenisList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJenis();
  }

  Future<void> fetchJenis() async {
    final String apiUrl = "http://103.139.193.137:5000/jenis";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        setState(() {
          jenisList =
              data.map<String>((item) => item["jenis"].toString()).toList();
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error fetching jenis: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ORDER SUMMARY"),
        backgroundColor: Colors.green[300],
        centerTitle: true,
      ),
      backgroundColor: ColorAssets.background,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : jenisList.isEmpty
              ? Center(child: Text("No categories available"))
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(top: 50),
                        child: Column(
                          children: jenisList.map((jenis) {
                            return Column(
                              children: [
                                PrimaryButton(
                                  label: jenis,
                                  radius: 20,
                                  onTap: () {
                                    nav.goPush(Product(jenis: jenis));
                                  },
                                ),
                                SizedBox(height: 20),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
