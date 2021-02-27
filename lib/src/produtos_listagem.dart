import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ProdutosListagem extends StatefulWidget {
  @override
  _ProdutosListagemState createState() => _ProdutosListagemState();
}

class _ProdutosListagemState extends State<ProdutosListagem> {
  var listaProdutos = new List<Map>();

  _ProdutosListagemState() {
    print('Função');
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
    print(lista);
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
    return //Center(
        //   child: Card(
        //     elevation: 10,
        //     child: Padding(
        //         padding: EdgeInsets.all(12.0),
        //         child:
        ListView.builder(
            itemCount: this.listaProdutos.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                    '${this.listaProdutos[index]['codigo']}    ${this.listaProdutos[index]['descricao']}       ${this.listaProdutos[index]['quantidade']}'),
              );
            });
    // Fim da Lista de informações
    //         ),
    //   ),
    // );
  }
}
