import 'package:flutter/material.dart';
import 'package:excel_forms_test/exercise_form.dart';

class ExerciseScreen extends StatelessWidget {
  final Map<String, dynamic> exercise;

  const ExerciseScreen({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(exercise['exercise'])),
      body: ExerciseForm(
        exercise: exercise['exercise'],
        sets: exercise['sets'],
        weight: exercise['weight'],
        intensity: exercise['intensity'],
        rest: exercise['rest'],
        tempo: exercise['tempo'],
      ),
    );
  }
}
