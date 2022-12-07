// ignore_for_file: prefer_const_literals_to_create_immutables
//import 'package:dronius/menu.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Configuracoes extends StatelessWidget {
  const Configuracoes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NewGradientAppBar(
          gradient: const LinearGradient(colors: [
        Color.fromARGB(255, 0, 142, 176),
        Color.fromARGB(255, 121, 213, 193)
      ])),
      body: WebSocketDrone(),
    );
  }
}

class WebSocketDrone extends StatefulWidget {
  const WebSocketDrone({Key? key}) : super(key: key);

  @override
  State<WebSocketDrone> createState() => _WebSocketDroneState();
}

class _WebSocketDroneState extends State<WebSocketDrone> {
  late bool voando;
  late WebSocketChannel channel;
  late bool connected;
  bool disposed = false;

  @override
  void initState() {
    voando = false;
    connected = false;

    Future.delayed(Duration.zero, () async {
      channelConnect();
    });

    super.initState();
  }

  channelConnect() {
    try {
      channel = WebSocketChannel.connect(Uri.parse("ws://192.168.15.22/ws"));
      channel.stream.listen((message) {
        print(message);
        if (!disposed) {
          setState(() {
            if (message == "connected") {
              connected = true;
            }
          });
        }
      }, onDone: () {
        print("Web socket fechado");
        if (!disposed) {
          setState(() {
            connected = false;
          });
        }
      }, onError: (error) {
        print(error.toString());
      });
    } catch (_) {
      print("Erro conectando com o websocket :(");
    }
  }

  Future<void> sendcmd(String cmd) async {
    if (connected) {
      if (!voando && cmd != "subir" && cmd != "descer") {
        print("Mande o comando correto!");
      } else {
        channel.sink.add(cmd);
      }
    } else {
      channelConnect();
      print("Websocket nao esta conectado!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const Padding(padding: EdgeInsets.only(top: 20)),
      Row(
        children: [
          const Padding(padding: EdgeInsets.only(left: 20)),
          GradientText(
            'Configurações ',
            colors: const [
              Color.fromARGB(255, 0, 142, 176),
              Color.fromARGB(255, 121, 213, 193)
            ],
            style: const TextStyle(fontFamily: 'Lobster', fontSize: 35),
          ),
          Image.asset(
            'config.png',
            height: 35,
          )
        ],
      ),
      const Padding(padding: EdgeInsets.only(top: 20)),
      Row(
        children: [
          const Padding(padding: EdgeInsets.only(left: 20)),
          Text(
            connected
                ? "Status do drone: Conectado "
                : "Status do drone: Não conectado ",
            style: const TextStyle(
              fontFamily: "VarelaRound",
              fontSize: 20,
            ),
          ),
          Image.asset(
            connected ? 'v.png' : 'x.png',
            height: 20,
          )
        ],
      ),
      const Padding(padding: EdgeInsets.only(top: 20)),
      SizedBox(
        width: MediaQuery.of(context).size.width * 9 / 10,
        child: const Text(
          "Conecte o celular à mesma rede do drone, e caso o status não mude para conectado reinicie o aplicativo. Após isso, escolha um experimento para ser realizado e siga as orientações na tela.",
          style: TextStyle(
            fontFamily: "VarelaRound",
            fontSize: 20,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    ]));
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}
