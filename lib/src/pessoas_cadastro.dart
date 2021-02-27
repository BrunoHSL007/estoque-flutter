import 'package:flutter/material.dart';

class PessoasCadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Codigo: CODIGOPESSOA",
                style: TextStyle(
                  color: const Color(0xFF7d7d7d),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                width: 1.7976931348623157e+308,
                height: 10.0,
              ),
              Text(
                "Nome",
              ),
              TextField(),
              Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                width: 1.7976931348623157e+308,
                height: 5.0,
              ),
              Text(
                "Telefone",
              ),
              TextField(),
              Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                width: 1.7976931348623157e+308,
                height: 5.0,
              ),
              Text(
                "Endereço",
              ),
              TextField(
                style: TextStyle(
                    fontSize: 12.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
              Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                width: 1.7976931348623157e+308,
                height: 5.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Nascimento",
                    ),
                    IconButton(
                      icon: const Icon(Icons.event),
                      onPressed: () {
                        print("IconButton");
                      },
                      iconSize: 32.0,
                      color: const Color(0xFF000000),
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        key: null,
                        onPressed: () {
                          print("Movimentação");
                        },
                        color: const Color(0xFFe0e0e0),
                        child: Text(
                          "Movimentação",
                        )),
                    RaisedButton(
                        key: null,
                        onPressed: () {
                          print("Dívidas");
                        },
                        color: const Color(0xFFe0e0e0),
                        child: Text(
                          "Dívidas",
                        ))
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        key: null,
                        color: Colors.red,
                        textColor: Colors.white,
                        onPressed: () {
                          print("Deletar");
                        },
                        child: Text(
                          "Deletar",
                        )),
                    RaisedButton(
                        key: null,
                        color: Colors.green,
                        textColor: Colors.white,
                        onPressed: () {
                          print("Salvar");
                        },
                        child: Text(
                          "Salvar",
                        ))
                  ])
            ]),
      ),
    );
  }
}
