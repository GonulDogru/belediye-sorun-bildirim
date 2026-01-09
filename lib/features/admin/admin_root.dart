import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'admin_issue_list_page.dart';
import '../auth/login_page.dart';

class AdminRoot extends StatelessWidget {
  const AdminRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belediye Paneli'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // 🔴 ÇIKIŞ
              Hive.box('session').clear();
              Hive.box('profile').clear();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (_) => false,
              );
            },
          ),
        ],
      ),
      body: const AdminIssueListPage(),
    );
  }
}
