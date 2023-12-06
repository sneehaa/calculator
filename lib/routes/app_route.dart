

import 'package:flutter_application_1/calculator.dart';

class AppRoute {
  AppRoute._();

  static const String calculatorRoute = '/calculator';

  static getApplicationRoute() {
    return {
       calculatorRoute: (context) => const CalculatorApp()
    };
  }
}
