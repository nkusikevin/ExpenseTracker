import 'dart:math';
import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/screens/createExp/views/add_new_exp.dart';
import 'package:expense_tracker/screens/home/blocs/get_expenses/get_expenses_bloc.dart';
import 'package:expense_tracker/screens/stats/views/stats_view.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:expense_tracker/screens/home/views/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../createExp/bloc/create_category/create_category_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void _refreshExpenses() {
    context.read<GetExpensesBloc>().add(GetExpenses());
  }



  var wigetList = [
    MainScreen(),
    StatsScreen(),
  ];
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _index == 0 ? SafeArea(
        child: MainScreen()
        ) : SafeArea(child: StatsScreen()),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
            currentIndex: _index,
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
            backgroundColor: Colors.white,
            elevation: 3,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FluentIcons.home_24_regular),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chart_bar_alt_fill),
                label: 'Stats',
              ),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => AddNewExp(onExpenseAdded: _refreshExpenses)),
          );
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary,
              ],
              transform: const GradientRotation(pi/4)
            ),
          ),
          child: const Icon(CupertinoIcons.add)),
      ),
    );
  }
}
