import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ExperimentoCard extends StatelessWidget {
  final String imagem;
  final String titulo;
  final double nota;
  final bool emBreve;
  final double size;
  final String rota;

  const ExperimentoCard(
      {Key? key,
      required this.imagem,
      required this.titulo,
      required this.nota,
      required this.emBreve,
      required this.size,
      required this.rota})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {emBreve ? null : Navigator.pushNamed(context, rota)},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(5, 5),
                  spreadRadius: -4,
                  blurRadius: 10,
                  color: Color.fromRGBO(76, 76, 76, 1),
                )
              ],
              borderRadius: BorderRadius.circular(10.0)),
          height: size,
          width: size * 1.15,
          child: Column(children: [
            Stack(
              children: [
                Container(
                  height: size - (size / 5),
                  width: size * 1.15,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      image: DecorationImage(
                          image: AssetImage(imagem),
                          fit: BoxFit.cover,
                          colorFilter: emBreve
                              ? const ColorFilter.mode(
                                  Colors.grey, BlendMode.saturation)
                              : null)),
                ),
                emBreve
                    ? Container(
                        padding: EdgeInsets.only(top: 7 * size / 20),
                        child: Center(
                          child: Text(
                            'Em breve',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'VarelaRound',
                                fontSize: size / 10),
                          ),
                        ))
                    : Container(),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: size / 25)),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: size / 20)),
                GradientText(
                  titulo,
                  colors: const [
                    Color.fromARGB(255, 0, 142, 176),
                    Color.fromARGB(255, 77, 187, 186)
                  ],
                  style:
                      TextStyle(fontFamily: 'VarelaRound', fontSize: size / 12),
                ),
                const Spacer(),
                const Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 255, 166, 46),
                ),
                const Padding(padding: EdgeInsets.only(right: 4)),
                GradientText(
                  nota == 0 ? '-' : nota.toString(),
                  colors: const [
                    Color.fromARGB(255, 0, 142, 176),
                    Color.fromARGB(255, 77, 187, 186)
                  ],
                  style: TextStyle(
                      fontFamily: 'VarelaRound',
                      fontSize: size / 12 - size / 60),
                ),
                Padding(padding: EdgeInsets.only(right: size / 20))
              ],
            )
          ]),
        ));
  }
}
