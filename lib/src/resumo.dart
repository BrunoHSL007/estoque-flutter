import 'dart:io';

import 'package:estoque_simples/src/vendas_cadastro.dart';
import 'package:flutter/material.dart';
import 'package:estoque_simples/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class Resumo extends StatefulWidget {
  @override
  _ResumoState createState() => _ResumoState();
}

class _ResumoState extends State<Resumo> {
  var listaUltimasVendas = new List<Map>();
  NumberFormat realFormato = NumberFormat("##0.00");

  _ResumoState() {
    ultimasVendas();
  }
  void ultimasVendas() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = documentsDirectory.path + "/estoque.db";
      // Abertura da conexão
      var dbUltimasVendas = await openDatabase(path, version: 1);

      var lista = await dbUltimasVendas.rawQuery(
          'SELECT *,vendacompra.codigo as codVenda from vendacompra' +
              ' inner join pessoas on vendacompra.pessoa = pessoas.codigo order by codigo desc limit 10');
      await dbUltimasVendas.close();
      print(lista);
      for (var item in lista) {
        setState(() {
          Map dados = {
            'cliente': item['pessoa'].toString() + ' - ' + item['nome'],
            'data': item['data'],
            'venda': item['codVenda'],
            'total': item['total']
          };
          this.listaUltimasVendas.add(dados);
        });
      }
    } on Exception catch (e) {
      print(e);
    }
  }

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
                      ListView.builder(
                          itemCount: this.listaUltimasVendas.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        listaUltimasVendas[index]['cliente'],
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        listaUltimasVendas[index]['data'],
                                      ),
                                      alignment: Alignment.center,
                                      width: 85.0,
                                    ),
                                    Container(
                                      child: Text(
                                        "R\$ ${realFormato.format(listaUltimasVendas[index]['total'])}",
                                      ),
                                      alignment: Alignment.center,
                                      width: 85.0,
                                    ),
                                  ]),
                            );
                          }),
                    ]),
                // Fim da Lista de informações
              ),
            ),

            // Produtos Mais Vendidos
            // Card(
            //   elevation: 10,
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            //     child: Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         mainAxisSize: MainAxisSize.max,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           Text(
            //             "Produtos mais vendidos",
            //             style: TextStyle(
            //                 fontSize: 18.0, fontWeight: FontWeight.w400),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 8),
            //             child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 mainAxisSize: MainAxisSize.max,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: <Widget>[
            //                   Expanded(
            //                     child: Container(
            //                       height: 10,
            //                     ),
            //                   ),
            //                   Container(
            //                     child: Text(
            //                       "Quantidade",
            //                       style: TextStyle(fontWeight: FontWeight.w500),
            //                     ),
            //                     alignment: Alignment.center,
            //                     width: 85.0,
            //                   ),
            //                   Container(
            //                     child: Text(
            //                       "Total",
            //                       style: TextStyle(fontWeight: FontWeight.w500),
            //                     ),
            //                     alignment: Alignment.center,
            //                     width: 85.0,
            //                   ),
            //                 ]),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 2.0),
            //             child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 mainAxisSize: MainAxisSize.max,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: <Widget>[
            //                   Expanded(
            //                     child: Text(
            //                       "Pessoa 1",
            //                     ),
            //                   ),
            //                   Container(
            //                     child: Text(
            //                       "25",
            //                     ),
            //                     alignment: Alignment.center,
            //                     width: 85.0,
            //                   ),
            //                   Container(
            //                     child: Text(
            //                       "R\$ 35,00",
            //                     ),
            //                     alignment: Alignment.center,
            //                     width: 85.0,
            //                   ),
            //                 ]),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 2.0),
            //             child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 mainAxisSize: MainAxisSize.max,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: <Widget>[
            //                   Expanded(
            //                     child: Text(
            //                       "Pessoa 2",
            //                     ),
            //                   ),
            //                   Container(
            //                     child: Text(
            //                       "32",
            //                     ),
            //                     alignment: Alignment.center,
            //                     width: 85.0,
            //                   ),
            //                   Container(
            //                     child: Text(
            //                       "R\$ 35,00",
            //                     ),
            //                     alignment: Alignment.center,
            //                     width: 85.0,
            //                   ),
            //                 ]),
            //           ),
            //         ]),
            //     // Fim da Lista de informações
            //   ),
            // ),
          ]),
        ));
  }
}
