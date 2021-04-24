import 'dart:io';

import 'package:estoque_simples/src/pessoas_listagem.dart';
import 'package:flutter/material.dart';
import 'package:estoque_simples/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:masked_text/masked_text.dart';

class PessoasCadastro extends StatefulWidget {
  final int idPessoa;
  final bool voltaPessoasListagem;

  const PessoasCadastro(this.idPessoa, this.voltaPessoasListagem);
  @override
  _PessoasCadastroState createState() =>
      _PessoasCadastroState(this.idPessoa, this.voltaPessoasListagem);
}

class _PessoasCadastroState extends State<PessoasCadastro> {
  var codigoPessoa = 0;
  var nome = '';
  var telefone = '';
  var endereco = '';
  var nascimento = '';
  bool update = false;
  var divida = '';
  DateTime data;
  bool voltaListagem = false;

  _PessoasCadastroState(int idPessoa, bool voltaPessoasListagem) {
    this.codigoPessoa = idPessoa;
    this.voltaListagem = voltaPessoasListagem;
    if (this.codigoPessoa != 0) {
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
    var database = await openDatabase(path, version: 2);
    var retorno = await database.query(
      "pessoas",
      columns: ["coalesce(max(codigo),0) as codigo"],
    );
    for (var item in retorno) {
      setState(() {
        this.codigoPessoa = item['codigo'] + 1;
      });
    }
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
    var listaProdutos = await database.query("pessoas",
        columns: [
          "codigo",
          " nome",
          " telefone",
          " endereco",
          " nascimento",
          " divida",
        ],
        where: "codigo=?",
        whereArgs: [this.codigoPessoa]);

    for (var item in listaProdutos) {
      setState(() {
        this.codigoPessoa = item['codigo'];
        this.nome = item['nome'];
        this.telefone = item['telefone'];
        this.endereco = item['endereco'];
        this.nascimento = item['nascimento'];
        this.divida = item['divida'];
      });
    }
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
          "UPDATE pessoas SET nome = ?, telefone=?, endereco=?, nascimento=?, divida=? where codigo = ?",
          [nome, telefone, endereco, nascimento, divida, codigoPessoa]);
    } else {
      await database.rawInsert(
          "INSERT INTO pessoas(codigo,nome,telefone,endereco,nascimento,divida) VALUES(?,?,?,?,?,?)",
          [codigoPessoa, nome, telefone, endereco, nascimento, divida]);
    }
    //await database.rawDelete('delete from movimento');
    //await database.rawDelete('delete from produtos');
    await database.close();
    Navigator.pop(context);
    if (voltaListagem) {
      Navigator.pop(context);
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new PessoasListagem()));
    }
  }

  void deletaPessoa() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/estoque.db";
    // Abertura da conexãocodigo
    var database = await openDatabase(path, version: 2);

    if (this.update) {
      await database.rawDelete(
          'DELETE FROM pessoas WHERE codigo = ?', [this.codigoPessoa]);
    }
    await database.close();
    Navigator.pop(context);
    if (voltaListagem) {
      Navigator.pop(context);
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new PessoasListagem()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          title: Text(update ? "Editar" : "Cadastrar"),
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
                        ? "Codigo: $codigoPessoa"
                        : "Codigo: $codigoPessoa - Nova Pessoa",
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
                    "Nome",
                  ),
                  TextFormField(
                    controller: TextEditingController(text: nome),
                    onChanged: (value) {
                      nome = value;
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    alignment: Alignment.center,
                    width: 1.7976931348623157e+308,
                    height: 5.0,
                  ),
                  Text(
                    "Telefone",
                  ),
                  MaskedTextField(
                    maskedTextFieldController:
                        TextEditingController(text: telefone),
                    mask: "(xx) x xxxx-xxxx",
                    maxLength: 16,
                    keyboardType: TextInputType.number,
                    onChange: (value) {
                      telefone = value;
                    },
                  ),
                  // TextFormField(
                  //   controller: TextEditingController(text: telefone),
                  //   onChanged: (value) {
                  //     telefone = value;
                  //   },
                  // ),
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    alignment: Alignment.center,
                    width: 1.7976931348623157e+308,
                    height: 5.0,
                  ),
                  Text(
                    "Endereço",
                  ),
                  TextFormField(
                    controller: TextEditingController(text: endereco),
                    onChanged: (value) {
                      endereco = value;
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    alignment: Alignment.center,
                    width: 1.7976931348623157e+308,
                    height: 5.0,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Nascimento",
                          ),
                          Container(
                            width: 100,
                            height: 22,
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: TextField(
                              controller:
                                  TextEditingController(text: nascimento),
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2050))
                                    .then((date) {
                                  setState(() {
                                    data = date;
                                  });
                                  nascimento =
                                      DateFormat("dd/MM/yyyy").format(data);
                                });
                              },
                              readOnly: true,
                              onChanged: (value) {
                                nascimento = value;
                              },
                            ),
                          ),
                        ]),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                            key: null,
                            onPressed: () {
                              print("Movimentação");
                            },
                            color: const Color(0xFFe0e0e0),
                            child: Container(
                                alignment: Alignment.center,
                                width: 120,
                                child: Text(
                                  "Movimentação",
                                ))),
                        RaisedButton(
                            key: null,
                            onPressed: () {
                              print("Dívidas");
                            },
                            color: const Color(0xFFe0e0e0),
                            child: Container(
                                alignment: Alignment.center,
                                width: 120,
                                child: Text(
                                  "Dívidas",
                                )))
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                            key: null,
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () {
                              deletaPessoa();
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
