import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

class ExerciseForm extends StatefulWidget {
  final String exercise;
  final String sets;
  final String weight;
  final String intensity;
  final String rest;
  final String tempo;

  ExerciseForm({
    Key? key,
    required this.exercise,
    required this.sets,
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
  late List<GlobalKey<FormState>> _formKeys;

  // Define a list to keep track of the form state for each page
  late List<Map<String, dynamic>> _savedValues;

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


  Widget _buildForm(BuildContext context, int index) {
    return Form(
      key: _formKeys[index],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Set ${index + 1}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Exercise',
                  ),
                  initialValue: _savedValues[index]['exercise'],
                  onSaved: (value) =>
                  _savedValues[index]['exercise'] = value,
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
                  onSaved: (value) =>
                  _savedValues[index]['intensity'] = value,
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
          ),
        ],
      ),
    );
  }

  void _submitForms() {
    // Validate and save each form
    for (int i = 0; i < _formKeys.length; i++) {
      final form = _formKeys[i].currentState;
      if (form != null) {
        if (form.validate()) {
          form.save();
          _savedValues[i]['exercise'] = _savedValues[i]['exercise'] ?? widget.exercise;
        }
      }
    }
    Navigator.pop(context, _savedValues);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Set ${_savedValues.indexOf(_savedValues.last) + 1} of ${_savedValues.length}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: _formKeys.length,
              itemBuilder: (context, index) {
                return _buildForm(context, index);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForms,
        child: Icon(Icons.save),
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