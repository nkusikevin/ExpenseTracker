import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expense_tracker/utils/icon_mapping.dart'; // Add this import

class CategoryTile extends StatelessWidget {
  final void Function()? onTap;
  final Category category;

  const CategoryTile({super.key, required this.onTap, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 250, 249, 249),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(category.color),
          ),
          child: FaIcon(
            IconMapping.getIcon(category.icon),
            color: Colors.white,
          ),
        ),
        title: Text(category.name , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),),
        onTap: onTap,
      ),
    );
  }
}
