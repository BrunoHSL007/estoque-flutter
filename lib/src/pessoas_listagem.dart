import 'dart:io';

import 'package:estoque_simples/src/pessoas_cadastro.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:estoque_simples/main.dart';

class PessoasListagem extends StatefulWidget {
  @override
  _PessoasListagemState createState() => _PessoasListagemState();
}

class _PessoasListagemState extends State<PessoasListagem> {
  var listaPessoas = new List<Map>();

  _PessoasListagemState() {
    consultaBanco();
  }

  void consultaBanco() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/estoque.db";
    // Abertura da conexão
    var database = await openDatabase(path, version: 2);

    var lista = await database.rawQuery('SELECT * from pessoas');
    for (var item in lista) {
      setState(() {
        Map dados = {
          'codigo': item['codigo'],
          'nome': item['nome'],
          'telefone': item['telefone'],
          'endereco': item['endereco'],
          'nascimento': item['nascimento'],
          'divida': item['divida']
        };
        this.listaPessoas.add(dados);
      });
    }
    await database.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          title: const Text('Pessoas'),
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
                        "Cadastro",
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
                                        new PessoasCadastro(0, true)));
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
                            'Nome',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          //width: 260.0,
                          //height: 30.0,
                        ),
                        Container(
                          child: Text(
                            'Dívida',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerRight,
                          //width: 50.0,
                          //height: 30.0,
                        ),
                      ]),
                  ListView.builder(
                      itemCount: this.listaPessoas.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return FlatButton(
                            padding: const EdgeInsets.all(0.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new PessoasCadastro(
                                          this.listaPessoas[index]['codigo'],
                                          true)));
                            },
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                        '${this.listaPessoas[index]['codigo']}'),
                                    padding: const EdgeInsets.all(0.0),
                                    alignment: Alignment.centerLeft,
                                    //width: 60.0,
                                    //height: 30.0,
                                  ),
                                  Container(
                                    child: Text(
                                        '${this.listaPessoas[index]['nome']}'),
                                    padding: const EdgeInsets.all(0.0),
                                    alignment: Alignment.centerLeft,
                                    //width: 260.0,
                                    //height: 30.0,
                                  ),
                                  Container(
                                    child: Text(
                                        '${this.listaPessoas[index]['divida']}'),
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
