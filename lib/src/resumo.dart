import 'package:estoque_simples/src/vendas_cadastro.dart';
import 'package:flutter/material.dart';
import 'package:estoque_simples/main.dart';

class Resumo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          title: const Text('Estoque Simples'),
        ),
        drawer: DrawerOnly(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new VendasCadastro(0)));
          },
          child: const Icon(Icons.add_shopping_cart),
        ),
        body: Center(
          child: ListView(children: [
            // Card Dividas
            Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Dividas",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 10,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Data",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                              Container(
                                child: Text(
                                  "Total",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Pessoa 1",
                                ),
                              ),
                              Container(
                                child: Text(
                                  "01/02/2020",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                              Container(
                                child: Text(
                                  "R\$ 35,00",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Pessoa 2",
                                ),
                              ),
                              Container(
                                child: Text(
                                  "01/02/2020",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                              Container(
                                child: Text(
                                  "R\$ 35,00",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                            ]),
                      ),
                    ]),
                // Fim da Lista de informações
              ),
            ),

            // Card ultimas vendas
            Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Últimas vendas",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 10,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Data",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                              Container(
                                child: Text(
                                  "Total",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Pessoa 1",
                                ),
                              ),
                              Container(
                                child: Text(
                                  "01/02/2020",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                              Container(
                                child: Text(
                                  "R\$ 35,00",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Pessoa 2",
                                ),
                              ),
                              Container(
                                child: Text(
                                  "01/02/2020",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                              Container(
                                child: Text(
                                  "R\$ 35,00",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                            ]),
                      ),
                    ]),
                // Fim da Lista de informações
              ),
            ),

            // Ultimas Compras
            Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Últimas compras",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 10,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Data",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                              Container(
                                child: Text(
                                  "Total",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Pessoa 1",
                                ),
                              ),
                              Container(
                                child: Text(
                                  "01/02/2020",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                              Container(
                                child: Text(
                                  "R\$ 35,00",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Pessoa 2",
                                ),
                              ),
                              Container(
                                child: Text(
                                  "01/02/2020",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                              Container(
                                child: Text(
                                  "R\$ 35,00",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                            ]),
                      ),
                    ]),
                // Fim da Lista de informações
              ),
            ),

            // Produtos Mais Vendidos
            Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Produtos mais vendidos",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 10,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Quantidade",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                              Container(
                                child: Text(
                                  "Total",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Pessoa 1",
                                ),
                              ),
                              Container(
                                child: Text(
                                  "25",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                              Container(
                                child: Text(
                                  "R\$ 35,00",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Pessoa 2",
                                ),
                              ),
                              Container(
                                child: Text(
                                  "32",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                              Container(
                                child: Text(
                                  "R\$ 35,00",
                                ),
                                alignment: Alignment.center,
                                width: 85.0,
                              ),
                            ]),
                      ),
                    ]),
                // Fim da Lista de informações
              ),
            ),
          ]),
        ));
  }
}
