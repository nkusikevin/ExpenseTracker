import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/components/create_category.dart';
import 'package:expense_tracker/components/snackBar.dart';
import 'package:expense_tracker/screens/createExp/bloc/get_categories/get_categories_bloc.dart';
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
  TextEditingController _amountController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  late Expense expense;

  bool isCategoryClicked = false;
  bool isLoading = false;

  void add_expense() {
    context.read<CreateExpenseBloc>().add(CreateExpense(expense));
  }

  @override
  void initState() {
    _dateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    context.read<GetCategoriesBloc>().add(GetCategories());
    expense = Expense.empty;
    expense.expenseId = const Uuid().v1();
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          showCustomSnackBar(context, 'Expense added successfully' ,"success");
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextField(
                              controller: _amountController,
                              onChanged: (value) {
                                setState(() {
                                  expense.amount = int.parse(value);
                                });
                              },
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(
                                    FontAwesomeIcons.dollarSign,
                                    size: 16,
                                    color: Colors.grey),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                              ),
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
                              fillColor: expense.category == Category.empty
                                  ? Colors.white
                                  : Color(expense.category.color),
                              prefixIcon: Icon(
                                isCategoryClicked
                                    ? FontAwesomeIcons.chevronDown
                                    : FontAwesomeIcons.chevronUp,
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
                                  top: Radius.circular(12),
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
                                          return Card(
                                            color: Color(
                                                state.categories[index].color),
                                            child: ListTile(
                                              leading: Icon(
                                                  color: Colors.white,
                                                  state.categories[index].icon),
                                              title: Text(
                                                  state.categories[index].name),
                                              onTap: () {
                                                setState(() {
                                                  expense.category =
                                                      state.categories[index];
                                                  _categoryController.text =
                                                      state.categories[index]
                                                          .name;
                                                  isCategoryClicked = false;
                                                });
                                              },
                                            ),
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
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: kToolbarHeight,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                add_expense();
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
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
