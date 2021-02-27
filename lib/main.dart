import 'dart:io';

import 'package:estoque_simples/src/compras.dart';
import 'package:estoque_simples/src/compras_listagem.dart';
import 'package:estoque_simples/src/dividas_listagem.dart';
import 'package:estoque_simples/src/pessoas_cadastro.dart';
import 'package:estoque_simples/src/produtos_cadastro.dart';
import 'package:estoque_simples/src/produtos_listagem.dart';
import 'package:estoque_simples/src/resumo.dart';
import 'package:estoque_simples/src/subgrupos_cadastro.dart';
import 'package:estoque_simples/src/vendas_listagem.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

//import 'fragment.dart';
import 'src/grupos_cadastro.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Estoque Simples',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Estoque Simples'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // Video aula do banco de dados: https://www.youtube.com/watch?v=C_nVmqQRjdk
  // Cria arquivo de banco de dados no dispositivo e cria tabelas dentro do arquivo
  void iniciaBanco() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/estoque.db";

    // Abertura da conexão
    var database = await openDatabase(path,
        version: 1, onUpgrade: (Database db, int version, int info) async {},
        onCreate: (Database db, int version) async {
      // TABELA PESSOAS
      await db.execute("CREATE TABLE pessoas(" +
          " codigo INTEGER PRIMARY KEY AUTOINCREMENT," +
          " nome TEXT," +
          " telefone TEXT," +
          " endereco TEXT," +
          " nascimento DATE," +
          " divida REAL" +
          ")");
      // TABELA PRODUTOS
      await db.execute("CREATE TABLE produtos(" +
          "  codigo INTEGER PRIMARY KEY AUTOINCREMENT," +
          "  descricao TEXT," +
          "  preco REAL," +
          "  grupo INTEGER," +
          "  subgrupo INTEGER," +
          "  obs TEXT" +
          ");");

      // TABELA GRUPO
      await db.execute("CREATE TABLE grupo(" +
          "  codigo INTEGER PRIMARY KEY AUTOINCREMENT," +
          "  descricao TEXT" +
          ");");

      // TABELA SUBGRUPO
      await db.execute("CREATE TABLE subgrupo(" +
          "  codigo INTEGER PRIMARY KEY AUTOINCREMENT," +
          "  grupo INTEGER," +
          "  descricao TEXT" +
          ");");

      // TABELA MOVIMENTO
      await db.execute("CREATE TABLE movimento(" +
          "  codigo INTEGER PRIMARY KEY AUTOINCREMENT," +
          "  auxiliar INTEGER," +
          "  es TEXT," +
          "  produto INTEGER," +
          "  valor REAL," +
          "  quantidade INTEGER," +
          "  pago BOOLEAN" +
          ");");

      // TABELA VENDA
      await db.execute("CREATE TABLE vendacompra(" +
          "  codigo INTEGER PRIMARY KEY AUTOINCREMENT," +
          "  tipo TEXT," +
          "  pessoa INTEGER," +
          "  data DATE		" +
          ");");
    });

    // INSERT
    //await database.rawInsert(
    //   "INSERT INTO pessoas(nome,telefone,endereco,nascimento) VALUES (?,?,?,?)",
    //    ["Bruno", "(45) 9 9999-9999", "Rua Teste, 123", "1998-01-28"]);

    // UPDATE
    await database.rawUpdate(
        "UPDATE pessoas set nome = ?, nascimento=? where codigo=?",
        ["ELIANE", "1975-02-16", 2]);

    // DELETE
    await database.rawDelete("DELETE FROM pessoas where codigo=?", [1]);
    var lista = await database.query("pessoas", columns: [
      "codigo",
      "nome",
      "telefone",
      "endereco",
      "nascimento",
      "divida"
    ]);
    print(lista);
    for (var item in lista) {
      setState(() {
        _lista += item['nome'] + '\n';
      });
    }

    await database.close();
  }

  String _lista = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('BrunoHSL007'),
              accountEmail: Text('brunohenrique.laier28@hotmail.com'),
              currentAccountPicture: const CircleAvatar(
                child: FlutterLogo(
                  size: 42.0,
                ),
              ),
            ),
            ListTile(
              title: Text('Resumo'),
              selected: 0 == _selectedIndex,
              onTap: () {
                _onSelectItem(0);
              },
            ),
            ListTile(
              title: Text('Cadastros'),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Pessoas'),
                    selected: 1 == _selectedIndex,
                    onTap: () {
                      _onSelectItem(1);
                    },
                  ),
                  ListTile(
                    title: Text('Produtos'),
                    selected: 2 == _selectedIndex,
                    onTap: () {
                      _onSelectItem(2);
                    },
                  ),
                  // ListTile(
                  //   title: Text('Grupos'),
                  //   selected: 3 == _selectedIndex,
                  //   onTap: () {
                  //     _onSelectItem(3);
                  //   },
                  // ),
                  // ListTile(
                  //   title: Text('SubGrupos'),
                  //   selected: 4 == _selectedIndex,
                  //   onTap: () {
                  //     _onSelectItem(4);
                  //   },
                  // ),
                ],
              ),
            ),
            ListTile(
              title: Text('Vendas'),
              selected: 5 == _selectedIndex,
              onTap: () {
                _onSelectItem(5);
              },
            ),
            ListTile(
              title: Text('Compras'),
              selected: 6 == _selectedIndex,
              onTap: () {
                _onSelectItem(8);
              },
            ),
            ListTile(
              title: Text('Dívidas'),
              selected: 7 == _selectedIndex,
              onTap: () {
                _onSelectItem(7);
              },
            ),
          ],
        ),
      ),
      body: _getDrawerItem(_selectedIndex),
      //floatingActionButton: FloatingActionButton(
      //  child: Icon(Icons.add_circle),
      //  onPressed: _onSelectItem(8),
      //),
    );
  }

  _getDrawerItem(int pos) {
    switch (pos) {
      case 0:
        return Resumo();
      case 1:
        return PessoasCadastro();
      case 2:
        return ProdutosListagem(); //ProdutosCadastro(29); // 0 significa cadastrar novo produto
      case 3:
        return GruposCadastro();
      case 4:
        return SubGruposCadastro();
      case 5:
        return VendasListagem();
      case 6:
        return ComprasListagem();
      case 7:
        return DividasListagem();
      case 8:
        return Compras();
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedIndex = index);
    Navigator.of(context).pop();
  }
}
