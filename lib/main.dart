import 'package:excel_forms_test/drift_table.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    Provider<MyDatabase>(
      create: (context) => MyDatabase(),
      child: const MaterialApp(
       title: 'homepage?',
       home: HomePage(),
     ),
      dispose: (context, db) => db.close(),
    ),
  );
}

