import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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
  bool update = false;
  var qtdOriginal = 0;
  var quantidade = '';

  _ProdutosCadastroState(int idProduto) {
    this.codigoProduto = idProduto;
    if (this.codigoProduto != 0) {
      print('Alteração de produtos');
      this.update = true;
      consultaBanco();
    } else {
      print('Cadastro de um produto novo!');

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
    var query = await database.rawQuery('select * from produtos');
    print(query);
    print(update);
    await database.close();
  }

  void consultaBanco() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/estoque.db";
    // Abertura da conexão
    var database = await openDatabase(path, version: 1);

    // DELETE
    // await database.rawDelete("DELETE FROM pessoas where codigo=?", [1]);
    var listaProdutos = await database.query("produtos",
        columns: [
          "codigo",
          "descricao",
          "obs",
        ],
        where: "codigo=?",
        whereArgs: [this.codigoProduto]);

    for (var item in listaProdutos) {
      setState(() {
        this.codigoProduto = item['codigo'];
        this.descricao = item['descricao'];
        this.obs = item['obs'];
      });
    }
    var listaQuantidades = await database.query("movimento",
        columns: ["coalesce(sum(quantidade),0) as quantidade"],
        where: "produto=?",
        whereArgs: [this.codigoProduto]);

    for (var item in listaQuantidades) {
      setState(() {
        print('SetState ' + item.toString());
        this.qtdOriginal = item['quantidade'];
      });
    }
    this.quantidade = this.qtdOriginal.toString();
    print(this.codigoProduto);
    print(this.quantidade);
    await database.close();
  }

  void insereBanco() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/estoque.db";
    // Abertura da conexãocodigo
    var database = await openDatabase(path, version: 1);

    print(descricao);
    print(obs);
    print(this.update);
    print("quantidadeOriginal - quantidade:");
    print(this.qtdOriginal);
    print(this.quantidade);
    if (this.update) {
      print('Update');
      await database.rawUpdate(
          "UPDATE produtos SET descricao = ?, obs=? where codigo = ?",
          [descricao, obs, codigoProduto]);
    } else {
      print('Insert');
      await database.rawInsert(
          "INSERT INTO produtos(codigo, descricao,obs) VALUES(?,?,?)",
          [codigoProduto, descricao, obs]);
    }
    var aux = int.parse(this.quantidade);
    aux = aux - this.qtdOriginal;
    print('AUX: ' + aux.toString());
    await database.rawInsert(
        "INSERT INTO movimento(auxiliar,produto,quantidade) VALUES(?,?,?)",
        ["MV", codigoProduto, aux]);
    //await database.rawDelete('delete from movimento');
    //await database.rawDelete('delete from produtos');
    print('consultas');
    var queryPrd = await database.rawQuery("select * from produtos");
    print(queryPrd);
    var query = await database.rawQuery("select * from movimento");
    print(query);
    await database.close();
  }

  void deletaProduto() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/estoque.db";
    // Abertura da conexãocodigo
    var database = await openDatabase(path, version: 1);

    if (!this.update) {
      await database.rawDelete(
          'DELETE FROM produtos WHERE codigo = ?', [this.codigoProduto]);
      await database.rawDelete(
          'DELETE FROM movimento WHERE produto = ?', [this.codigoProduto]);
    }
    await database.close();
    print('produto deletado!');
    Navigator.of(context).pop();
  }

  void alteraQtd(int qtd) {
    var aux = int.parse(this.quantidade) + qtd;
    print(quantidade + ' + ' + qtd.toString());
    print(aux);
    setState(() {
      this.quantidade = aux.toString();
    });
  }

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
              Text(
                "Descrição",
              ),
              TextFormField(
                controller: TextEditingController(text: descricao),
                onChanged: (value) {
                  descricao = value;
                  print(descricao);
                },
              ),
              Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                width: 1.7976931348623157e+308,
                height: 5.0,
              ),
              // Text(
              //   "Grupo",
              // ),
              // TextField(),
              // Container(
              //   padding: const EdgeInsets.all(0.0),
              //   alignment: Alignment.center,
              //   width: 1.7976931348623157e+308,
              //   height: 5.0,
              // ),
              // Text(
              //   "SubGrupo",
              // ),
              // TextField(),
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
                        print('Diminui quantidade');
                        alteraQtd(-1);
                      },
                      iconSize: 32.0,
                      color: const Color(0xFF000000),
                    ),
                    Container(
                      width: 40,
                      child: TextFormField(
                        controller: TextEditingController(text: quantidade),
                        onChanged: (value) {
                          quantidade = value;
                          print(quantidade);
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
                        print('Aumenta quantidade');
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
              Text(
                "Obs",
              ),
              TextField(
                controller: TextEditingController(text: obs),
                onChanged: (value) {
                  obs = value;
                },
              ),
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
                        onPressed: () {},
                        color: const Color(0xFFe0e0e0),
                        child: Text(
                          "Movimentação",
                        )),
                    RaisedButton(
                        key: null,
                        onPressed: () {
                          print("Dívidas");
                        },
                        color: const Color(0xFFe0e0e0),
                        child: Text(
                          "Dívidas",
                        ))
                  ]),
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
                        child: Text(
                          "Deletar",
                        )),
                    RaisedButton(
                        key: null,
                        color: Colors.green,
                        textColor: Colors.white,
                        onPressed: () {
                          insereBanco();
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
