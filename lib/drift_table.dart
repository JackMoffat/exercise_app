import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// here, this is an example and we are following this link:
// https://drift.simonbinder.eu/docs/getting-started/

part 'drift_table.g.dart';

// generates a table called "todos".
// rows of the table are represented by a class called "Todo"
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
  IntColumn get category => integer().nullable()();
}

// makes a class called "Category" that represents a row in the table.
// by default...categorie would have been used because it only strips the
// trailing s in the table name....what?
// ohhh, between dataclassname and the name of the class categories we just defined
@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
}

// this tells drift to prep a database class that uses both of the tables we just defined
// we will see how to use it in a moment
// what is this syntax? "_$"
// "by convention generated code starts with "_$" to mark it as private and generated."
@DriftDatabase(tables: [Todos, Categories])
class MyDatabase extends _$MyDatabase {
  // tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());
  // increase this number whenever you change or add a table definition: why?

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // this LazyDatabase utility lets us find the right location for the file async
  return LazyDatabase(() async {
    // put the database file (here called db.sqlite) here, into the documents folder for your app
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}


