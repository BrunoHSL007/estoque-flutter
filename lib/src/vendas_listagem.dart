import 'package:flutter/material.dart';
import 'package:estoque_simples/main.dart';

class VendasListagem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          title: const Text('Pessoas'),
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
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cliente",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "01/02/2020",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Cod Venda",
                              ),
                              padding: const EdgeInsets.all(2.0),
                            ),
                            Container(
                              child: Text(
                                "20 itens",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              alignment: Alignment.center,
                            ),
                            Container(
                              child: Text(
                                "R\$ 35,00",
                              ),
                              padding: const EdgeInsets.all(2.0),
                              alignment: Alignment.center,
                            ),
                          ]),
                    ]),
              ),
            ),
          ]),
        ));
  }
}
