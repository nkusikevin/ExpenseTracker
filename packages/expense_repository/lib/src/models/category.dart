import 'package:expense_repository/src/entities/category_entity.dart';

class Category {
  String categoryId;
  String name;
  String icon;
  int color;

  Category({
    required this.categoryId,
    required this.name,
    required this.icon,
    required this.color,
  });

  static final empty = Category(
      categoryId: '',
      name: '',
      icon: 'question',
      color: 0);

  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryId: categoryId,
      name: name,
      icon: icon,
      color: color,
    );
  }

  static Category fromEntity(CategoryEntity entity) {
    return Category(
      categoryId: entity.categoryId,
      name: entity.name,
      icon: entity.icon,
      color: entity.color,
    );
  }
}
