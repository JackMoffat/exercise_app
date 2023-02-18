import 'package:flutter/material.dart';
import 'exercise_screen.dart';
import 'csv_util.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> exerciseData = [];

  @override
  void initState() {
    super.initState();
    readCsvData().then((data) {
      setState(() {
        exerciseData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise App'),
      ),
      body: ListView.builder(
        itemCount: exerciseData.length,
        itemBuilder: (context, index) {
          final exercise = exerciseData[index];
          return ListTile(
            title: Text(exercise['exercise']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseScreen(exercise: exercise),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
