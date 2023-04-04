// widgets/message_composer.dart

import 'package:flutter/material.dart';

class MessageComposer extends StatefulWidget {
  MessageComposer({
    required this.onSubmitted,
    required this.awaitingResponse,
    Key? key,
  }) : super(key: key);

  final TextEditingController _messageController = TextEditingController();
  final void Function(String) onSubmitted;
  final bool awaitingResponse;

  @override
  State<MessageComposer> createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  String _selectedOption = 'Peso al Nacer';
  final List<String> _options = [
    'Peso al Nacer',
    'Peso al Destete',
    'Leche',
    'Peso FINAL',
    'Circunferencia Escrotal',
    'Altura'
  ];
  final TextEditingController _depValueController = TextEditingController();
  final TextEditingController _depPrecisionController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();

  double _sliderValue = 0;
  double _sliderValue2 = 0;
  double minSlider = -12;
  double maxSlider = 12;
  int divSlider = 100;
  String _valorDep = '0.0';
  double _ValorPreci = 0.0;

  bool _validateTextField(Tf1) {
    if (Tf1 == null || Tf1 == '') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.05),
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
                    widget._messageController.text =
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
            // TextField(
            //     controller: _depPrecisionController,
            //     decoration: InputDecoration(
            //       labelText: "Presicion",
            //       border: myinputborder(), //normal border
            //       enabledBorder: myinputborder(), //enabled border
            //       focusedBorder: myfocusborder(), //focused border
            //       // set more border style like disabledBorder
            //     )),
            const SizedBox(height: 10),
            // Visibility(
            //   visible: _selectedOption == 'Peso al Nacer',
            //   child: Column(
            //     children: [
            //       const SizedBox(height: 10),
            //       Text(
            //         'Ingrese Peso al nacer',
            //         style: Theme.of(context).textTheme.subtitle1,
            //       ),
            //       const SizedBox(height: 10),
            //       TextField(
            //           controller: _pesoController,
            //           decoration: InputDecoration(
            //             labelText: "Peso Nacer",
            //             border: myinputborder(), //normal border
            //             enabledBorder: myinputborder(), //enabled border
            //             focusedBorder: myfocusborder(), //focused border
            //             // set more border style like disabledBorder
            //           )),
            //     ],
            //   ),
            // ),
            !widget.awaitingResponse
                ? TextField(
                    readOnly: true,
                    //controller: widget._messageController,
                    onSubmitted: widget.onSubmitted,
                    decoration: const InputDecoration(
                      hintText: '',
                      border: InputBorder.none,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Analizando...'),
                      ),
                    ],
                  ),
            const SizedBox(height: 10),
            IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  double numeroDouble = double.parse(_valorDep);
                  imprimirRespuesta(_selectedOption, numeroDouble);

                  _depPrecisionController.clear();
                  _depValueController.clear();
                }
                //codigo de chatgpt
                //!widget.awaitingResponse
                //? () {
                // if (_pesoController.text.isEmpty &&
                //     _selectedOption == 'Peso al Nacer') {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text('Por favor ingrese el peso al nacer'),
                //     ),
                //   );
                // } else {
                //   String consulta = 'Según la asociación argentina de Angus un DEP de nacer está expresado en kilos,' +
                //       'preside la capacidad que tiene el toro considerado para transmitir peso al nacer a su progenie.' +
                //       'Es un indicador de facilidad de parto.' +
                //       'Deps por debajo de cero, son valores buscados en crias para vaquillonas.' +
                //       ' el DEP predice cómo será el comportamiento promedio de las futuras crías de un toro en comparación con las que' +
                //       ' producirán el resto de los padres incluidos en el mismo programa. ' +
                //       'Sabiendo esto, ¿que puede decirnos un animal con un Dep de nacer de ' +
                //       _valorDep +
                //       ' si el animal nacio con ' +
                //       _pesoController.toString() +
                //       ' kilos? Resumen de no más de 40 palabras. La precicion de este dato es de ' +
                //       (_ValorPreci * 100).toString() +
                //       '%' +
                //       '¿Cual es el porcentaje de precision?' +
                //       'Agrega éste texto al final de la respuesta. Sin agregar nada más cita textual: Es importante destacar que los DEPs no son una medida precisa y definitiva del rendimiento reproductivo de un toro, pero pueden ser útiles para ayudar a seleccionar toros con características de reproducción deseables.';
                //   switch (_selectedOption) {
                //     case 'Peso al nacer':
                //       consulta = 'Según la asociación argentina de Angus un DEP de nacer está expresado en kilos,' +
                //           'preside la capacidad que tiene el toro considerado para transmitir peso al nacer a su progenie.' +
                //           'Es un indicador de facilidad de parto.' +
                //           'Deps por debajo de cero, son valores buscados en crias para vaquillonas.' +
                //           ' el DEP predice cómo será el comportamiento promedio de las futuras crías de un toro en comparación con las que' +
                //           ' producirán el resto de los padres incluidos en el mismo programa. ' +
                //           'Sabiendo esto, ¿que puede decirnos un animal con un Dep de nacer de ' +
                //           _valorDep +
                //           ' si el animal nacio con ' +
                //           _pesoController.toString() +
                //           ' kilos? Resumen de no más de 40 palabras. La precicion de este dato es de ' +
                //           (_ValorPreci * 100).toString() +
                //           '%' +
                //           '¿Cual es el porcentaje de precision?' +
                //           'Agrega éste texto al final de la respuesta. Sin agregar nada más cita textual: Es importante destacar que los DEPs no son una medida precisa y definitiva del rendimiento reproductivo de un toro, pero pueden ser útiles para ayudar a seleccionar toros con características de reproducción deseables.';
                //       break;
                //     case 'Peso al Destete':
                //       consulta = 'Según la asociación argentina de Angus un DEP de Destete está expresado en kilos, predice la capacidad que tiene el toro considerado para transmitir crecimiento al destete a su progenie. Sabiendo esto, que puede decirnos un animal con un Dep de destete de ' +
                //           _valorDep +
                //           ' ?. ¿tendrá ' +
                //           _valorDep +
                //           ' kilos más o menos que el promedio de la raza?' +
                //           'La precicion de este dato es de ' +
                //           (_ValorPreci * 100).toString() +
                //           '%' +
                //           '¿Cual es el porcentaje de precision?' +
                //           'Agrega éste texto al final de la respuesta. Es importante destacar que los DEPs no son una medida precisa y definitiva del rendimiento reproductivo de un toro, pero pueden ser útiles para ayudar a seleccionar toros con características de reproducción deseables.';
                //       break;
                //     case 'Leche':
                //       consulta = 'Según la asociación argentina de Angus un DEP de LECHE  indica la aptitud lechera que transmite un toro a sus hijas, se mide a través del peso al destete de sus nietos. ' +
                //           '¿que puede decirnos un animal con un Dep de Leche de ' +
                //           _valorDep +
                //           ' ? ¿tendrá ' +
                //           _valorDep +
                //           ' kilos más o menos que el promedio de la raza?' +
                //           'La precicion de este dato es de ' +
                //           (_ValorPreci * 100).toString() +
                //           '%' +
                //           '¿Cual es el porcentaje de precision?' +
                //           'Agrega éste texto al final de la respuesta. Sin agregar nada más cita textual: Es importante destacar que los DEPs no son una medida precisa y definitiva del rendimiento reproductivo de un toro, pero pueden ser útiles para ayudar a seleccionar toros con características de reproducción deseables.';
                //       break;
                //     case 'Peso FINAL':
                //       consulta = 'Según la asociación argentina de Angus un DEP FINAL está expresado en kilos, predice la capacidad que tiene el toro considerado para transmitir crecimiento a sus crias, medido como peso a los 18 meses. ¿que puede decirnos un animal con un Dep de destete de ' +
                //           _valorDep +
                //           ' ? ¿tendrá ' +
                //           _valorDep +
                //           ' kilos más o menos que el promedio de la raza? ' +
                //           'La precicion de este dato es de ' +
                //           (_ValorPreci * 100).toString() +
                //           '%' +
                //           '¿Cual es el porcentaje de precision?' +
                //           'Agrega éste texto al final de la respuesta. Sin agregar nada más cita textual: Es importante destacar que los DEPs no son una medida precisa y definitiva del rendimiento reproductivo de un toro, pero pueden ser útiles para ayudar a seleccionar toros con características de reproducción deseables.';
                //       break;
                //     case 'Circunferencia Escrotal':
                //       consulta = 'Según la asociación argentina de Angus un DEP de Circunferencia escrotal, está expresado en centimetros y ajustado a los 18 meses, predice la capacidad del toro para transmitir ésta caracteristicas a su progenie. La circunferencia escrotal es uno de los mejores estimadores de la fertilidad, ya que está asociada con la cantidad de semen producido por el toro y con la edad a la que sus crias ingresan a la pubertad. Dep mayores indican que la progenie alcanzará más temprano su madurez sexual. ' +
                //           '¿que puede decirnos un animal con un Dep de circunferencia escrotal de ' +
                //           _valorDep +
                //           ' ? ¿tendrá ' +
                //           _valorDep +
                //           ' centimetros más o menos que el promedio de la raza? ¿Que pasa con su progenie? ' +
                //           'La precicion de este dato es de ' +
                //           (_ValorPreci * 100).toString() +
                //           '%' +
                //           '¿Cual es el porcentaje de precision?' +
                //           'Agrega éste texto al final de la respuesta. Sin agregar nada más cita textual: Es importante destacar que los DEPs no son una medida precisa y definitiva del rendimiento reproductivo de un toro, pero pueden ser útiles para ayudar a seleccionar toros con características de reproducción deseables.';
                //       break;
                //     case 'Altura':
                //       consulta = 'Según la asociación argentina de Angus un DEP de ALTURA está expresado en centímetros y ajustado a los 18 meses, es muy importante cuando hay que elegir por ejemplo entre dos toros con igual DEP de PESO FINAL, a los fines de evitar incrementar el tamaño corporal más allá de lo deseado. ' +
                //           '¿que puede decirnos un animal con un Dep de ALTURA de ' +
                //           _valorDep +
                //           '? ¿tendrá ' +
                //           _valorDep +
                //           ' centimetros más o menos que el promedio de la raza? ' +
                //           'La precicion de este dato es de ' +
                //           (_ValorPreci * 100).toString() +
                //           '%' +
                //           '¿Cual es el porcentaje de precision?' +
                //           'Agrega éste texto al final de la respuesta. Sin agregar nada más cita textual: Es importante destacar que los DEPs no son una medida precisa y definitiva del rendimiento reproductivo de un toro, pero pueden ser útiles para ayudar a seleccionar toros con características de reproducción deseables.';
                //       break;
                //   }

                //  widget.onSubmitted(consulta);
                //   _depPrecisionController.clear();
                //  _depValueController.clear();
                //  _pesoController.clear();
                //}
                //   }
                //  : null,
                // icon: const Icon(Icons.send),
                ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.greenAccent,
          width: 3,
        ));
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.blue,
          width: 3,
        ));
  }

  imprimirRespuesta(String _selectedOption, double value) {
    if (_selectedOption == 'Peso al Nacer') {
      if (value > 0) {
        print('Significa que sus crías tendrán un peso promedio al nacer que será ' +
            value.toString() +
            ' kilos mayor que el de las crías de otros animales incluidos en el mismo programa. Un animal con un peso al nacer demasiado alto puede generar problemas en el parto.' +
            'El peso al nacer del animal no está relacionado directamente con el dep y el peso al nacer de su progenie. Por ejemplo, si el animal tiene un peso al nacer de 30 kilos y el dep es +' +
            value.toString() +
            ', sus hijos no pesarán ' +
            (30 + value).toString() +
            ' Kilos, sino que pesarán ' +
            value.toString() +
            ' Kilos más que el promedio de la raza.' +
            ' La precicion de este dato es de ' +
            (_ValorPreci * 100).toString() +
            '%');
      } else if (value == 0) {
        print(
            'Significa que el peso que transmite a su progenie es promedio al de las crías de otros animales incluidos en el mismo programa. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else {
        print('Significa que sus crías tendrán un peso promedio al nacer que será ' +
            value.toString() +
            ' kilos menor que el de las crías de otros animales incluidos en el mismo programa. Buscado en terneros que sean aptos para vaquillonas. ' +
            'El peso al nacer del animal no está relacionado directamente con el dep y el peso al nacer de su progenie. Por ejemplo, si el animal tiene un peso al nacer de 30 kilos y el dep es ' +
            value.toString() +
            ', sus hijos no pesarán ' +
            (30 + value).toString() +
            ' Kilos, sino que pesarán ' +
            value.toString() +
            ' Kilos menos que el promedio de la raza.' +
            ' La precicion de este dato es de ' +
            (_ValorPreci * 100).toString() +
            '%');
      }
    } else if (_selectedOption == 'Peso al Destete') {
      if (value > 0) {
        print('Significa que sus crías tendrán un peso promedio al destete que será ' +
            value.toString() +
            ' kilos mayor que el de las crías de otros animales incluidos en el mismo programa de cría. Este DEP indica la capacidad del toro para transmitir crecimiento al destete a sus crías. Por lo tanto, si se utiliza este toro para la cría, se esperaría que sus crías tengan un mayor peso al momento del destete en comparación con las crías de otros toros incluidos en el mismo programa. La precicion de este dato es de ' +
            (_ValorPreci * 100).toString() +
            '%');
      } else if (value == 0) {
        print(
            'Un animal con un DEP de Destete de 0.0 no transmitiría ni más ni menos crecimiento al destete que el promedio de los padres incluidos en el mismo programa de cría. En otras palabras, las crías de este animal tendrían un peso promedio al destete similar al de las crías de otros animales del programa de cría. Es importante tener en cuenta que un DEP de 0.0 no necesariamente significa que el animal tenga un bajo crecimiento al destete. Simplemente significa que su capacidad para transmitir crecimiento al destete a su progenie es similar al promedio de los padres incluidos en el programa de cría. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else {
        print('Significa que las crías de este animal tendrán un peso promedio al destete que será ' +
            value.toString() +
            ' kilos menor que el de las crías de otros animales incluidos en el mismo programa de cría. En otras palabras, el DEP de destete indica la capacidad de un toro para transmitir crecimiento a sus crías en el periodo que va desde el nacimiento hasta el destete. Un DEP de destete negativo indica que se espera que las crías de este toro tengan un crecimiento más lento en este periodo en comparación con las crías de otros toros incluidos en el mismo programa de cría. La precicion de este dato es de ' +
            (_ValorPreci * 100).toString() +
            '%');
      }
    } else if (_selectedOption == 'Leche') {
      if (value > 0) {
        print(
            'Indica una capacidad superior a la media para transmitir genes para la producción de leche a sus hijas. En comparación con otros toros incluidos en el mismo programa de cría, las crías de este animal tendrían una mayor producción de leche. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else if (value == 0) {
        print(
            'No transmitiría ni más ni menos habilidad para la producción de leche a sus hijas que el promedio de los padres incluidos en el mismo programa de cría. En otras palabras, las crías de este animal tendrían una producción de leche promedio similar a la de las crías de otros animales del programa de cría. Deps mayores transmiten mejores genes de produción de Leche. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else {
        print(
            'Indica que sus crías tendrían una capacidad inferior para producir leche en comparación con el promedio de las crías de otros animales incluidos en el mismo programa de cría. Esto significa que sus hijas podrían tener una producción de leche ligeramente inferior en comparación con las hijas de otros toros que tienen un DEP de Leche más alto. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      }
    } else if (_selectedOption == 'Peso FINAL') {
      if (value > 0) {
        print('Indica que sus crías tendrían un peso promedio a los 18 meses que sería ' +
            value.toString() +
            ' kilos mayor que el promedio de las crías de otros animales incluidos en el mismo programa de cría. Deps mayores significan que el toro tiene una buena capacidad para transmitir crecimiento a sus crías y sería una buena opción para mejorar la tasa de crecimiento del rebaño. La precicion de este dato es de ' +
            (_ValorPreci * 100).toString() +
            '%');
      } else if (value == 0) {
        print(
            'Sus crías tendrían un peso promedio a los 18 meses similar al de las crías de otros animales incluidos en el mismo programa de cría. Es decir, este animal no transmitiría una mayor capacidad para el crecimiento a los 18 meses a su descendencia en comparación con otros animales del mismo programa de cría. No necesariamente significa que el animal tenga un bajo crecimiento a los 18 meses en sí mismo. Simplemente significa que su capacidad para transmitir crecimiento a los 18 meses a su progenie es similar al promedio de los padres incluidos en el programa de cría. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else {
        print('Significa que las crías de este animal tendrían un peso promedio a los 18 meses que sería ' +
            value.toString() +
            ' menos que el promedio de las crías de otros animales incluidos en el mismo programa de cría. Un DEP de Final negativo indica que el animal no transmitiría tanto crecimiento a sus crías como el promedio de los padres incluidos en el programa de cría. La precicion de este dato es de ' +
            (_ValorPreci * 100).toString() +
            '%');
      }
    } else if (_selectedOption == 'Circunferencia Escrotal') {
      if (value > 0) {
        print(
            'Indica que sus crías tienen una tendencia a tener una mayor circunferencia escrotal ajustada a los 18 meses en comparación con las crías de otros toros incluidos en el mismo programa de cría, y por lo tanto, tienen una mayor probabilidad de alcanzar la madurez sexual temprano.Es importante tener en cuenta que un mayor DEP de Circunferencia Escrotal no necesariamente significa que el toro en sí mismo tenga una circunferencia escrotal más grande, sino que transmite la tendencia genética a sus crías de tener una circunferencia escrotal más grande a una edad determinada. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else if (value == 0) {
        print(
            'Un animal con un DEP de Circunferencia Escrotal de 0.0 no tendría una capacidad superior ni inferior para transmitir la circunferencia escrotal a su progenie en comparación con el promedio de los padres incluidos en el mismo programa de cría. En otras palabras, las crías de este animal tendrían una circunferencia escrotal promedio similar a la de las crías de otros animales del programa de cría.no significa necesariamente que el animal tenga una circunferencia escrotal baja en sí mismo. Simplemente significa que su capacidad para transmitir la circunferencia escrotal a su progenie es similar al promedio de los padres incluidos La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      } else {
        print(
            'Indica una capacidad de transmitir circunferencia escrotal a su progenie menor al promedio de los padres incluidos en el mismo programa de cría. En otras palabras, las crías de este animal tendrían una circunferencia escrotal promedio menor en comparación con las crías de otros animales del programa de cría que tienen un DEP de circunferencia escrotal mayor.Es importante tener en cuenta que, aunque un DEP negativo en circunferencia escrotal puede indicar una menor capacidad para transmitir esta característica a la descendencia, no necesariamente significa que el animal tenga una baja fertilidad en sí mismo. La precicion de este dato es de ' +
                (_ValorPreci * 100).toString() +
                '%');
      }
    }
  }
}
