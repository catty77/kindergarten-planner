import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('管理员面板')),
      body: const Center(child: Text('管理员功能区域')),
    );
  }
}
