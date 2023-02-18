import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

Future<List<Map<String, dynamic>>> readCsvData() async {
  final csvData = await rootBundle.loadString('assets/exercise_parameters.csv');
  final List<List<dynamic>> csvTable = CsvToListConverter().convert(csvData);

  final List<Map<String, dynamic>> exercises = [];
  for (int i = 1; i < csvTable.length; i++) {
    final defaultValues = csvTable[i];
    final exercise = {
      'exercise': defaultValues[0].toString(),
      'sets': defaultValues[1].toString(),
      'weight': defaultValues[2].toString(),
      'intensity': defaultValues[3].toString(),
      'rest': defaultValues[4].toString(),
      'tempo': defaultValues[5].toString(),
    };
    exercises.add(exercise);
  }

  return exercises;
}