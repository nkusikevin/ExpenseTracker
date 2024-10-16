import 'package:bloc/bloc.dart';
import 'package:expense_tracker/app.dart';
import 'package:expense_tracker/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}
