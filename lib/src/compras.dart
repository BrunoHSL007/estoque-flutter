import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Compras extends StatelessWidget {
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
              Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                width: 1.7976931348623157e+308,
                height: 10.0,
              ),
              Text(
                "Cliente",
              ),
              TextField(),
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
                    new Text(
                      "Pago",
                    ),
                    new Container(
                      padding: const EdgeInsets.all(0.0),
                      alignment: Alignment.center,
                      width: 10.0,
                      height: 10.0,
                    ),
                    new Switch(
                      value: true,
                      onChanged: (bool value) {},
                    )
                  ]),
              Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                width: 1.7976931348623157e+308,
                height: 5.0,
              ),
              Text(
                "Produto",
              ),
              TextField(),
              Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                width: 1.7976931348623157e+308,
                height: 5.0,
              ),
              Text(
                "Quantidade",
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.exposure_minus_1),
                          onPressed: () {
                            print("DiminuiEstoque");
                          },
                          iconSize: 32.0,
                          color: const Color(0xFF000000),
                        ),
                        Container(
                          width: 40,
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.plus_one),
                          onPressed: () {
                            print("AumentaEstoque");
                          },
                          iconSize: 32.0,
                          color: const Color(0xFF000000),
                        ),
                      ],
                    ),
                    RaisedButton(
                        key: null,
                        onPressed: () {
                          print("Adicionar");
                        },
                        color: const Color(0xFFe0e0e0),
                        child: Text(
                          "Adicionar",
                        )),
                  ]),
              Container(
                height: 20.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Produto",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      width: 225.0,
                    ),
                    Container(
                      child: Text(
                        "Qtd",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      padding: const EdgeInsets.all(2.0),
                      alignment: Alignment.center,
                      width: 60.0,
                    ),
                    Container(
                      child: Text(
                        "Total",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      width: 85.0,
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Produto",
                      ),
                      padding: const EdgeInsets.all(2.0),
                      width: 225.0,
                    ),
                    Container(
                      child: Text(
                        "20",
                      ),
                      padding: const EdgeInsets.all(2.0),
                      alignment: Alignment.center,
                      width: 60.0,
                    ),
                    Container(
                      child: Text(
                        "R\$ 35,00",
                      ),
                      padding: const EdgeInsets.all(2.0),
                      alignment: Alignment.center,
                      width: 85.0,
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Produto2",
                      ),
                      padding: const EdgeInsets.all(2.0),
                      width: 225.0,
                    ),
                    Container(
                      child: Text(
                        "1",
                      ),
                      padding: const EdgeInsets.all(2.0),
                      alignment: Alignment.center,
                      width: 60.0,
                    ),
                    Container(
                      child: Text(
                        "R\$ 35,00",
                      ),
                      padding: const EdgeInsets.all(2.0),
                      alignment: Alignment.center,
                      width: 85.0,
                    ),
                  ]),
              Container(
                height: 20.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.red,
                        textColor: Colors.white,
                        key: null,
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
