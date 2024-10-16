import 'package:expense_repository/src/entities/category_entity.dart';
import 'package:flutter/material.dart';

class Category {
  String categoryId;
  String name;
  int totalExpenses;
  IconData icon;
  int color;

  Category({
    required this.categoryId,
    required this.name,
    required this.totalExpenses,
    required this.icon,
    required this.color,
  });

  static final empty =
      Category(
        categoryId: '', 
        name: '', 
        totalExpenses: 0, 
        icon: Icons.question_answer , 
        color: 0);

  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryId: categoryId,
      name: name,
      totalExpenses: totalExpenses,
      icon: '',
      color: color,
    );
  }

  static Category fromEntity(CategoryEntity entity) {
    return Category(
      categoryId: entity.categoryId,
      name: entity.name,
      totalExpenses: entity.totalExpenses,
      icon: IconData(int.parse(entity.icon), fontFamily: 'MaterialIcons'),
      color: entity.color,
    );
  }
}
