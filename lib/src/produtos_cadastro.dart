import 'dart:io';

import 'package:estoque_simples/src/produtos_listagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:estoque_simples/main.dart';

class ProdutosCadastro extends StatefulWidget {
  final int idProduto;

  const ProdutosCadastro(this.idProduto);
  @override
  _ProdutosCadastroState createState() =>
      _ProdutosCadastroState(this.idProduto);
}

class _ProdutosCadastroState extends State<ProdutosCadastro> {
  var codigoProduto = 0;
  var descricao = '';
  var obs = '';
  var preco = '';
  bool update = false;
  var qtdOriginal = 0;
  var quantidade = '';

  _ProdutosCadastroState(int idProduto) {
    this.codigoProduto = idProduto;
    if (this.codigoProduto != 0) {
      // Alteração de produtos
      this.update = true;
      consultaBanco();
    } else {
      // Cadastro de um produto novo
      proximoCodigo();
    }
  }

  void proximoCodigo() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/estoque.db";
    // Abertura da conexão
    var database = await openDatabase(path, version: 1);
    var retorno = await database.query(
      "produtos",
      columns: ["coalesce(max(codigo),0) as codigo"],
    );
    for (var item in retorno) {
      setState(() {
        this.codigoProduto = item['codigo'] + 1;
      });
    }
    this.qtdOriginal = 0;
    this.quantidade = this.qtdOriginal.toString();
    await database.close();
  }

  void consultaBanco() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/estoque.db";
    // Abertura da conexão
    var database = await openDatabase(path, version: 2);

    // DELETE
    // await database.rawDelete("DELETE FROM pessoas where codigo=?", [1]);
    var listaProdutos = await database.query("produtos",
        columns: [
          "codigo",
          "descricao",
          "preco",
          "obs",
        ],
        where: "codigo=?",
        whereArgs: [this.codigoProduto]);

    for (var item in listaProdutos) {
      setState(() {
        this.codigoProduto = item['codigo'];
        this.descricao = item['descricao'];
        this.preco = item['preco'].toString();
        this.obs = item['obs'];
      });
    }
    var listaQuantidades = await database.query("movimento",
        columns: ["coalesce(sum(quantidade),0) as quantidade"],
        where: "produto=?",
        whereArgs: [this.codigoProduto]);

    for (var item in listaQuantidades) {
      setState(() {
        this.qtdOriginal = item['quantidade'];
      });
    }
    this.quantidade = this.qtdOriginal.toString();
    await database.close();
  }

  void insereBanco() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/estoque.db";
    // Abertura da conexão
    var database = await openDatabase(path, version: 2);

    if (this.update) {
      await database.rawUpdate(
          "UPDATE produtos SET descricao = ?, obs=?, preco=? where codigo = ?",
          [descricao, obs, preco, codigoProduto]);
    } else {
      await database.rawInsert(
          "INSERT INTO produtos(codigo, descricao,obs,preco) VALUES(?,?,?,?)",
          [codigoProduto, descricao, obs, preco]);
    }
    var aux = int.parse(this.quantidade);
    aux = aux - this.qtdOriginal;
    await database.rawInsert(
        "INSERT INTO movimento(auxiliar,produto,quantidade,valor) VALUES(?,?,?,?)",
        ["MV", codigoProduto, aux, preco * aux]);
    await database.close();
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new ProdutosListagem()));
  }

  void deletaProduto() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/estoque.db";
    // Abertura da conexãocodigo
    var database = await openDatabase(path, version: 2);

    if (this.update) {
      await database.rawDelete(
          'DELETE FROM produtos WHERE codigo = ?', [this.codigoProduto]);
      await database.rawDelete(
          'DELETE FROM movimento WHERE produto = ?', [this.codigoProduto]);
    }
    await database.close();
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new ProdutosListagem()));
  }

  void alteraQtd(int qtd) {
    var aux = int.parse(this.quantidade) + qtd;
    setState(() {
      this.quantidade = aux.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          title: Text(update ? "Editar Produto" : "Novo Produto"),
        ),
        drawer: DrawerOnly(),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    update
                        ? "Codigo: $codigoProduto"
                        : "Codigo: $codigoProduto - Novo Produto",
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
                  TextFormField(
                    controller: TextEditingController(text: descricao),
                    onChanged: (value) {
                      descricao = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Descrição",
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    alignment: Alignment.center,
                    width: 1.7976931348623157e+308,
                    height: 5.0,
                  ),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.exposure_minus_1),
                          onPressed: () {
                            // Diminui quantidade
                            alteraQtd(-1);
                          },
                          iconSize: 32.0,
                          color: const Color(0xFF000000),
                        ),
                        Container(
                          width: 40,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: TextEditingController(text: quantidade),
                            onChanged: (value) {
                              quantidade = value;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.plus_one),
                          onPressed: () {
                            // Aumenta quantidade
                            alteraQtd(1);
                          },
                          iconSize: 32.0,
                          color: const Color(0xFF000000),
                        )
                      ]),
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    alignment: Alignment.center,
                    width: 1.7976931348623157e+308,
                    height: 5.0,
                  ),
                  TextField(
                    controller: TextEditingController(text: preco),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    onChanged: (value) {
                      preco = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Preço",
                    ),
                  ),
                  TextField(
                    controller: TextEditingController(text: obs),
                    onChanged: (value) {
                      obs = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Observação",
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    alignment: Alignment.center,
                    width: 1.7976931348623157e+308,
                    height: 5.0,
                  ),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     mainAxisSize: MainAxisSize.max,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: <Widget>[
                  //       RaisedButton(
                  //           key: null,
                  //           onPressed: () {},
                  //           color: const Color(0xFFe0e0e0),
                  //           child: Container(
                  //               alignment: Alignment.center,
                  //               width: 120,
                  //               child: Text(
                  //                 "Movimentação",
                  //               ))),
                  //       RaisedButton(
                  //           key: null,
                  //           onPressed: () {
                  //             print("Dívidas");
                  //           },
                  //           color: const Color(0xFFe0e0e0),
                  //           child: Container(
                  //             alignment: Alignment.center,
                  //             width: 120,
                  //             child: Text(
                  //               "Dívidas",
                  //             ),
                  //           ))
                  //     ]),
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
                              deletaProduto();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                width: 120,
                                child: Text(
                                  "Deletar",
                                ))),
                        RaisedButton(
                            key: null,
                            color: Colors.green,
                            textColor: Colors.white,
                            onPressed: () {
                              insereBanco();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                width: 120,
                                child: Text(
                                  "Salvar",
                                )))
                      ])
                ]),
          ),
        ));
  }
}
