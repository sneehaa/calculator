import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/theme/theme.dart';
import 'package:flutter_application_1/calculator.dart';

void main() {
  runApp(
    MaterialApp(
    theme: getApplicationTheme(),
    debugShowCheckedModeBanner: false,
    home: const CalculatorApp(),
  ));
}
