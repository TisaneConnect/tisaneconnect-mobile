import 'package:flutter/material.dart';

class UserDialogs {
  static Future<Map<String, String>?> showAddUserDialog(
    BuildContext context, {
    String title = 'Add New User',
    String usernameHint = 'Username',
    String passwordHint = 'Password',
    Color? backgroundColor,
    TextStyle? titleStyle,
    TextStyle? inputStyle,
    ButtonStyle? cancelButtonStyle,
    ButtonStyle? confirmButtonStyle,
  }) {
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();

    return showDialog<Map<String, String>>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor,
        title: Text(
          title,
          style: titleStyle ?? TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _usernameController,
              style: inputStyle,
              decoration: InputDecoration(
                hintText: usernameHint,
                hintStyle: inputStyle?.copyWith(color: Colors.grey),
              ),
            ),
            TextField(
              controller: _passwordController,
              style: inputStyle,
              obscureText: true,
              decoration: InputDecoration(
                hintText: passwordHint,
                hintStyle: inputStyle?.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            style: cancelButtonStyle,
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: confirmButtonStyle,
            onPressed: () {
              Navigator.pop(context, {
                'username': _usernameController.text,
                'password': _passwordController.text,
              });
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  static Future<Map<String, String>?> showEditUserDialog(
    BuildContext context,
    String currentUsername,
    String currentPassword, {
    String title = 'Edit User',
    String usernameHint = 'Username',
    String passwordHint = 'Password',
    Color? backgroundColor,
    TextStyle? titleStyle,
    TextStyle? inputStyle,
    ButtonStyle? cancelButtonStyle,
    ButtonStyle? confirmButtonStyle,
  }) {
    final _usernameController = TextEditingController(text: currentUsername);
    final _passwordController = TextEditingController(text: currentPassword);

    return showDialog<Map<String, String>>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor,
        title: Text(
          title,
          style: titleStyle ?? TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _usernameController,
              style: inputStyle,
              decoration: InputDecoration(
                hintText: usernameHint,
                hintStyle: inputStyle?.copyWith(color: Colors.grey),
              ),
            ),
            TextField(
              controller: _passwordController,
              style: inputStyle,
              obscureText: true,
              decoration: InputDecoration(
                hintText: passwordHint,
                hintStyle: inputStyle?.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            style: cancelButtonStyle,
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: confirmButtonStyle,
            onPressed: () {
              Navigator.pop(context, {
                'username': _usernameController.text,
                'password': _passwordController.text,
              });
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  static Future<bool?> showDeleteConfirmationDialog(
    BuildContext context, {
    String title = 'Delete User',
    String content = 'Are you sure you want to delete this user?',
    Color? backgroundColor,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
    ButtonStyle? cancelButtonStyle,
    ButtonStyle? confirmButtonStyle,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor,
        title: Text(
          title,
          style: titleStyle ?? TextStyle(),
        ),
        content: Text(
          content,
          style: contentStyle,
        ),
        actions: [
          TextButton(
            style: cancelButtonStyle,
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: confirmButtonStyle,
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
