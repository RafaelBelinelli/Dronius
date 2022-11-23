// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:dronius/experimento_card.dart';
import 'package:dronius/explicacao_card.dart';
import 'package:dronius/explicacao_um.dart';
import 'package:dronius/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NewGradientAppBar(
          gradient: const LinearGradient(colors: [
        Color.fromARGB(255, 0, 142, 176),
        Color.fromARGB(255, 121, 213, 193)
      ])),
      drawer: const MenuLateral(),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
              GradientText(
                'Experimentos',
                colors: const [
                  Color.fromARGB(255, 0, 142, 176),
                  Color.fromARGB(255, 121, 213, 193)
                ],
                style: const TextStyle(fontFamily: 'Lobster', fontSize: 35),
              ),
              Image.asset(
                'tubo.png',
                height: 35,
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          SizedBox(
            height: 200,
            child: ListView(
              padding: const EdgeInsets.only(left: 10.5, right: 10.5),
              itemExtent: 220,
              scrollDirection: Axis.horizontal,
              children: [
                const Center(
                  child: ExperimentoCard(
                      imagem: 'experimento1.jpg',
                      titulo: 'Subir e descer',
                      nota: 4.5,
                      emBreve: false,
                      size: 175,
                      rota: '/experimento1',
                      ),
                ),
                const Center(
                    child: ExperimentoCard(
                        imagem: 'experimento2.jpg',
                        titulo: 'Usando a garra',
                        nota: 0,
                        emBreve: true,
                        size: 175,
                        rota: '/home',
                        ))
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
              GradientText(
                'Explicações ',
                colors: const [
                  Color.fromARGB(255, 0, 142, 176),
                  Color.fromARGB(255, 121, 213, 193)
                ],
                style: const TextStyle(fontFamily: 'Lobster', fontSize: 35),
              ),
              Image.asset(
                'atomo.png',
                height: 35,
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          SizedBox(
            height: 200,
            child: ListView(
              padding: const EdgeInsets.only(left: 10.5, right: 10.5),
              itemExtent: 220,
              scrollDirection: Axis.horizontal,
              children: const [
                Center(
                    child: ExplicacaoCard(
                  imagem: 'explicacao1.jpg',
                  titulo: 'Como um drone voa?',
                  emBreve: false,
                  size: 175,
                  rota: '/explicacao1',
                )),
                Center(
                    child: ExplicacaoCard(
                  imagem: 'explicacao2.jpg',
                  titulo: 'Queda livre',
                  emBreve: true,
                  size: 175,
                  rota: '/home',
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
