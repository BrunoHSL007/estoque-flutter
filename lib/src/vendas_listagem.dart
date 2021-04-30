import 'dart:io';

import 'package:estoque_simples/src/vendas_cadastro.dart';
import 'package:flutter/material.dart';
import 'package:estoque_simples/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class VendasListagem extends StatefulWidget {
  @override
  _VendasListagemState createState() => _VendasListagemState();
}

class _VendasListagemState extends State<VendasListagem> {
  var listaVendas = new List<Map>();
  NumberFormat realFormato = NumberFormat("##0.00");

  _VendasListagemState() {
    consultaBanco();
  }

  void consultaBanco() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/estoque.db";
    // Abertura da conexão
    var database = await openDatabase(path, version: 1);

    var lista = await database.rawQuery(
        'SELECT *,vendacompra.codigo as codVenda from vendacompra' +
            ' inner join pessoas on vendacompra.pessoa = pessoas.codigo order by codigo desc');

    for (var item in lista) {
      setState(() {
        Map dados = {
          'cliente': item['pessoa'].toString() + ' - ' + item['nome'],
          'data': item['data'],
          'venda': item['codVenda'],
          'tipo': item['tipo'],
          'total': item['total'],
          'pago': item['pago'],
          'quantidade': item['quantidade'],
          'divida': item['divida']
        };
        this.listaVendas.add(dados);
      });
    }
    await database.close();
  }

  Color cardColor(double total, double pago, DateTime data) {
    if (data.isAfter(DateTime.now())) {
      return Colors.yellow;
    } else if (total == pago) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          title: const Text('Vendas'),
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
        body: ListView.builder(
            itemCount: this.listaVendas.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  await Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new VendasCadastro(
                              this.listaVendas[index]['venda'])));
                },
                child: Card(
                  elevation: 10,
                  color: cardColor(
                      listaVendas[index]['total'],
                      listaVendas[index]['pago'],
                      DateFormat("dd/MM/yyyy")
                          .parse(listaVendas[index]['data'])),
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      color: Colors.white,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    listaVendas[index]['cliente'],
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    listaVendas[index]['data'],
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Venda: ${listaVendas[index]['venda'].toString()} - ${listaVendas[index]['tipo']}",
                                    ),
                                    Text(
                                      "Total: R\$ ${realFormato.format(listaVendas[index]['total'])}",
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Itens: ${listaVendas[index]['quantidade']}",
                                    ),
                                    Text(
                                      "Pago: R\$ ${realFormato.format(listaVendas[index]['pago'])}",
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "", //Divida Cliente: R\$${listaVendas[index]['divida']}",
                                    ),
                                    Text(
                                      listaVendas[index]['total'] -
                                                  listaVendas[index]['pago'] !=
                                              0
                                          ? "Falta: R\$ ${realFormato.format(listaVendas[index]['total'] - listaVendas[index]['pago'])}"
                                          : "Pago",
                                    ),
                                  ]),
                            ),
                          ]),
                    ),
                  ),
                ),
              );
            }));
  }
}
