import 'package:flutter/material.dart';

//promp para la ia
//según la reglamentación del ERA Angus argentina, que significa que un animal tenga un dep de nacer valor -1.0 y precisión de 0.6?
//cuál es el porcentaje de precisión? Resumen de 25 palabras aproximadamente.

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú desplegable'),
        backgroundColor: Color(0xff0D2B50),
      ),
      body: Center(
        child: buildDropdownButton(),
      ),
    );
  }
}

DropdownButton<String> buildDropdownButton() {
  String? dropdownValue = 'Nacer';
  return DropdownButton<String>(
    value: dropdownValue,
    items: <String>[
      'Nacer',
      'Peso Destete',
      'Peso Final',
      'Circunferencia Escrotal',
    ].map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    onChanged: (String? newValue) {
      // Aquí puedes agregar la lógica para manejar el cambio de opción
    },
  );
}
