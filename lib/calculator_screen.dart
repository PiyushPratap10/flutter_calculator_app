import 'package:calculator_app/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});
  @override
  State<CalculatorScreen> createState() {
    return _CalculatorScreenState();
  }
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _output = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .35,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black38, blurRadius: 0.5)
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _input,
                      style: const TextStyle(fontSize: 25),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _output,
                      style: const TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  clearButton(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(onPressed: _onButtonPressed, text: '7'),
                  CustomButton(onPressed: _onButtonPressed, text: '8'),
                  CustomButton(onPressed: _onButtonPressed, text: '9'),
                  const Spacer(),
                  CustomButton(onPressed: _onButtonPressed, text: '/'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(onPressed: _onButtonPressed, text: '4'),
                  CustomButton(onPressed: _onButtonPressed, text: '5'),
                  CustomButton(onPressed: _onButtonPressed, text: '6'),
                  const Spacer(),
                  CustomButton(onPressed: _onButtonPressed, text: '*'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(onPressed: _onButtonPressed, text: '1'),
                  CustomButton(onPressed: _onButtonPressed, text: '2'),
                  CustomButton(onPressed: _onButtonPressed, text: '3'),
                  const Spacer(),
                  CustomButton(onPressed: _onButtonPressed, text: '-'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(onPressed: _onButtonPressed, text: '0'),
                  CustomButton(onPressed: _onButtonPressed, text: '.'),
                  equalButton('='),
                  const Spacer(),
                  CustomButton(onPressed: _onButtonPressed, text: '+'),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget equalButton(String text) {
    return InkWell(
      onTap: () {
        _onButtonPressed(text);
      },
      child: Card(
        shape: const CircleBorder(eccentricity: 1.0),
        elevation: 5,
        color: Theme.of(context).primaryColorDark,
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: 65,
          width: 65,
          alignment: Alignment.center,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 104, 255, 109)),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }

  Widget clearButton() {
    return InkWell(
      onTap: _clear,
      child: Card(
        shape: const CircleBorder(eccentricity: 1.0),
        elevation: 5,
        color: Theme.of(context).primaryColorDark,
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: 65,
          width: 65,
          alignment: Alignment.center,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 255, 137, 104)),
          child: const Text(
            'AC',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }

  void _onButtonPressed(String text) {
    setState(() {
      if (text == '=') {
        _calculateResult();
      } else {
        _input += text;
      }
    });
  }

  void _calculateResult() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_input);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      _output = result.toString();
    } catch (e) {
      _output = 'Error';
    }
  }

  void _clear() {
    setState(() {
      _input = '';
      _output = '';
    });
  }
}
