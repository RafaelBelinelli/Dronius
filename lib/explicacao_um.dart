// ignore_for_file: prefer_const_literals_to_create_immutables
//import 'package:dronius/menu.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ExplicacaoUm extends StatelessWidget {
  const ExplicacaoUm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: NewGradientAppBar(
          gradient: const LinearGradient(colors: [
        Color.fromARGB(255, 0, 142, 176),
        Color.fromARGB(255, 121, 213, 193)
      ])),
        body: Column(children: [
          const Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
              GradientText(
                'Como um drone voa?',
                colors: const [
                  Color.fromARGB(255, 0, 142, 176),
                  Color.fromARGB(255, 121, 213, 193)
                ],
                style: const TextStyle(fontFamily: 'Lobster', fontSize: 35),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 9 / 10,
            child: const Text(
              "Para a explicação abaixo, usaremos os quadricópteros como referência, que são os tipos mais comuns à venda. Eles contam com quatro rotores (chamados popularmente de hélices). O princípio básico de funcionamento de um drone envolve equilíbrio. Enquanto dois desses rotores giram no sentido horário, outros dois giram no sentido anti-horário. Desta forma, há uma compensação de forças que evita que o drone gire descontroladamente ao redor do seu eixo vertical. É preciso uma condição para levantar voo: a força de empuxo gerada pelos rotores ao empurrarem o ar para baixo e, por consequência, serem empurrados para cima. Essa força precisa ser maior do que a da gravidade.",
              style: TextStyle(
                fontFamily: "VarelaRound",
                fontSize: 20,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ]));
  }
}
