import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

class ExerciseForm extends StatefulWidget {
  final String exercise;
  // final String sets;
  final String weight;
  final String intensity;
  final String rest;
  final String tempo;

  ExerciseForm({
    required Key key,
    required this.exercise,
    // required this.sets,
    required this.weight,
    required this.intensity,
    required this.rest,
    required this.tempo,
  }) : super(key: key);

  @override
  _ExerciseFormState createState() => _ExerciseFormState();
}

class _ExerciseFormState extends State<ExerciseForm> {
  // Define a list of form keys to keep track of the form state for each page
  List<GlobalKey<FormState>> _formKeys;

  // Define a list to keep track of the form state for each page
  List<Map<String, dynamic>> _savedValues;

  @override
  void initState() {
    super.initState();
    _formKeys = List.generate(
      int.parse(widget.sets),
          (_) => GlobalKey<FormState>(),
    );
    _savedValues = List.generate(
      int.parse(widget.sets),
          (_) => {
        'exercise': widget.exercise,
        'weight': widget.weight,
        'intensity': widget.intensity,
        'rest': widget.rest,
        'tempo': widget.tempo,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise),
      ),
      body: PageView.builder(
        itemCount: int.parse(widget.sets),
        itemBuilder: (context, index) {
          return _buildForm(index);
        },
      ),
    );
  }

  Widget _buildForm(int index) {
    return Form(
      key: _formKeys[index],
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Exercise',
            ),
            initialValue: _savedValues[index]['exercise'],
            onSaved: (value) => _savedValues[index]['exercise'] = value,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Weight',
            ),
            initialValue: _savedValues[index]['weight'],
            onSaved: (value) => _savedValues[index]['weight'] = value,
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Intensity',
            ),
            initialValue: _savedValues[index]['intensity'],
            onSaved: (value) => _savedValues[index]['intensity'] = value,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Rest',
            ),
            initialValue: _savedValues[index]['rest'],
            onSaved: (value) => _savedValues[index]['rest'] = value,
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Tempo',
            ),
            initialValue: _savedValues[index]['tempo'],
            onSaved: (value) => _savedValues[index]['tempo'] = value,
          ),
        ],
      ),
    );
  }
}

Future<List<dynamic>> readCsvData() async {
  final csvData = await rootBundle.loadString('assets/exercise_parameters.csv');
  final List<List<dynamic>> csvTable = CsvToListConverter().convert(csvData);
  final defaultValues = csvTable[1];
  return defaultValues;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final defaultValues = await readCsvData();

  runApp(MaterialApp(
    home: ExerciseForm(
      exercise: defaultValues[0],
      sets: defaultValues[1].toString(),
      weight: defaultValues[2].toString(),
      intensity: defaultValues[3],
      rest: defaultValues[4].toString(),
      tempo: defaultValues[5],
    ),
  ));
}