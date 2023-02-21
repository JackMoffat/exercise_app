import 'package:drift/drift.dart';

// here, this is an example and we are following this link:
// https://drift.simonbinder.eu/docs/getting-started/

part 'drift_table.dart';

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

}
