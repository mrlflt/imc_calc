import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var weightControl = TextEditingController();
  var heightControl = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados.";

  void _resetField() {
    weightControl.text = heightControl.text = "";
    setState(() {
      _infoText = "Informe seus dados.";
      _formKey = GlobalKey<FormState>();
    });
  }

  double _imc(double a, double b) => a / pow(b, 2);

  void _calculate() {
    setState(() {
      double x = _imc(
          double.parse(weightControl.text), double.parse(heightControl.text));

      if (x < 18.6) {
        _infoText = "Abaixo do peso ${x}";
      } else if (x < 18.6 && x < 30.6) {
        _infoText = "Peso normal ${x}";
      } else {
        _infoText = "Acima do Peso ${x}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("IMC Calculator"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetField,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.green, fontSize: 15.0),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                controller: weightControl,
                validator: (value) {
                  if(value.isEmpty) return "Insira seu peso.";
                },
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                decoration: InputDecoration(
                  labelText: "Altura (m)",
                  labelStyle: TextStyle(color: Colors.green, fontSize: 15.0),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                controller: heightControl,
                validator: (value) {
                  if(value.isEmpty)
                    return "Insira sua altura.";
                  return _infoText;
                },
              ),
              Padding(
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate())
                        _calculate();
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
                padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              ),
              Text(
                "$_infoText",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
