import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenSate createState() => _MenuScreenSate();
}

class _MenuScreenSate extends State<MenuScreen> {
  String _selectedOption = 'Peso al Nacer';
  final List<String> _options = [
    'Peso al Nacer',
    'Peso al Destete',
    'Leche',
    'Peso FINAL',
    'Circunferencia Escrotal',
    //'Altura'
  ];
  final TextEditingController _depValueController = TextEditingController();
  final TextEditingController _depPrecisionController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _respuesta = TextEditingController();

  double _sliderValue = 0;
  double _sliderValue2 = 0;
  double minSlider = -12;
  double maxSlider = 12;
  int divSlider = 100;
  String _valorDep = '0.0';
  double _ValorPreci = 0.0;

  bool _mostrarIcono = false;
  void _mostrarOcultarIcono() {
    setState(() {
      _mostrarIcono = true;
    });
  }

  bool _validateTextField(Tf1) {
    if (Tf1 == null || Tf1 == '') {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DEP'S TOROS (Beta abierta)"),
          backgroundColor: Color(0xff0D2B50),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(12),
          color: Theme.of(context)
              .colorScheme
              .secondaryContainer
              .withOpacity(0.05),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Seleccione tipo de Dep',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                DropdownButton<String>(
                  value: _selectedOption,
                  items: _options
                      .map((String option) => DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        _selectedOption = value;
                        //widget._messageController.text =
                        value; // actualizar el controlador del TextField
                      });
                    }
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  'Ingrese valor del DEP',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 10),
                Text(
                  _sliderValue <= 0.01
                      ? _sliderValue.toStringAsFixed(1)
                      : '+' + '${_sliderValue.abs().toStringAsFixed(1)}',
                  //'${_sliderValue.toStringAsFixed(1)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Slider(
                  activeColor: Color.fromARGB(255, 211, 180, 97),
                  value: _sliderValue,
                  min: minSlider,
                  max: maxSlider,
                  divisions: divSlider,
                  label: '${_sliderValue.toStringAsFixed(1)}',
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                      _sliderValue <= 0.01
                          ? _valorDep = _sliderValue.toStringAsFixed(1)
                          : _valorDep =
                              '+' + '${_sliderValue.abs().toStringAsFixed(1)}';
                      print(_valorDep);
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      minSlider.toString(),
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      '+' + maxSlider.toString(),
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                // TextField(
                //     controller: _depValueController,
                //     decoration: InputDecoration(
                //       labelText: "Valor Dep",
                //       border: myinputborder(), //normal border
                //       enabledBorder: myinputborder(), //enabled border
                //       focusedBorder: myfocusborder(), //focused border
                //       // set more border style like disabledBorder
                //     )),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                Text(
                  'Ingrese precision del DEP',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 10),
                Text(
                  '${_sliderValue2.toStringAsFixed(1)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Slider(
                  activeColor: Color.fromARGB(255, 211, 180, 97),
                  value: _sliderValue2,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  label: '${_sliderValue2.toStringAsFixed(1)}',
                  onChanged: (value) {
                    setState(() {
                      _sliderValue2 = value;
                      _ValorPreci = _sliderValue2;
                      print(_ValorPreci);
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '0.0',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      '1.0',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      double numeroDouble = double.parse(_valorDep);
                      imprimirRespuesta(_selectedOption, numeroDouble);
                      _mostrarOcultarIcono();
                      _depPrecisionController.clear();
                      _depValueController.clear();
                    }),
                const SizedBox(height: 40),
                TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines:
                        null, // Permite que el número de líneas sea dinámico
                    controller: _respuesta,
                    decoration: InputDecoration(
                      labelText: "Respuesta",
                      border: myinputborder(), //normal border
                      enabledBorder: myinputborder(), //enabled border
                      focusedBorder: myfocusborder(), //focused border
                      // set more border style like disabledBorder
                    )),
                const SizedBox(height: 40),
                if (_mostrarIcono)
                  const Icon(
                    CupertinoIcons.checkmark_seal, // Ejemplo de icono
                    color: Color.fromARGB(255, 211, 180, 97),
                    size: 150, // Tamaño del icono
                  )
              ],
            ),
          ),
        )));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 211, 180, 97),
          width: 3,
        ));
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 211, 180, 97),
          width: 3,
        ));
  }

  imprimirRespuesta(String _selectedOption, double value) {
    if (_selectedOption == 'Peso al Nacer') {
      if (value > 0) {
        _respuesta.text =
            ('Significa que sus crías tendrán un peso promedio al nacer que será ' +
                value.toString() +
                ' kilos mayor que el de las crías de otros animales incluidos en el mismo programa. Un animal con un peso al nacer demasiado alto puede generar problemas en el parto.' +
                'El peso al nacer del animal no está relacionado directamente con el dep y el peso al nacer de su progenie. Por ejemplo, si el animal tiene un peso al nacer de 30 kilos y el dep es +' +
                value.toString() +
                ', sus hijos no pesarán ' +
                (30 + value).toString() +
                ' Kilos' +
                ' (30 + ' +
                value.toString() +
                '), sino que pesarán ' +
                value.toString() +
                ' Kilos más comparado al promedio de la raza, no del padre.' +
                ' La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else if (value == 0) {
        _respuesta.text =
            ('Significa que el peso que transmite a su progenie es promedio al de las crías de otros animales incluidos en el mismo programa. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else {
        _respuesta.text =
            ('Significa que sus crías tendrán un peso promedio al nacer que será ' +
                value.toString() +
                ' kilos menor que el de las crías de otros animales incluidos en el mismo programa. Buscado en terneros que sean aptos para vaquillonas. ' +
                'El peso al nacer del animal no está relacionado directamente con el dep y el peso al nacer de su progenie. Por ejemplo, si el animal tiene un peso al nacer de 30 kilos y el dep es ' +
                value.toString() +
                ', sus hijos no pesarán ' +
                (30 + value).toString() +
                ' Kilos,' +
                ' (30 ' +
                value.toString() +
                ') sino que pesarán ' +
                value.toString() +
                ' Kilos menos comprado al promedio de la raza, no del padre.' +
                ' La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      }
    } else if (_selectedOption == 'Peso al Destete') {
      if (value > 0) {
        _respuesta.text =
            ('Significa que sus crías tendrán un peso promedio al destete que será ' +
                value.toString() +
                ' kilos mayor que el de las crías de otros animales incluidos en el mismo programa de cría. Este DEP indica la capacidad del toro para transmitir crecimiento al destete a sus crías. Por lo tanto, si se utiliza este toro para la cría, se esperaría que sus crías tengan un mayor peso al momento del destete en comparación con las crías de otros toros incluidos en el mismo programa. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else if (value == 0) {
        _respuesta.text =
            ('Un animal con un DEP de Destete de 0.0 no transmitiría ni más ni menos crecimiento al destete que el promedio de los padres incluidos en el mismo programa de cría. En otras palabras, las crías de este animal tendrían un peso promedio al destete similar al de las crías de otros animales del programa de cría. Es importante tener en cuenta que un DEP de 0.0 no necesariamente significa que el animal tenga un bajo crecimiento al destete. Simplemente significa que su capacidad para transmitir crecimiento al destete a su progenie es similar al promedio de los padres incluidos en el programa de cría. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else {
        _respuesta.text =
            ('Significa que las crías de este animal tendrán un peso promedio al destete que será ' +
                value.toString() +
                ' kilos menor que el de las crías de otros animales incluidos en el mismo programa de cría. En otras palabras, el DEP de destete indica la capacidad de un toro para transmitir crecimiento a sus crías en el periodo que va desde el nacimiento hasta el destete. Un DEP de destete negativo indica que se espera que las crías de este toro tengan un crecimiento más lento en este periodo en comparación con las crías de otros toros incluidos en el mismo programa de cría. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      }
    } else if (_selectedOption == 'Leche') {
      if (value > 0) {
        _respuesta.text =
            ('Indica una capacidad superior a la media para transmitir genes para la producción de leche a sus hijas. En comparación con otros toros incluidos en el mismo programa de cría, las crías de este animal tendrían una mayor producción de leche. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else if (value == 0) {
        _respuesta.text =
            ('No transmitiría ni más ni menos habilidad para la producción de leche a sus hijas que el promedio de los padres incluidos en el mismo programa de cría. En otras palabras, las crías de este animal tendrían una producción de leche promedio similar a la de las crías de otros animales del programa de cría. Deps mayores transmiten mejores genes de produción de Leche. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else {
        _respuesta.text =
            ('Indica que sus crías tendrían una capacidad inferior para producir leche en comparación con el promedio de las crías de otros animales incluidos en el mismo programa de cría. Esto significa que sus hijas podrían tener una producción de leche ligeramente inferior en comparación con las hijas de otros toros que tienen un DEP de Leche más alto. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      }
    } else if (_selectedOption == 'Peso FINAL') {
      if (value > 0) {
        _respuesta.text =
            ('Indica que sus crías tendrían un peso promedio a los 18 meses que sería ' +
                value.toString() +
                ' kilos mayor que el promedio de las crías de otros animales incluidos en el mismo programa de cría. Deps mayores significan que el toro tiene una buena capacidad para transmitir crecimiento a sus crías y sería una buena opción para mejorar la tasa de crecimiento del rebaño. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else if (value == 0) {
        _respuesta.text =
            ('Sus crías tendrían un peso promedio a los 18 meses similar al de las crías de otros animales incluidos en el mismo programa de cría. Es decir, este animal no transmitiría una mayor capacidad para el crecimiento a los 18 meses a su descendencia en comparación con otros animales del mismo programa de cría. No necesariamente significa que el animal tenga un bajo crecimiento a los 18 meses en sí mismo. Simplemente significa que su capacidad para transmitir crecimiento a los 18 meses a su progenie es similar al promedio de los padres incluidos en el programa de cría. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else {
        _respuesta.text =
            ('Significa que las crías de este animal tendrían un peso promedio a los 18 meses que sería ' +
                value.toString() +
                ' menos que el promedio de las crías de otros animales incluidos en el mismo programa de cría. Un DEP de Final negativo indica que el animal no transmitiría tanto crecimiento a sus crías como el promedio de los padres incluidos en el programa de cría. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      }
    } else if (_selectedOption == 'Circunferencia Escrotal') {
      if (value > 0) {
        _respuesta.text =
            ('Indica que sus crías tienen una tendencia a tener una mayor circunferencia escrotal ajustada a los 18 meses en comparación con las crías de otros toros incluidos en el mismo programa de cría, y por lo tanto, tienen una mayor probabilidad de alcanzar la madurez sexual temprano.Es importante tener en cuenta que un mayor DEP de Circunferencia Escrotal no necesariamente significa que el toro en sí mismo tenga una circunferencia escrotal más grande, sino que transmite la tendencia genética a sus crías de tener una circunferencia escrotal más grande a una edad determinada. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else if (value == 0) {
        _respuesta.text =
            ('Un animal con un DEP de Circunferencia Escrotal de 0.0 no tendría una capacidad superior ni inferior para transmitir la circunferencia escrotal a su progenie en comparación con el promedio de los padres incluidos en el mismo programa de cría. En otras palabras, las crías de este animal tendrían una circunferencia escrotal promedio similar a la de las crías de otros animales del programa de cría.no significa necesariamente que el animal tenga una circunferencia escrotal baja en sí mismo. Simplemente significa que su capacidad para transmitir la circunferencia escrotal a su progenie es similar al promedio de los padres incluidos La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else {
        _respuesta.text =
            ('Indica una capacidad de transmitir circunferencia escrotal a su progenie menor al promedio de los padres incluidos en el mismo programa de cría. En otras palabras, las crías de este animal tendrían una circunferencia escrotal promedio menor en comparación con las crías de otros animales del programa de cría que tienen un DEP de circunferencia escrotal mayor.Es importante tener en cuenta que, aunque un DEP negativo en circunferencia escrotal puede indicar una menor capacidad para transmitir esta característica a la descendencia, no necesariamente significa que el animal tenga una baja fertilidad en sí mismo. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      }
    }
  }
}
