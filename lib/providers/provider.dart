import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculations with ChangeNotifier {
  // double? _result;
  String? _input = '';
  String? _result = '';
  Parser parser = Parser();

  String? get input {
    return _input;
  }

  String? get result {
    return _result;
  }

  void write(String x) {
    if (_input!.contains('.') && x == '.') {
      _input = _input;
    } else {
      _input = '$_input$x';
    }

    notifyListeners();
  }

  ContextModel cm = ContextModel();
  void solve() {
    try {
      Expression? exp = parser.parse(_input!);
      _result = exp.evaluate(EvaluationType.REAL, cm).toString();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void removeLastInput() {
    if (_input!.isEmpty) {
      return;
    }
    _input = _input!.substring(0, _input!.length - 1);
    notifyListeners();
  }

  void eraseAll() {
    _input = '';
    notifyListeners();
  }

  void toggleNegative() {
    Expression? exp = parser.parse(_input!);
    var eval = exp.evaluate(EvaluationType.REAL, cm);
    if (eval! > 0) {
      _input = '-$_input';
    } else {
      _input = _input!.substring(1);
    }
    notifyListeners();
  }
}
