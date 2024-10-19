import 'package:expense_repository/expense_repository.dart';

class Expense {
  String expenseId;
  String title;
  Category category;
  DateTime date;
  int amount;

  Expense({
    required this.expenseId,
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
  });

  static final empty = Expense(
    expenseId: '',
    title: '',
    category: Category.empty,
    date: DateTime.now(),
    amount: 0,
  );

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      expenseId: expenseId,
      title: title,
      category: category,
      date: date,
      amount: amount,
    );
  }

  static Expense fromEntity(ExpenseEntity entity) {
    return Expense(
      expenseId: entity.expenseId,
      title: entity.title,
      category: entity.category,
      date: entity.date,
      amount: entity.amount,
    );
  }
}
