import 'package:flutter/material.dart';

class AddNewExp extends StatelessWidget {
  const AddNewExp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Expense'),
      ),
      body: const Center(
        child: Text('Add New Expense'),
      ),
    );
  }
}
