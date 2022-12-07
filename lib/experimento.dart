import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Experimento extends StatelessWidget {
  const Experimento({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              print("SUBIUUUSIODAPDPASDAASDJKAS");
              voando = true;
            } else if (message == "descer:success") {
              print("DESCEUEEUEUUAODISAOIDSA");
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
        body: Center(
            child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(255, 1, 142, 176),
                    Color.fromARGB(255, 124, 215, 166)
                  ],
                )),
                // ignore: prefer_const_literals_to_create_immutables
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(children: [
                    const Text(
                      "Experimento rodando.\nUse as setas para controlar o drone!",
                      style: TextStyle(
                        fontFamily: "VarelaRound",
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () => {sendcmd("subir")},
                        // ignore: sort_child_properties_last
                        child: const Icon(
                          Icons.arrow_upward_outlined,
                          size: 60,
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            side: const BorderSide(
                                color: Colors.white, width: 5)),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () => {sendcmd("descer")},
                        // ignore: sort_child_properties_last
                        child: const Icon(
                          Icons.arrow_downward_outlined,
                          size: 60,
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            side: const BorderSide(
                                color: Colors.white, width: 5)),
                      ),
                    )
                  ]),
                ))));
  }
}
