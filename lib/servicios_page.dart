import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerServ extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePickerServ> {
  late double _height;
  late double _width;

  late String _setTextFinal, _setDate;

  late String _hour, _minute, _time;

  late String dateTime;

  DateTime selectedDate = DateTime.now();
  DateTime selectedDateF = DateTime.now();
  DateTime selectedDateMin = DateTime.now();
  DateTime selectedDateMax = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _textNacFinal = TextEditingController(); // fecha exacta
  TextEditingController _textNacInicio = TextEditingController(); //fecha -45
  TextEditingController _textNacFin = TextEditingController(); //fecha +45

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
        print(_dateController.text);
        selectedDateF = selectedDate.add(Duration(days: 270)); // fecha exacta
        selectedDateMin = selectedDate.add(Duration(days: 265)); // fecha minima
        selectedDateMax = selectedDate.add(Duration(days: 275)); // fecha maxima

        _textNacFinal.text = 'Nacimiento Exacto día: ' +
            DateFormat('dd/MM/yyyy').format(selectedDateF);
        _textNacInicio.text =
            'Fecha mínima: ' + DateFormat('dd/MM/yyyy').format(selectedDateMin);
        _textNacFin.text =
            'Fecha máxima: ' + DateFormat('dd/MM/yyyy').format(selectedDateMax);
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _textNacFinal.text = '';
    super.initState();
  }

  _back() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Servicio'),
        backgroundColor: Color(0xff0D2B50),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _back,
        tooltip: 'Increment',
        child: const Icon(Icons.arrow_circle_left),
        backgroundColor: Color.fromARGB(255, 211, 180, 97),
      ),
      body: Container(
        decoration: BoxDecoration(
          //color: Colors.orangeAccent,
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Color(0xff0D2B50),
            ],
          ),
          // color: Color(0xff0D2B50),
          image: DecorationImage(
            image: AssetImage("assets/imgScreen4.png"),
            fit: BoxFit.cover,
          ),
        ),
        width: _width,
        height: _height,
        //     BoxDecoration(
        //         gradient: LinearGradient(
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        //   colors: [
        //     Colors.blue,
        //     Color(0xff0D2B50),
        //   ],
        // )),
        // width: _width,
        // height: _height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(150, 13, 43, 80),
                  borderRadius: new BorderRadius.circular(20.0)),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 25),
                  Text(
                    'Seleccionar fecha servicio',
                    style: TextStyle(
                        color: Color.fromARGB(255, 211, 180, 97),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900,
                        fontSize: 23,
                        letterSpacing: 0.5),
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      width: _width / 1.7,
                      height: _height / 9,
                      margin: EdgeInsets.only(top: 30),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: new BorderRadius.circular(20.0)),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: _dateController,
                        onSaved: (val) {
                          _setDate = val!;
                        },
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            // labelText: 'Time',
                            contentPadding: EdgeInsets.only(top: 0.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    _textNacFinal.text,
                    style: TextStyle(
                        color: Color.fromARGB(255, 211, 180, 97),
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5),
                  ),
                  SizedBox(height: 15),
                  Text(
                    _textNacInicio.text,
                    style: TextStyle(
                        color: Color.fromARGB(255, 211, 180, 97),
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5),
                  ),
                  SizedBox(height: 15),
                  Text(
                    _textNacFin.text,
                    style: TextStyle(
                        color: Color.fromARGB(255, 211, 180, 97),
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5),
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
