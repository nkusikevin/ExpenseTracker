import 'dart:math';

import 'package:expense_tracker/components/expenses_tile.dart';
import 'package:expense_tracker/screens/home/data/data.dart';
import 'package:expense_tracker/utils/icon_mapping.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../blocs/get_expenses/get_expenses_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {




  @override
  void initState() {
   context.read<GetExpensesBloc>().add(GetExpenses());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.yellow[700]),
                      ),
                      Image.asset('assets/images/2.png' , width: 50, height: 50,),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome!',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.outline)),
                      Text('John Doe',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onSurface)),
                    ],
                  ),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  
                  color: Colors.white
                ),
                child: Icon(CupertinoIcons.settings,
                    size: 30, color: Theme.of(context).colorScheme.outline),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 10),
                  blurRadius: 10,
                ),
              ],
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary,
              ], transform: const GradientRotation(pi / 4)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Total Balance',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white)),
                  const Text("\$ 10,000.00",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.white)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white30),
                            child:  Icon(CupertinoIcons.arrow_up,
                                size: 12, color: Colors.lightGreenAccent[400]),
                          ),
                          const SizedBox(width: 10),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Income',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.white)),
                              Text("\$ 1,000.00",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white30),
                            child: const Icon(CupertinoIcons.arrow_down,
                                size: 12, color: Color.fromARGB(255, 255, 40, 40)),
                          ),
                          const SizedBox(width: 10),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Expense',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.white)),
                              Text("\$ 500.00",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Transactions',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface)),
              GestureDetector(
                onTap: () {
                  context.read<GetExpensesBloc>().add(GetExpenses());
                },
                child: Text('Sync all',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.outline)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BlocBuilder<GetExpensesBloc, GetExpensesState>(
              builder: (context, state) {
            if (state is GetExpensesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetExpensesFailed) {
              return const Center(child: Text('Failed to load expenses'));
            } else if (state is GetExpensesSuccess) {
              return Expanded(
              child: ListView.builder(
                itemCount: state.expenses.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return ExpensesTile(
                    name: state.expenses[index].title,
                    category: state.expenses[index].category.name,
                    amount: state.expenses[index].amount.toInt(),
                    date: state.expenses[index].date.toString(),
                    icon: FaIcon(
                        IconMapping.getIcon(state.expenses[index].category.icon),
                        color: Colors.white,
                      ),
                    color: Color(state.expenses[index].category.color),
                  );
                },
              ),
            );
            } else {
              return const SizedBox();
            }
          })
        ],
      ),
    );
  }
}
