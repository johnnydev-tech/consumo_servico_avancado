import 'package:flutter/material.dart';
import 'Home.dart';

void main() => runApp(
    MaterialApp(
      theme: new ThemeData(primaryColor: Colors.lightBlue, accentColor: Colors.lightBlueAccent ),
        debugShowCheckedModeBanner: false,
    home: Home(),
));
