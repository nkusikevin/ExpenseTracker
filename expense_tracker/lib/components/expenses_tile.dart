import 'package:flutter/material.dart';

class ExpensesTile extends StatelessWidget {
  final String name;
  final String category;
  final double amount;
  final String date;
  final IconData icon;
  const ExpensesTile({super.key , required this.name, required this.category, required this.amount, required this.date , required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.yellow[600],
                ),
                child: Icon( icon, size: 30, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$ $amount',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface)),
              Text(date,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.outline)),
            ],
          ),
        ],
      ),
    );
    ;
  }
}