import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:tisaneconnect/app/font_style.dart';
import 'package:tisaneconnect/app/snackbar.dart';
import 'package:tisaneconnect/ui/components/dialogs/dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomeSuperAdmin extends StatefulWidget {
  const HomeSuperAdmin({Key? key}) : super(key: key);

  @override
  _HomeSuperAdminState createState() => _HomeSuperAdminState();
}

class _HomeSuperAdminState extends State<HomeSuperAdmin> {
  final String baseUrl = 'http://103.139.193.137:5000';

  List<Map<String, dynamic>> users = [];
  bool isLoading = true;
  Map<int, bool> passwordVisibility = {};

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> fetchUsers() async {
    try {
      setState(() => isLoading = true);

      final token = await getAuthToken();
      if (token == null) {
        throw Exception('No auth token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/users'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          // Pastikan semua field diambil dengan benar
          users = data
              .map((user) => {
                    'id': user['id'],
                    'username': user['username'],
                    'password': user['password'] ?? '', // Ambil password hash
                    'role': user['role'],
                  })
              .toList();
        });
        print('Fetched users: $users'); // Debug log
      } else {
        throw Exception('Failed to fetch users: ${response.body}');
      }
    } catch (e) {
      print('Error fetching users: $e');
      Snackbar.error('Failed to load users: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _addUser() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        final usernameController = TextEditingController();
        final passwordController = TextEditingController();
        String selectedRole = 'admin'; // Default role

        return AlertDialog(
          title: const Text('Tambah User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedRole,
                items: ['admin', 'superadmin']
                    .map((role) => DropdownMenuItem<String>(
                          value: role,
                          child: Text(role),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedRole = value;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, {
                'username': usernameController.text,
                'password': passwordController.text,
                'role': selectedRole,
              }),
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      try {
        final token = await getAuthToken();
        final response = await http.post(
          Uri.parse('$baseUrl/users'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'username': result['username'],
            'password': result['password'],
            'role': result['role'],
          }),
        );

        if (response.statusCode == 201) {
          Snackbar.success('User berhasil ditambahkan');
          fetchUsers();
        } else {
          Snackbar.error(
              'Gagal menambahkan user: ${jsonDecode(response.body)['message']}');
        }
      } catch (e) {
        Snackbar.error('Terjadi kesalahan saat menambahkan user: $e');
      }
    }
  }

  Future<void> _deleteUser(int id) async {
    final confirmed = await UserDialogs.showDeleteConfirmationDialog(context);
    if (confirmed == true) {
      try {
        final token = await getAuthToken();
        final response = await http.delete(
          Uri.parse('$baseUrl/users/$id'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          Snackbar.success('User deleted successfully');
          fetchUsers();
        } else {
          Snackbar.error(
              'Failed to delete user: ${jsonDecode(response.body)['message']}');
        }
      } catch (e) {
        Snackbar.error('Error deleting user: $e');
      }
    }
  }

  Future<void> _editUser(Map<String, dynamic> user) async {
    try {
      final currentUsername = user['username']?.toString() ?? '';
      final currentPassword = user['password']?.toString() ?? '';
      final currentRole = user['role']?.toString() ?? 'admin';

      final result = await showDialog<Map<String, String>>(
        context: context,
        builder: (context) {
          final usernameController =
              TextEditingController(text: currentUsername);
          final passwordController =
              TextEditingController(text: currentPassword);
          String selectedRole = currentRole;

          return AlertDialog(
            title: const Text('Edit User'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  items: ['admin', 'superadmin']
                      .map((role) => DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      selectedRole = value;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, {
                  'username': usernameController.text,
                  'password': passwordController.text,
                  'role': selectedRole,
                }),
                child: const Text('Simpan'),
              ),
            ],
          );
        },
      );

      if (result != null) {
        final token = await getAuthToken();
        final response = await http.put(
          Uri.parse('$baseUrl/users/${user['id']}'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'username': result['username'],
            'password': result['password'],
            'role': result['role'],
          }),
        );

        if (response.statusCode == 200) {
          Snackbar.success('User berhasil diperbarui');
          fetchUsers();
        } else {
          throw Exception(
              json.decode(response.body)['message'] ?? 'Unknown error');
        }
      }
    } catch (e) {
      print('Error in _editUser: $e');
      Snackbar.error('Gagal memperbarui user: $e');
    }
  }

  Widget _buildPasswordCell(Map<String, dynamic> user) {
    // Ambil password dari data user
    final storedPassword = user['password']?.toString() ?? '';

    return Row(
      children: [
        Expanded(
          child: Text(
            storedPassword.isNotEmpty ? storedPassword : '(Belum ada password)',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Monospace', // Agar hash password lebih mudah dibaca
              fontSize: 13,
            ),
          ),
        ),
        // Tambahkan tombol copy jika diperlukan
        if (storedPassword.isNotEmpty)
          IconButton(
            icon: Icon(Icons.copy, size: 20),
            onPressed: () {
              // Copy password ke clipboard
              Clipboard.setData(ClipboardData(text: storedPassword));
              Snackbar.success('Password berhasil disalin');
            },
            tooltip: 'Salin password',
          ),
      ],
    );
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
                  SizedBox(height: screenHeight() * 0.1),
                  Text(
                    "Data Pengguna",
                    style: StyleAsset.bold(fontSize: 30),
                  ),
                  SizedBox(height: 30),
                  if (isLoading)
                    CircularProgressIndicator()
                  else
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Username')),
                        DataColumn(label: Text('Password')),
                        DataColumn(label: Text('Role')),
                        DataColumn(label: Text('Actions')),
                      ],
                      rows: users.map((user) {
                        return DataRow(cells: [
                          DataCell(Text(user['id'].toString())),
                          DataCell(Text(user['username'])),
                          DataCell(_buildPasswordCell(user)),
                          DataCell(Text(user['role'])),
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

  @override
  void dispose() {
    super.dispose();
  }
}
