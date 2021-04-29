import 'dart:io';

import 'package:estoque_simples/src/produtos_cadastro.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:estoque_simples/main.dart';

class ProdutosListagem extends StatefulWidget {
  @override
  _ProdutosListagemState createState() => _ProdutosListagemState();
}

class _ProdutosListagemState extends State<ProdutosListagem> {
  var listaProdutos = new List<Map>();

  _ProdutosListagemState() {
    consultaBanco();
  }

  void consultaBanco() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/estoque.db";
    // Abertura da conexão
    var database = await openDatabase(path, version: 1);

    var lista = await database.rawQuery(
        'SELECT produtos.codigo,produtos.descricao,produtos.obs,coalesce(sum(quantidade),0) as quantidade from produtos inner join movimento on produtos.codigo = movimento.produto group by produtos.codigo,produtos.descricao,produtos.obs');
    for (var item in lista) {
      setState(() {
        Map dados = {
          'codigo': item['codigo'],
          'descricao': item['descricao'],
          'obs': item['obs'],
          'quantidade': item['quantidade']
        };
        this.listaProdutos.add(dados);
      });
    }
    await database.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          title: const Text('Produtos'),
        ),
        drawer: DrawerOnly(),
        body: Card(
          elevation: 10,
          child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Estoque",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        new ProdutosCadastro(0)));
                          })
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    height: 10.0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Código',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          //width: 60.0,
                          //height: 30.0,
                        ),
                        Container(
                          child: Text(
                            'Descrição',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          //width: 260.0,
                          //height: 30.0,
                        ),
                        Container(
                          child: Text(
                            'Qtd.',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerRight,
                          //width: 50.0,
                          //height: 30.0,
                        ),
                      ]),
                  ListView.builder(
                      itemCount: this.listaProdutos.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return FlatButton(
                            padding: const EdgeInsets.all(0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new ProdutosCadastro(
                                              this.listaProdutos[index]
                                                  ['codigo'])));
                            },
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                        '${this.listaProdutos[index]['codigo']}'),
                                    padding: const EdgeInsets.all(0.0),
                                    alignment: Alignment.centerLeft,
                                    //width: 60.0,
                                    //height: 30.0,
                                  ),
                                  Container(
                                    child: Text(
                                        '${this.listaProdutos[index]['descricao']}'),
                                    padding: const EdgeInsets.all(0.0),
                                    alignment: Alignment.centerLeft,
                                    //width: 260.0,
                                    //height: 30.0,
                                  ),
                                  Container(
                                    child: Text(
                                        '${this.listaProdutos[index]['quantidade']}'),
                                    padding: const EdgeInsets.all(0.0),
                                    alignment: Alignment.centerRight,
                                    //width: 50.0,
                                    //height: 30.0,
                                  ),
                                ]));
                      })
                ],
              )

              //Fim da Lista de informações
              ),
        ));
  }
}
