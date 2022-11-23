import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20, left: 20, bottom: 600),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          width: 250,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              GradientText(
                'Dronius',
                style: const TextStyle(fontFamily: 'Lobster', fontSize: 50),
                textAlign: TextAlign.center,
                colors: const [
                  Color.fromARGB(255, 0, 142, 176),
                  Color.fromARGB(255, 121, 213, 193)
                ],
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/home");
                },
                leading: const Icon(Icons.home, color: Colors.black),
                title: const Text("Home"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/config");
                },
                leading: const Icon(Icons.settings, color: Colors.black),
                title: const Text("Configurações"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/sobre");
                },
                leading: const Icon(Icons.info, color: Colors.black),
                title: const Text("Sobre"),
              ),
            ],
          ),
        ));
  }
}
