import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text('No new notifications'),
      ),
    );
  }
}