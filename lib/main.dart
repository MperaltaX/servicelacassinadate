import 'package:flutter/material.dart';
import 'package:service_date/servicios_page.dart';
import '18meses_page.dart';
import 'destetes_page.dart';
import 'nacimiento_page.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Cassina',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Control de fechas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardD = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xff0D2B50),
      ),

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      // const Text(
      //   'You have pushed the button this many times:',
      // ),
      // Text(
      //   '$_counter',
      //   style: Theme.of(context).textTheme.headline4,
      // ),
      // TextButton(child: Text('INGRESAR SERVICIO'), onPressed: () {}),
      // TextButton(
      //     child: Text('INGRESAR NACIMIENTO'),
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => DateTimePickerNac()),
      //       );
      //     }),
      //],
      // ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.

      body: Container(
        decoration: BoxDecoration(
          //color: Colors.orangeAccent,
          image: DecorationImage(
            image: AssetImage("assets/imgScreen.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ExpansionTileCard(
                expandedTextColor: Color.fromARGB(255, 211, 180, 97),
                key: cardA,
                leading: CircleAvatar(
                  child: Text('A'),
                  backgroundColor: Color(0xff0D2B50),
                ),
                title: Text('SERVICIOS'),
                subtitle: Text('Ingresar servicio, obtener fecha nacimiento'),
                children: <Widget>[
                  Divider(
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        """Ingresa la fecha en la que se realizó el servicio, para obtener la fecha de nacimiento de la cría. recuerda que es en un rango de MÁS, MENOS 5 días.""",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      TextButton(
                        style: flatButtonStyle,
                        onPressed: () {
                          //cardB.currentState?.expand();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DateTimePickerServ()),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.arrow_circle_right,
                              color: Color.fromARGB(255, 13, 43, 80),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text(
                              'IR',
                              style: TextStyle(
                                  color: Color.fromARGB(150, 13, 43, 80)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ExpansionTileCard(
                key: cardB,
                // expandedTextColor: Colors.blue,
                expandedTextColor: Color.fromARGB(255, 211, 180, 97),
                leading: CircleAvatar(
                  child: Text('B'),
                  backgroundColor: Color(0xff0D2B50),
                ),
                title: Text('NACIMIENTOS'),
                subtitle: Text('Ingresa nacimiento, obtener fecha servicio'),
                children: <Widget>[
                  Divider(
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        """Ingresa la fecha de nacimiento para obtener la fecha en la que se debió realizar el servicio, recuerda que es en un rango de MÁS, MENOS 5 días. """,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      TextButton(
                        style: flatButtonStyle,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DateTimePickerNac()),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.arrow_circle_right,
                              color: Color.fromARGB(255, 13, 43, 80),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text(
                              'IR',
                              style: TextStyle(
                                  color: Color.fromARGB(150, 13, 43, 80)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ExpansionTileCard(
                key: cardC,
                // expandedTextColor: Colors.blue,
                expandedTextColor: Color.fromARGB(255, 211, 180, 97),
                leading: CircleAvatar(
                  child: Text('C'),
                  backgroundColor: Color(0xff0D2B50),
                ),
                title: Text('DESTETES'),
                subtitle: Text('Ingresar nacimiento, obtener fecha destete'),
                children: <Widget>[
                  Divider(
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        """Ingresa la fecha de nacimiento para obtener la fecha en la que se debe realizar el destete, recuerda que es en un rango de MÁS, MENOS 45 días. """,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      TextButton(
                        style: flatButtonStyle,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DateTimePickerDtt()),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.arrow_circle_right,
                              color: Color.fromARGB(255, 13, 43, 80),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text(
                              'IR',
                              style: TextStyle(
                                  color: Color.fromARGB(150, 13, 43, 80)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ExpansionTileCard(
                key: cardD,
                // expandedTextColor: Colors.blue,
                expandedTextColor: Color.fromARGB(255, 211, 180, 97),
                leading: CircleAvatar(
                  child: Text('D'),
                  backgroundColor: Color(0xff0D2B50),
                ),
                title: Text('18 MESES'),
                subtitle: Text('Ingresa nacimiento, obtener fecha 18 MESES'),
                children: <Widget>[
                  Divider(
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        """Ingresa la fecha de nacimiento para obtener la fecha en la que se debe realizar la medida de 18 meses, recuerda que es en un rango de MÁS, MENOS 45 días. """,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      TextButton(
                        style: flatButtonStyle,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DateTimePickerMes()),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.arrow_circle_right,
                              color: Color.fromARGB(255, 13, 43, 80),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text(
                              'IR',
                              style: TextStyle(
                                  color: Color.fromARGB(150, 13, 43, 80)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
