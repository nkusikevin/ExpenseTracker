import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

var myData = [
  {
    "name": "BigMuc",
    "icon": const FaIcon(
      FontAwesomeIcons.burger,
      color: Colors.white,
    ),
    "color": Colors.yellow[700],
    "category": "food",
    "amount": 200,
    "date": "2021-10-10"
  },
  {
    "name": "Shopping",
    "icon": const FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white),
    "color": Colors.blue[700],
    "category": "shopping",
    "amount": 800,
    "date": "2021-10-10"
  },
  {
    "name": "Transport",
    "icon": const FaIcon(FontAwesomeIcons.bus, color: Colors.white),
    "color": Colors.green[700],
    "category": "transport",
    "amount": 100,
    "date": "2021-10-10"
  },
  {
    "name": "Utilities",
    "icon": const FaIcon(FontAwesomeIcons.bolt, color: Colors.white),
    "color": Colors.orange[700],
    "category": "bills",
    "amount": 150,
    "date": "2021-10-15"
  },
  {
    "name": "Gym Membership",
    "icon": const FaIcon(FontAwesomeIcons.dumbbell, color: Colors.white),
    "color": Colors.red[700],
    "category": "health",
    "amount": 50,
    "date": "2021-10-20"
  },
  {
    "name": "Movie Night",
    "icon": const FaIcon(FontAwesomeIcons.film, color: Colors.white),
    "color": Colors.purple[700],
    "category": "entertainment",
    "amount": 30,
    "date": "2021-10-22"
  },
  {
    "name": "Groceries",
    "icon": const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
    "color": Colors.teal[700],
    "category": "food",
    "amount": 120,
    "date": "2021-10-25"
  },
];
