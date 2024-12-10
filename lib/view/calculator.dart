import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  String displayText = '';
  double firstOperand = 0;
  double secondOperand = 0;
  String operation = '';

  void _onButtonPressed(String symbol) {
    setState(() {
      if (symbol == 'C') {
        displayText = '';
        firstOperand = 0;
        secondOperand = 0;
        operation = '';
      } else if (symbol == '<-') {
        if (displayText.isNotEmpty) {
          displayText = displayText.substring(0, displayText.length - 1);
        }
      } else if (symbol == '+' ||
          symbol == '-' ||
          symbol == '*' ||
          symbol == '/') {
        if (displayText.isNotEmpty) {
          firstOperand = double.parse(displayText);
          operation = symbol;
          displayText = '';
        }
      } else if (symbol == '=') {
        if (displayText.isNotEmpty && operation.isNotEmpty) {
          secondOperand = double.parse(displayText);
          if (operation == '+') {
            displayText = (firstOperand + secondOperand).toString();
          } else if (operation == '-') {
            displayText = (firstOperand - secondOperand).toString();
          } else if (operation == '*') {
            displayText = (firstOperand * secondOperand).toString();
          } else if (operation == '/') {
            if (secondOperand != 0) {
              displayText = (firstOperand / secondOperand).toString();
            } else {
              displayText = 'Error';
            }
          }
          operation = '';
        }
      } else {
        displayText += symbol;
      }
      _textController.text = displayText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suman Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              textDirection: TextDirection.rtl,
              controller: _textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              readOnly: true,
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () => _onButtonPressed(lstSymbols[index]),
                    child: Text(
                      lstSymbols[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
