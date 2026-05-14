import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {

  String display = "0";

  double firstNumber = 0;
  String operation = "";

  void buttonPressed(String value) {

    setState(() {

      // CLEAR
      if (value == "C") {

        display = "0";
        firstNumber = 0;
        operation = "";

      }

      // OPERATORS
      else if (value == "+" ||
          value == "-" ||
          value == "×" ||
          value == "÷") {

        firstNumber = double.parse(display);
        operation = value;
        display = "0";

      }

      // EQUALS
      else if (value == "=") {

        double secondNumber = double.parse(display);
        double result = 0;

        if (operation == "+") {
          result = firstNumber + secondNumber;
        }

        else if (operation == "-") {
          result = firstNumber - secondNumber;
        }

        else if (operation == "×") {
          result = firstNumber * secondNumber;
        }

        else if (operation == "÷") {
          result = firstNumber / secondNumber;
        }

        display = result.toString();

        // remove .0
        if (display.endsWith(".0")) {
          display = display.replaceAll(".0", "");
        }

      }

      // NUMBER INPUT
      else {

        if (display == "0") {
          display = value;
        }

        else {
          display += value;
        }

      }

    });

  }

  Widget calcButton(String text,
      {Color bgColor = Colors.grey,
        Color textColor = Colors.white}) {

    return GestureDetector(

      onTap: () => buttonPressed(text),

      child: Container(
        margin: const EdgeInsets.all(10),

        height: 80,
        width: 80,

        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100),
        ),

        child: Center(
          child: Text(
            text,

            style: TextStyle(
              color: textColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      body: SafeArea(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.end,

          children: [

            // DISPLAY
            Container(

              alignment: Alignment.centerRight,

              padding: const EdgeInsets.all(20),

              child: SingleChildScrollView(

                scrollDirection: Axis.horizontal,
                reverse: true,

                child: Text(
                  display,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // ROW 1
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                calcButton("7"),
                calcButton("8"),
                calcButton("9"),
                calcButton("÷", bgColor: Colors.orange),

              ],
            ),

            // ROW 2
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                calcButton("4"),
                calcButton("5"),
                calcButton("6"),
                calcButton("×", bgColor: Colors.orange),

              ],
            ),

            // ROW 3
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                calcButton("1"),
                calcButton("2"),
                calcButton("3"),
                calcButton("-", bgColor: Colors.orange),

              ],
            ),

            // ROW 4
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                calcButton("0"),
                calcButton("."),
                calcButton("=",
                    bgColor: Colors.orange),

                calcButton("+",
                    bgColor: Colors.orange),

              ],
            ),

            const SizedBox(height: 20),

            GestureDetector(

              onTap: () => buttonPressed("C"),

              child: const Text(
                "Clear",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

          ],
        ),
      ),
    );
  }
}