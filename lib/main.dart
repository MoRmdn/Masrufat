// ignore_for_file: use_key_in_widget_constructors

import 'Screens/add_account.dart';
import 'Screens/home_screen.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// useing variable instead of  ThemeData().copyWith(
      /// theme: ThemeData().colorSchema.copyWith(
      /// primary:,
      /// Secondary:,
      ///  )
      /// )
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.indigo,
          secondary: Colors.amber,
        ),
      ),
      title: 'Masroufat',

      home: const HomeScreen(),
      routes: {
        HomeScreen.routeNamed: (ctx) => HomeScreen(),
        AddAccount.routeNamed: (ctx) => AddAccount(),
      },
    );
  }
}
