import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ExperimentoUm extends StatelessWidget {
  const ExperimentoUm({Key? key}) : super(key: key);

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
            } else if (message == "subir:success") {
              print("subiu 👍");
              voando = true;
            } else if (message == "descer:success") {
              print("desceu 👍");
              voando = false;
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
      print(_);
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
            'Subir e descer',
            colors: const [
              Color.fromARGB(255, 0, 142, 176),
              Color.fromARGB(255, 121, 213, 193)
            ],
            style: const TextStyle(fontFamily: 'Lobster', fontSize: 35),
          )
        ],
      ),
      const Padding(padding: EdgeInsets.only(top: 20)),
      SizedBox(
        width: MediaQuery.of(context).size.width * 9 / 10,
        child: const Text(
          "Instruções para realização do experimento:\n\n" +
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
          style: TextStyle(
            fontFamily: "VarelaRound",
            fontSize: 20,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
      const Spacer(),
      Container(
          height: 100,
          width: MediaQuery.of(context).size.width * 9 / 10,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(1, 142, 176, 1),
                Color.fromRGBO(92, 196, 189, 1)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: ElevatedButton(
              onPressed: (() {
                if (!connected) {
                  channelConnect();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "Você deve se conectar à rede antes de usar o drone!")));
                } else {
                  Navigator.pushNamed(context, "/experimento");
                }
              }),
              style: ElevatedButton.styleFrom(
                  primary: Colors.transparent, shadowColor: Colors.transparent),
              child: const Text(
                "Iniciar experimento",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Varela', fontSize: 23),
              ))),
      Padding(
        padding: EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: MediaQuery.of(context).size.width * 1 / 20,
            right: MediaQuery.of(context).size.width * 1 / 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text("Status do drone:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "VarelaRound",
                  fontSize: 17,
                )),
            const Spacer(),
            Text(connected ? "Conectado" : "Não conectado",
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: "VarelaRound",
                  fontSize: 17,
                )),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Image.asset(
              connected ? 'v.png' : 'x.png',
              height: 20,
            )
          ],
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
