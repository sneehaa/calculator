import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String userInput = '';
  String result = '0';

  List<String> buttonList = [
    'C',
    '*',
    '/',
    '<-',
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '*',
    '%',
    '0',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculator App",
          style: TextStyle(
              color: Color.fromARGB(255, 42, 42, 42),
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: resultWidget(),
          ),
          Expanded(child: buttonWidget()),
        ],
      ),
    );
  }

  Widget resultWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color.fromARGB(255, 150, 150, 150), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(userInput,
                style: const TextStyle(
                  fontSize: 30,
                )),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buttonWidget() {
    return Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: GridView.builder(
            clipBehavior: Clip.none,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: buttonList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return button(buttonList[index]);
            }));
  }

  getColor(String text) {
    if (text == "C" ||
        text == "/" ||
        text == "*" ||
        text == "-" ||
        text == "<-" ||
        text == "+" ||
        text == "%" ||
        text == "=") {
      return Colors.black;
    } else if (text == "0" ||
        text == "1" ||
        text == "2" ||
        text == "3" ||
        text == "4" ||
        text == "5" ||
        text == "6" ||
        text == "7" ||
        text == "8" ||
        text == "9" ||
        text == ".") {
      return Colors.black;
    } else {
      return Colors.black;
    }
  }

  getBgColor(String text) {
    if (text == 'AC') {
      return Colors.green;
    }
    if (text == '=') {
      return Colors.white;
    }
    return Colors.white;
  }

  //button widget
  Widget button(String text) {
    return InkWell(
        onTap: () {
          setState(() {
            handleButtonPress(text);
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: getBgColor(text),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  handleButtonPress(String text) {
    if (text == 'C') {
      userInput = '';
      result = '0';
      return;
    }

    if (text == '=') {
      result = calculate();
      userInput = result;
      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll('.0', '');
      }

      if (result.endsWith(".0")) {
        result = result.replaceAll('.0', '');
      }

      return;
    }

    if (text == '<-') {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
      }
      return;
    }

    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return 'Error';
    }
  }
}
