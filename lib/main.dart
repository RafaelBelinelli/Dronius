import 'package:dronius/configuracoes.dart';
import 'package:dronius/experimento.dart';
import 'package:dronius/experimento_um.dart';
import 'package:dronius/explicacao_um.dart';
import 'package:dronius/sobre.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dronius',
      initialRoute: '/start',
      routes: <String, WidgetBuilder>{
        '/start': (BuildContext context) => const MyInitialPage(
              title: 'Dronius',
            ),
        '/home': (BuildContext context) => const Home(),
        '/config': (BuildContext context) => const Configuracoes(),
        '/sobre': (BuildContext context) => const Sobre(),
        '/explicacao1': (BuildContext context) => const ExplicacaoUm(),
        '/experimento1': (BuildContext context) => const ExperimentoUm(),
        '/experimento': (BuildContext context) => const Experimento()
        // rotas
      },
      theme: ThemeData(
          primaryColor: const Color.fromRGBO(0, 142, 176, 1),
          fontFamily: 'VarelaRound',
          scaffoldBackgroundColor: const Color.fromARGB(0, 255, 255, 255)),
      debugShowCheckedModeBanner: false,
      home: const MyInitialPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyInitialPage extends StatelessWidget {
  final String title;

  const MyInitialPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/curva.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Padding(padding: EdgeInsets.all(60.0)),
          const Image(
            image: AssetImage('assets/logoFundoBranco.png'),
          ),
          GradientText(
            'Dronius',
            style: const TextStyle(fontFamily: 'Lobster', fontSize: 40),
            colors: const [
              Color.fromRGBO(7, 145, 178, 1),
              Color.fromRGBO(150, 210, 222, 1)
            ],
          ),
          const Padding(padding: EdgeInsets.all(10)),
          const Text(
            'Bem vindo ao Dronius',
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                color: Color.fromARGB(255, 170, 170, 170)),
          ),
          const Padding(padding: EdgeInsets.all(100)),
          MaterialButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/home");
            },
            child: const Text(
              'Começar',
              style: TextStyle(
                  fontFamily: 'Roboto', fontSize: 25, color: Colors.white),
            ),
          )
        ]),
      ),
    );
  }
}
