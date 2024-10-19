import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/components/category_tile.dart';
import 'package:expense_tracker/components/create_category.dart';
import 'package:expense_tracker/components/snackBar.dart';
import 'package:expense_tracker/screens/createExp/bloc/get_categories/get_categories_bloc.dart';
import 'package:expense_tracker/utils/icon_mapping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../bloc/create_expense/create_expense_bloc.dart';

class AddNewExp extends StatefulWidget {
  const AddNewExp({super.key});

  @override
  State<AddNewExp> createState() => _AddNewExpState();
}

class _AddNewExpState extends State<AddNewExp> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  late Expense expense;

  bool isCategoryClicked = false;
  bool isLoading = false;

  // ignore: non_constant_identifier_names
  void add_expense() {
    context.read<CreateExpenseBloc>().add(CreateExpense(expense));
  }

  @override
  void initState() {
    _dateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    context.read<GetCategoriesBloc>().add(GetCategories());
    expense = Expense.empty;
    expense.category = Category.empty;
    expense.expenseId = const Uuid().v1();
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          showCustomSnackBar(context, 'Expense added successfully', "success");
          expense = Expense.empty;
          Navigator.pop(context);
        } else if (state is CreateExpenseFailure) {
          showCustomSnackBar(context, 'Error while adding expense', "error");
        } else if (state is CreateExpenseLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                  builder: (context, state) {
                if (state is GetCategoriesSuccess) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Add  Expense',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Center(
                              child: Row(
                                children: [
                                  const Text(
                                    '\$',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.purple),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: _amountController,
                                      keyboardType: TextInputType.number,
                                      style: const TextStyle(
                                          fontSize: 24, color: Colors.purple),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '0',
                                        hintStyle: TextStyle(
                                            color:
                                                Colors.purple.withOpacity(0.5)),
                                      ),
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          expense.amount = int.parse(value);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            textAlignVertical: TextAlignVertical.center,
                            controller: _titleController,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                        
                                expense.title = value;
                              }
                            },
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon:  Icon(
                                FontAwesomeIcons.textHeight,
                                size: 16,
                                color: Colors.grey,
                              ),
                              border:  OutlineInputBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                  bottom: Radius.circular(12),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Title',
                              hintStyle:  TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            readOnly: true,
                            onTap: () => {
                              setState(() {
                                isCategoryClicked = !isCategoryClicked;
                              })
                            },
                            controller: _categoryController,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                expense.category == Category.empty
                                    ? FontAwesomeIcons.list
                                    : IconMapping.getIcon(
                                        expense.category.icon),
                                size: 16,
                                color: Colors.grey,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const CreateCategoryDialog());
                                },
                                icon: const Icon(FontAwesomeIcons.plus,
                                    size: 16, color: Colors.grey),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: const Radius.circular(12),
                                  bottom: Radius.circular(
                                      isCategoryClicked ? 0 : 12),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Category',
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: isCategoryClicked ? 180 : 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(12)),
                              ),
                              child: Column(
                                children: [
                                  if (state.categories.isEmpty)
                                    const Center(
                                      child: Text(
                                          'No categories found , add one '),
                                    )
                                  else
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: state.categories.length,
                                        itemBuilder: (context, index) {
                                          return CategoryTile(
                                            category: state.categories[index],
                                            onTap: () {
                                              setState(() {
                                                expense.category =
                                                    state.categories[index];

                                                expense.category.icon = state
                                                    .categories[index].icon;

                                                _categoryController.text = state
                                                    .categories[index].name;
                                                isCategoryClicked = false;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _dateController,
                            readOnly: true,
                            textAlignVertical: TextAlignVertical.center,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: expense.date,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _dateController.text =
                                      DateFormat("dd/MM/yyyy")
                                          .format(pickedDate);
                                  // selectedDate = pickedDate;
                                  expense.date = pickedDate;
                                });
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(FontAwesomeIcons.clock,
                                  size: 16, color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none),
                              hintText: 'Date',
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: kToolbarHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(colors: [
                                Theme.of(context).colorScheme.tertiary,
                                Theme.of(context).colorScheme.secondary,
                                Theme.of(context).colorScheme.primary,
                              ], transform: const GradientRotation(pi / 4)),
                            ),
                            child: TextButton(
                                onPressed: isLoading ? null : add_expense,
                                child: isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Text(
                                        'Save ',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      )),
                          ),
                        ],
                      ));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
              }))),
    );
  }
}
