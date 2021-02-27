import 'package:flutter/material.dart';

class DividasListagem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cliente",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "20 dias",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cliente",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "30 dias",
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
                ]),
            // Fim da Lista de informações
          ),
        ),
      ]),
    );
  }
}
