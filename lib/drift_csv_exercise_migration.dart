// Ok so TODO: use the template of this file, apply it to my previously example-defined
// exercise_documentation.dart file, and use it to make this work
import 'package:drift/drift.dart';
import 'dart:io';
import 'dart:convert';
import 'package:csv/csv.dart';

// Define the database schema by creating a Table object for the "exercises" table.
// The Table object should have a IntColumn for the "id" column and TextColumn for the other columns. For example:
class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get exercise => text()();
  TextColumn get sets => text()();
  TextColumn get weight => text()();
  TextColumn get intensity => text()();
  TextColumn get rest => text()();
  TextColumn get tempo => text()();
  TextColumn get comment => text()();
}

// Create a Migration object to read the data from the CSV file and insert it
// into the database. For example:
class ExerciseMigration extends Migration {
  @override
  Future<void> migrate(DataMigrationContext context) async {
    final file = File('exercises.csv');
    final input = await file.readAsString();
    final rows = const CsvToListConverter().convert(input);

    await context.transaction(() async {
      for (final row in rows) {
        await context.into(exercises).insert(ExercisesCompanion(
          exercise: Value(row['exercise'] as String),
          sets: Value(row['sets'] as String),
          weight: Value(row['weight'] as String),
          intensity: Value(row['intensity'] as String),
          rest: Value(row['rest'] as String),
          tempo: Value(row['tempo'] as String),
          comment: Value(row['comment'] as String),
        ));
      }
    });
  }
}

// Create a Migration object to apply the migration to the database. For example:
class ExerciseDatabase extends MigrationDatabase {
  ExerciseDatabase() : super(2);

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from == 1) {
        await ExerciseMigration().migrate(this);
      }
    },
  );
}

Future<void> main() async {
  final database = ExerciseDatabase();
  await database.ensureOpen();
  await database.migration.upgradeIfNeeded();
}