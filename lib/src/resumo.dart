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
        body: Center(
          child: ListView(children: [
            // Card Dividas
            Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(12.0),
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              width: 200.0,
                              height: 10.0,
                            ),
                            Container(
                              child: Text(
                                "Data",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              padding: const EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              width: 85.0,
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

                      // Lista de informações
                      // Expanded(
                      //   child: ListView.builder(
                      //     shrinkWrap: true,
                      //     itemCount: 10,
                      //     itemBuilder: (context, index) {
                      //       return ListTile(
                      //         title: Text("Teste"),
                      //       );
                      //     },
                      //   ),
                      // ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Pessoa 1",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              width: 200.0,
                            ),
                            Container(
                              child: Text(
                                "01/02/2020",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              alignment: Alignment.center,
                              width: 85.0,
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
                                "Pessoa 2",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              width: 200.0,
                            ),
                            Container(
                              child: Text(
                                "01/02/2020",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              alignment: Alignment.center,
                              width: 85.0,
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
                    ]),
                // Fim da Lista de informações
              ),
            ),

            // Card ultimas vendas
            Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Últimas Vendas",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              width: 200.0,
                              height: 10.0,
                            ),
                            Container(
                              child: Text(
                                "Data",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              padding: const EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              width: 85.0,
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

                      // Lista de informações
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Pessoa 1",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              width: 200.0,
                            ),
                            Container(
                              child: Text(
                                "01/02/2020",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              alignment: Alignment.center,
                              width: 85.0,
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
                                "Pessoa 2",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              width: 200.0,
                            ),
                            Container(
                              child: Text(
                                "01/02/2020",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              alignment: Alignment.center,
                              width: 85.0,
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
                    ]),
                // Fim da Lista de informações
              ),
            ),

            // Ultimas Compras
            Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Últimas Compras",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              width: 200.0,
                              height: 10.0,
                            ),
                            Container(
                              child: Text(
                                "Data",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              padding: const EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              width: 85.0,
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

                      // Lista de informações
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Pessoa 1",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              width: 200.0,
                            ),
                            Container(
                              child: Text(
                                "01/02/2020",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              alignment: Alignment.center,
                              width: 85.0,
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
                                "Pessoa 2",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              width: 200.0,
                            ),
                            Container(
                              child: Text(
                                "01/02/2020",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              alignment: Alignment.center,
                              width: 85.0,
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
                    ]),
                // Fim da Lista de informações
              ),
            ),

            // Produtos Mais Vendidos
            Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Produtos Mais Vendidos",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              width: 200.0,
                              height: 10.0,
                            ),
                            Container(
                              child: Text(
                                "Quantidade",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              padding: const EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              width: 85.0,
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

                      // Lista de informações
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Produto 1",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              width: 200.0,
                            ),
                            Container(
                              child: Text(
                                "25",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              alignment: Alignment.center,
                              width: 85.0,
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
                                "Produto 2",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              width: 200.0,
                            ),
                            Container(
                              child: Text(
                                "32",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              alignment: Alignment.center,
                              width: 85.0,
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
                    ]),
                // Fim da Lista de informações
              ),
            ),
          ]),
        ));
  }
}
