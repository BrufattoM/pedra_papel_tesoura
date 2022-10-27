import 'dart:math';
import 'package:flutter/material.dart';

//Listas
List<IconData> _icons = [
// The underscore declares a variable as private in dart.
  Icons.signal_cellular_no_sim,
  Icons.square_rounded,
  Icons.colorize,
];

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = Icons.filter_none;
  var _mensagem = "Escolha uma opção abaixo";
  double tamanhoBordaPedra = 0;
  double tamanhoBordaPapel = 0;
  double tamanhoBordaTesoura = 0;
  var cor = Colors.white;

  void _opcaoSelecionada(String escolhaUsuario) {
    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(3);
    var escolhaApp = opcoes[numero];

    //Controle de borda da escolha do Usuario
    switch (escolhaUsuario) {
      case "pedra":
        tamanhoBordaPedra = 2;
        tamanhoBordaPapel = 0;
        tamanhoBordaTesoura = 0;
        break;
      case "papel":
        tamanhoBordaPedra = 0;
        tamanhoBordaPapel = 2;
        tamanhoBordaTesoura = 0;
        break;
      case "tesoura":
        tamanhoBordaPedra = 0;
        tamanhoBordaPapel = 0;
        tamanhoBordaTesoura = 2;
    }

    //Exibição da imagem escolhida pelo App
    switch (escolhaApp) {
      case "pedra":
        setState(() {
          _imagemApp = Icons.square_rounded;
        });
        break;
      case "papel":
        setState(() {
          _imagemApp = Icons.insert_drive_file;
        });
        break;
      case "tesoura":
        setState(() {
          _imagemApp = Icons.colorize;
        });
    }

    //Validação do ganhador
    if ((escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra")) {
      setState(() {
        _mensagem = "Parabéns!!! Você ganhou :)";
        cor = Colors.green;
      });
    } else if ((escolhaUsuario == "tesoura" && escolhaApp == "pedra") ||
        (escolhaUsuario == "papel" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "pedra" && escolhaApp == "papel")) {
      setState(() {
        _mensagem = "Você perdeu :(";
        cor = Colors.red;
      });
    } else {
      setState(() {
        _mensagem = "Empatamos ;)";
        cor = Colors.amber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        title: const Text("PPT"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 0, bottom: 16),
            child: Text("Escolha do App",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(width: 2, color: cor)),
            child: Icon(
              _imagemApp,
              size: 35,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 16),
            child: Text(_mensagem,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () => _opcaoSelecionada("pedra"),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: tamanhoBordaPedra)),
                  child: Icon(
                    Icons.square_rounded,
                    size: 35,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _opcaoSelecionada("papel"),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: tamanhoBordaPapel)),
                  child: Icon(
                    Icons.insert_drive_file,
                    size: 35,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _opcaoSelecionada("tesoura"),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: tamanhoBordaTesoura)),
                  child: Icon(
                    Icons.colorize,
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
