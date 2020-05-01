import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int leftDiceNumber = Random().nextInt(6) + 1;
  int rightDiceNumber = Random().nextInt(6) + 1;
  Color bgColor = Colors.green;
  bool rolling = false;

  Future rollDice(int n, int delay) {
    if (n < 1) return null;
    if (n == 1) {
      return Future.delayed(Duration(milliseconds: delay), () {
        setState(() {
          int num1 = Random().nextInt(6) + 1;
          int num2 = Random().nextInt(6) + 1;
          if (num1 == leftDiceNumber) num1 = num1 % 6 + 1;
          if (num2 == rightDiceNumber) num1 = num2 % 6 + 1;
          leftDiceNumber = num1;
          rightDiceNumber = num2;
          rolling = false;
        });
      });
    }

    return Future.delayed(Duration(milliseconds: delay), () {
      setState(() {
        int num1 = Random().nextInt(6) + 1;
        int num2 = Random().nextInt(6) + 1;
        if (num1 == leftDiceNumber) num1 = num1 % 6 + 1;
        if (num2 == rightDiceNumber) num1 = num2 % 6 + 1;
        leftDiceNumber = num1;
        rightDiceNumber = num2;
      });
      rollDice(n - 1, (delay * 1.1).round());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: rolling ? Colors.red[400] : Colors.green[400],
        appBar: AppBar(
          title: Text(rolling ? 'Rolling...' : 'Roll Dice'),
          backgroundColor: rolling ? Colors.red : Colors.green,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      child: Image.asset('images/dice$leftDiceNumber.png'),
                      onPressed: rolling
                          ? null
                          : () {
                              setState(() {
                                rolling = true;
                              });
                              rollDice(20, 40);
                            },
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: rolling
                          ? null
                          : () {
                              setState(() {
                                rolling = true;
                              });
                              rollDice(20, 40);
                            },
                      child: Image.asset('images/dice$rightDiceNumber.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Sum: ${leftDiceNumber + rightDiceNumber}',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
