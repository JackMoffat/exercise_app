import 'package:flutter/material.dart';
import 'form_widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Column(
        children: [
          Text('Welcome to my app!'),
          FormWidgetsDemo(),
        ],
      ),
    );
  }
}
