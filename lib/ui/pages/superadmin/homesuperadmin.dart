import 'package:flutter/material.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:tisaneconnect/app/font_style.dart';
import 'package:tisaneconnect/ui/components/dialogs/dialog.dart';

class HomeSuperAdmin extends StatefulWidget {
  @override
  _HomeSuperAdminState createState() => _HomeSuperAdminState();
}

class _HomeSuperAdminState extends State<HomeSuperAdmin> {
  List<Map<String, dynamic>> users = [
    {'id': 1, 'username': 'admin1', 'password': '****'},
    {'id': 2, 'username': 'user2', 'password': '****'},
  ];

  void _addUser() async {
    final result = await UserDialogs.showAddUserDialog(context);
    if (result != null) {
      setState(() {
        users.add({
          'id': users.length + 1,
          'username': result['username']!,
          'password': result['password']!,
        });
      });
    }
  }

  void _deleteUser(int id) async {
    final confirmed = await UserDialogs.showDeleteConfirmationDialog(context);
    if (confirmed == true) {
      setState(() {
        users.removeWhere((user) => user['id'] == id);
      });
    }
  }

  void _editUser(Map<String, dynamic> user) async {
    final result = await UserDialogs.showEditUserDialog(
        context, user['username'], user['password']);
    if (result != null) {
      setState(() {
        final index = users.indexWhere((u) => u['id'] == user['id']);
        users[index] = {
          'id': user['id'],
          'username': result['username']!,
          'password': result['password']!,
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Text(
                    "Data Pengguna",
                    style: StyleAsset.bold(fontSize: 30),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  DataTable(
                    columns: [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Username')),
                      DataColumn(label: Text('Password')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: users.map((user) {
                      return DataRow(cells: [
                        DataCell(Text(user['id'].toString())),
                        DataCell(Text(user['username'])),
                        DataCell(Text(user['password'])),
                        DataCell(Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => _editUser(user),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteUser(user['id']),
                            ),
                          ],
                        )),
                      ]);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        child: Icon(Icons.add),
      ),
    );
  }
}
