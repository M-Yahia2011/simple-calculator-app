import 'package:calxulator/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => Calculations(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: Screen()),
          Expanded(child: KeyPad()),
        ],
      ),
    );
  }
}

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    Provider.of<Calculations>(context).input!,
                    style: TextStyle(fontSize: 35),
                  ),
                ))),
        Expanded(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    Provider.of<Calculations>(context).result!,
                    style: TextStyle(fontSize: 35),
                  ),
                ))),
      ],
    );
  }
}

class KeyPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      child: Column(
        children: [
          Expanded(
              child: Row(
            children: [EraseKey(), BackspaceKey()],
          )),
          Expanded(
            child: Row(children: [
              NumberKey('('),
              NumberKey(')'),
              OperationKey('%'),
              OperationKey('/'),
            ]),
          ),
          Expanded(
            child: Row(children: [
              NumberKey('7'),
              NumberKey('8'),
              NumberKey('9'),
              OperationKey('*'),
            ]),
          ),
          Expanded(
            child: Row(children: [
              NumberKey('4'),
              NumberKey('5'),
              NumberKey('6'),
              OperationKey('-'),
            ]),
          ),
          Expanded(
            child: Row(children: [
              NumberKey('1'),
              NumberKey('2'),
              NumberKey('3'),
              OperationKey('+'),
            ]),
          ),
          Expanded(
            child: Row(children: [
              PositiveNegative(),
              NumberKey('0'),
              NumberKey('.'),
              EqualKey(),
            ]),
          )
        ],
      ),
    );
  }
}

class NumberKey extends StatelessWidget {
  final String number;
  NumberKey(this.number);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
        child: TextButton(
          onPressed: () {
            Provider.of<Calculations>(context, listen: false).write(number);
          },
          child: FittedBox(
            child: Text('$number',
                style: TextStyle(color: Colors.black, fontSize: 35)),
          ),
          style: TextButton.styleFrom(
              minimumSize: Size(double.infinity, double.infinity)),
        ),
      ),
    );
  }
}

class OperationKey extends StatelessWidget {
  final String operation;
  OperationKey(this.operation);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
        child: TextButton(
          onPressed: () {
            Provider.of<Calculations>(context, listen: false).write(operation);
          },
          child: Text(
            '$operation',
            style: TextStyle(fontSize: 22),
          ),
          style: TextButton.styleFrom(
            minimumSize: Size(double.infinity, double.infinity),
          ),
        ),
      ),
    );
  }
}

class EqualKey extends StatelessWidget {
  static const String operation = '=';
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
        child: TextButton(
          onPressed: () {
            Provider.of<Calculations>(context, listen: false).solve();
          },
          child: Text(
            '$operation',
            style: TextStyle(fontSize: 22),
          ),
          style: TextButton.styleFrom(
            minimumSize: Size(double.infinity, double.infinity),
          ),
        ),
      ),
    );
  }
}

class BackspaceKey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
        child: TextButton(
          onPressed: () {
            Provider.of<Calculations>(context, listen: false).removeLastInput();
          },
          child: Text(
            'X',
            style: TextStyle(fontSize: 22, color: Colors.redAccent),
          ),
          style: TextButton.styleFrom(
            minimumSize: Size(double.infinity, double.infinity),
          ),
        ),
      ),
    );
  }
}

class EraseKey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
        child: TextButton(
          onPressed: () {
            Provider.of<Calculations>(context, listen: false).eraseAll();
          },
          child: Text(
            'C',
            style: TextStyle(fontSize: 22, color: Colors.redAccent),
          ),
          style: TextButton.styleFrom(
            minimumSize: Size(double.infinity, double.infinity),
          ),
        ),
      ),
    );
  }
}

class PositiveNegative extends StatelessWidget {
  const PositiveNegative({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
        child: TextButton(
          onPressed: () {
            Provider.of<Calculations>(context, listen: false).toggleNegative();
          },
          child: Text(
            '+/-',
            style: TextStyle(fontSize: 22),
          ),
          style: TextButton.styleFrom(
            minimumSize: Size(double.infinity, double.infinity),
          ),
        ),
      ),
    );
  }
}
