import 'package:flutter/material.dart';

showCustomSnackBar(BuildContext context, String message, String snackType) {
  Color backgroundColor;
  IconData icon;

  switch (snackType) {
    case 'success':
      backgroundColor = Colors.green;
      icon = Icons.check_circle;
      break;
    case 'error':
      backgroundColor = Colors.red;
      icon = Icons.error;
      break;
    case 'warning':
      backgroundColor = Colors.orange;
      icon = Icons.warning;
      break;
    case 'info':
      backgroundColor = Colors.blue;
      icon = Icons.info;
      break;
    default:
      backgroundColor = Colors.grey;
      icon = Icons.info_outline;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
