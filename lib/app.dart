import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/screens/createExp/bloc/get_categories/get_categories_bloc.dart';
import 'package:expense_tracker/screens/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/createExp/bloc/create_category/create_category_bloc.dart';
import 'screens/createExp/bloc/create_expense/create_expense_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ExpenseRepository>(
      create: (context) => FirebaseExpenseRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CreateCategoryBloc(
              context.read<ExpenseRepository>(),
            ),
          ),
          BlocProvider(
              create: (context) => GetCategoriesBloc(
                    context.read<ExpenseRepository>(),
                  )),
          BlocProvider(
              create: (context) =>
                  CreateExpenseBloc(context.read<ExpenseRepository>())),
        ],
        child: MaterialApp(
          title: 'Expense Tracker',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.light(
              surface: Colors.grey.shade100,
              onSurface: Colors.black,
              primary: Color(0xFF00B2E7),
              secondary: Color(0xFFE064F7),
              tertiary: Color(0xFFFF8D6c),
              outline: Colors.grey,
            ),
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
