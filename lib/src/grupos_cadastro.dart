import 'package:flutter/material.dart';

class GruposCadastro extends StatelessWidget {
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
                "Descrição",
              ),
              TextField(),
              Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                width: 1.7976931348623157e+308,
                height: 5.0,
              ),
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
