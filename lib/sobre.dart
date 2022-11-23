// ignore_for_file: prefer_const_literals_to_create_immutables
//import 'package:dronius/menu.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Sobre extends StatelessWidget {
  const Sobre({Key? key}) : super(key: key);

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
                'Sobre ',
                colors: const [
                  Color.fromARGB(255, 0, 142, 176),
                  Color.fromARGB(255, 121, 213, 193)
                ],
                style: const TextStyle(fontFamily: 'Lobster', fontSize: 35),
              ),
              Image.asset(
                'sobre.png',
                height: 35,
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 9 / 10,
            child: const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
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
