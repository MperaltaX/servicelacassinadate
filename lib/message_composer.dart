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
            Visibility(
              visible: _selectedOption == 'Peso al Nacer',
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Ingrese Peso al nacer',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                      controller: _pesoController,
                      decoration: InputDecoration(
                        labelText: "Peso Nacer",
                        border: myinputborder(), //normal border
                        enabledBorder: myinputborder(), //enabled border
                        focusedBorder: myfocusborder(), //focused border
                        // set more border style like disabledBorder
                      )),
                ],
              ),
            ),
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
              onPressed: !widget.awaitingResponse
                  ? () {
                      if (_pesoController.text.isEmpty &&
                          _selectedOption == 'Peso al Nacer') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Por favor ingrese el peso al nacer'),
                          ),
                        );
                      } else {
                        String consulta = 'Según la asociación argentina de Angus un DEP de nacer está expresado en kilos,' +
                            'preside la capacidad que tiene el toro considerado para transmitir peso al nacer a su progenie.' +
                            'Es un indicador de facilidad de parto.' +
                            'Deps por debajo de cero, son valores buscados en crias para vaquillonas.' +
                            ' el DEP predice cómo será el comportamiento promedio de las futuras crías de un toro en comparación con las que' +
                            ' producirán el resto de los padres incluidos en el mismo programa. ' +
                            'Sabiendo esto, ¿que puede decirnos un animal con un Dep de nacer de ' +
                            _valorDep +
                            ' si el animal nacio con ' +
                            _pesoController.toString() +
                            ' kilos? Resumen de no más de 40 palabras. La precicion de este dato es de ' +
                            (_ValorPreci * 100).toString() +
                            '%' +
                            '¿Cual es el porcentaje de precision?' +
                            'Agrega éste texto al final de la respuesta. Sin agregar nada más cita textual: Es importante destacar que los DEPs no son una medida precisa y definitiva del rendimiento reproductivo de un toro, pero pueden ser útiles para ayudar a seleccionar toros con características de reproducción deseables.';
                        switch (_selectedOption) {
                          case 'Peso al nacer':
                            consulta = 'Según la asociación argentina de Angus un DEP de nacer está expresado en kilos,' +
                                'preside la capacidad que tiene el toro considerado para transmitir peso al nacer a su progenie.' +
                                'Es un indicador de facilidad de parto.' +
                                'Deps por debajo de cero, son valores buscados en crias para vaquillonas.' +
                                ' el DEP predice cómo será el comportamiento promedio de las futuras crías de un toro en comparación con las que' +
                                ' producirán el resto de los padres incluidos en el mismo programa. ' +
                                'Sabiendo esto, ¿que puede decirnos un animal con un Dep de nacer de ' +
                                _valorDep +
                                ' si el animal nacio con ' +
                                _pesoController.toString() +
                                ' kilos? Resumen de no más de 40 palabras. La precicion de este dato es de ' +
                                (_ValorPreci * 100).toString() +
                                '%' +
                                '¿Cual es el porcentaje de precision?' +
                                'Agrega éste texto al final de la respuesta. Sin agregar nada más cita textual: Es importante destacar que los DEPs no son una medida precisa y definitiva del rendimiento reproductivo de un toro, pero pueden ser útiles para ayudar a seleccionar toros con características de reproducción deseables.';
                            break;
                          case 'Peso al Destete':
                            consulta = 'Según la asociación argentina de Angus un DEP de Destete está expresado en kilos, predice la capacidad que tiene el toro considerado para transmitir crecimiento al destete a su progenie. Sabiendo esto, que puede decirnos un animal con un Dep de destete de ' +
                                _valorDep +
                                ' ?. ¿tendrá ' +
                                _valorDep +
                                ' kilos más o menos que el promedio de la raza?' +
                                'La precicion de este dato es de ' +
                                (_ValorPreci * 100).toString() +
                                '%' +
                                '¿Cual es el porcentaje de precision?' +
                                'Agrega éste texto al final de la respuesta. Es importante destacar que los DEPs no son una medida precisa y definitiva del rendimiento reproductivo de un toro, pero pueden ser útiles para ayudar a seleccionar toros con características de reproducción deseables.';
                            break;
                          case 'Leche':
                            consulta = 'Según la asociación argentina de Angus un DEP de LECHE  indica la aptitud lechera que transmite un toro a sus hijas, se mide a través del peso al destete de sus nietos. ' +
                                '¿que puede decirnos un animal con un Dep de Leche de ' +
                                _valorDep +
                                ' ? ¿tendrá ' +
                                _valorDep +
                                ' kilos más o menos que el promedio de la raza?' +
                                'La precicion de este dato es de ' +
                                (_ValorPreci * 100).toString() +
                                '%' +
                                '¿Cual es el porcentaje de precision?' +
                                'Agrega éste texto al final de la respuesta. Sin agregar nada más cita textual: Es importante destacar que los DEPs no son una medida precisa y definitiva del rendimiento reproductivo de un toro, pero pueden ser útiles para ayudar a seleccionar toros con características de reproducción deseables.';
                            break;
                          case 'Peso FINAL':
                            consulta = 'Según la asociación argentina de Angus un DEP FINAL está expresado en kilos, predice la capacidad que tiene el toro considerado para transmitir crecimiento a sus crias, medido como peso a los 18 meses. ¿que puede decirnos un animal con un Dep de destete de ' +
                                _valorDep +
                                ' ? ¿tendrá ' +
                                _valorDep +
                                ' kilos más o menos que el promedio de la raza? ' +
                                'La precicion de este dato es de ' +
                                (_ValorPreci * 100).toString() +
                                '%' +
                                '¿Cual es el porcentaje de precision?' +
                                'Agrega éste texto al final de la respuesta. Sin agregar nada más cita textual: Es importante destacar que los DEPs no son una medida precisa y definitiva del rendimiento reproductivo de un toro, pero pueden ser útiles para ayudar a seleccionar toros con características de reproducción deseables.';
                            break;
                          case 'Circunferencia Escrotal':
                            consulta = 'Según la asociación argentina de Angus un DEP de Circunferencia escrotal, está expresado en centimetros y ajustado a los 18 meses, predice la capacidad del toro para transmitir ésta caracteristicas a su progenie. La circunferencia escrotal es uno de los mejores estimadores de la fertilidad, ya que está asociada con la cantidad de semen producido por el toro y con la edad a la que sus crias ingresan a la pubertad. Dep mayores indican que la progenie alcanzará más temprano su madurez sexual. ' +
                                '¿que puede decirnos un animal con un Dep de circunferencia escrotal de ' +
                                _valorDep +
                                ' ? ¿tendrá ' +
                                _valorDep +
                                ' centimetros más o menos que el promedio de la raza? ¿Que pasa con su progenie? ' +
                                'La precicion de este dato es de ' +
                                (_ValorPreci * 100).toString() +
                                '%' +
                                '¿Cual es el porcentaje de precision?' +
                                'Agrega éste texto al final de la respuesta. Sin agregar nada más cita textual: Es importante destacar que los DEPs no son una medida precisa y definitiva del rendimiento reproductivo de un toro, pero pueden ser útiles para ayudar a seleccionar toros con características de reproducción deseables.';
                            break;
                          case 'Altura':
                            consulta = 'Según la asociación argentina de Angus un DEP de ALTURA está expresado en centímetros y ajustado a los 18 meses, es muy importante cuando hay que elegir por ejemplo entre dos toros con igual DEP de PESO FINAL, a los fines de evitar incrementar el tamaño corporal más allá de lo deseado. ' +
                                '¿que puede decirnos un animal con un Dep de ALTURA de ' +
                                _valorDep +
                                '? ¿tendrá ' +
                                _valorDep +
                                ' centimetros más o menos que el promedio de la raza? ' +
                                'La precicion de este dato es de ' +
                                (_ValorPreci * 100).toString() +
                                '%' +
                                '¿Cual es el porcentaje de precision?' +
                                'Agrega éste texto al final de la respuesta. Sin agregar nada más cita textual: Es importante destacar que los DEPs no son una medida precisa y definitiva del rendimiento reproductivo de un toro, pero pueden ser útiles para ayudar a seleccionar toros con características de reproducción deseables.';
                            break;
                        }

                        widget.onSubmitted(consulta);
                        _depPrecisionController.clear();
                        _depValueController.clear();
                        _pesoController.clear();
                      }
                    }
                  : null,
              icon: const Icon(Icons.send),
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
}
