import 'dart:io';
import 'dart:math';

import 'package:estoque_simples/src/pessoas_cadastro.dart';
import 'package:estoque_simples/src/produtos_listagem.dart';
import 'package:estoque_simples/src/vendas_listagem.dart';
import 'package:flutter/material.dart';
import 'package:estoque_simples/main.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class VendasCadastro extends StatefulWidget {
  final int idVenda;

  const VendasCadastro(this.idVenda);
  @override
  _VendasCadastroState createState() => _VendasCadastroState(this.idVenda);
}

class _VendasCadastroState extends State<VendasCadastro> {
  var codigoVenda = 0;
  var codigoMovimento = 0;
  var qtdOriginal = 1;
  var quantidade = '';

  var mapProdutos = new List<Map>();
  var mapItensSelecionados = new List<Map>();

  // DropDown
  List<String> listaPessoas = [];
  List<String> listaProdutos = [];

  // Indice do produto selecionado no DropDown
  var indexProduto = -1;

  // Totais da venda
  var totalVenda = 0.00;
  var totalQtd = 0;
  var totalPago = 0.00;
  var pagar = '';

  // nova venda ou editar
  bool update = false;

  //Formato de moeda para ser apresentado na tela
  NumberFormat realFormato = NumberFormat("##0.00");

  // Item do dropdown selecionado
  String pessoaSelecionada;
  String itemSelecionado;

  //Datas da venda
  var dataEntrega = '';
  DateTime data = DateTime.now();

  // Formas de pagamento
  List<String> listaTiposPagamento = [
    'Dinheiro',
    'Pix',
    'Cartão',
    'Transferência'
  ];
  String tipoPagamento = 'Dinheiro';

  // Funções //
  _VendasCadastroState(int idVenda) {
    this.codigoVenda = idVenda;
    this.itemSelecionado = null;
    this.qtdOriginal = 1;
    this.quantidade = this.qtdOriginal.toString();
    if (this.codigoVenda != 0) {
      // Alteração de produtos
      this.update = true;
      consultaBanco();
      carregaCampos();
    } else {
      // Cadastro de um produto novo
      proximoCodigo();
      consultaBanco();
    }
    dataEntrega = DateFormat("dd/MM/yyyy").format(data);
  }

  void proximoCodigo() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/estoque.db";
    // Abertura da conexão
    if (!update) {
      var dbVendaCompra = await openDatabase(path, version: 1);
      var retornoVendaCompra = await dbVendaCompra.query(
        "vendacompra",
        columns: ["coalesce(max(codigo),0) as codigo"],
      );
      await dbVendaCompra.close();
      for (var item in retornoVendaCompra) {
        setState(() {
          this.codigoVenda = item['codigo'] + 1;
        });
      }
    }

    var dbMovimento = await openDatabase(path, version: 1);
    var retornoMovimento = await dbMovimento.query(
      "movimento",
      columns: ["coalesce(max(codigo),0) as codigo"],
    );
    await dbMovimento.close();

    for (var item in retornoMovimento) {
      setState(() {
        this.codigoMovimento = item['codigo'] + 1;
      });
    }
  }

  void carregaCampos() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/estoque.db";
    var dbVenda = await openDatabase(path, version: 2);
    var dadosLista = await dbVenda.rawQuery(
        'select vendaCompra.*,pessoas.nome from vendaCompra' +
            ' inner join pessoas on vendaCompra.pessoa = pessoas.codigo ' +
            ' where vendaCompra.codigo=?',
        [this.codigoVenda]);
    await dbVenda.close();
    for (var item in dadosLista) {
      setState(() {
        this.pessoaSelecionada =
            item['pessoa'].toString() + ' - ' + item['nome'];
        this.dataEntrega = item['data'];
        this.totalVenda = item['total'];
        this.totalQtd = item['quantidade'];
        this.totalPago = item['pago'];
      });
    }
    var dbProdutos = await openDatabase(path, version: 2);
    var itlista = await dbProdutos.rawQuery(
        'select produtos.*,coalesce(sum(movimento.quantidade),0) as quantidade' +
            ' from movimento ' +
            ' inner join produtos on produtos.codigo = movimento.produto ' +
            ' where movimento.auxiliar=?' +
            ' group by produtos.codigo',
        [this.codigoVenda]);
    await dbProdutos.close();
    print(itlista);
    for (var item in itlista) {
      setState(() {
        Map dados = {
          'codigo': item['codigo'],
          'descricao': item['descricao'],
          'unitario': item['preco'],
          'total': item['preco'] * item['quantidade'] * -1,
          'quantidade': item['quantidade'] * -1
        };
        this.mapItensSelecionados.add(dados);
      });
    }
  }

  void consultaBanco() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = documentsDirectory.path + "/estoque.db";

      // Abertura da conexão
      var database = await openDatabase(path, version: 2);

      listaPessoas = [];
      listaProdutos = [];
      mapProdutos = new List<Map>();

      // Busca Produtos
      var itlista = await database.rawQuery(
          'select produtos.*,coalesce(sum(quantidade),0) as quantidade from produtos ' +
              'inner join movimento on produtos.codigo = movimento.produto ' +
              'group by produtos.codigo');
      for (var item in itlista) {
        setState(() {
          this
              .listaProdutos
              .add(item['codigo'].toString() + ' - ' + item['descricao']);
        });
        setState(() {
          Map dados = {
            'codigo': item['codigo'],
            'descricao': item['descricao'],
            'preco': item['preco'],
            'obs': item['obs'],
            'quantidade': item['quantidade']
          };
          this.mapProdutos.add(dados);
        });
      }

      await database.close();

      // Busca clientes
      var dbPessoas = await openDatabase(path, version: 2);

      var peslista = await dbPessoas.rawQuery('SELECT * from pessoas');
      await dbPessoas.close();

      for (var item in peslista) {
        setState(() {
          this
              .listaPessoas
              .add(item['codigo'].toString() + ' - ' + item['nome']);
        });
      }
    } catch (ex) {
      print(ex);
    }
  }

  void alteraQtd(int qtd) {
    var aux = int.parse(this.quantidade) + qtd;
    if (indexProduto != -1) {
      if (aux > 0 && aux <= this.mapProdutos[indexProduto]['quantidade']) {
        setState(() {
          this.quantidade = aux.toString();
        });
      }
    }
  }

  void adicionaProdutoItens() {
    if ((this.indexProduto != -1) &&
        (int.parse(this.quantidade) <=
            this.mapProdutos[indexProduto]['quantidade'])) {
      setState(() {
        Map dados = {
          'codigo': this.mapProdutos[indexProduto]['codigo'],
          'descricao': this.mapProdutos[indexProduto]['descricao'],
          'unitario': this.mapProdutos[indexProduto]['preco'],
          'total': this.mapProdutos[indexProduto]['preco'] *
              int.parse(this.quantidade),
          'quantidade': int.parse(this.quantidade)
        };

        bool existeProduto = false;
        for (var item in this.mapItensSelecionados) {
          if (item.containsValue(this.mapProdutos[indexProduto]['codigo'])) {
            existeProduto = true;
            item['total'] += this.mapProdutos[indexProduto]['preco'] *
                int.parse(this.quantidade);
            item['quantidade'] += int.parse(this.quantidade);
          }
        }
        if (!existeProduto) this.mapItensSelecionados.add(dados);

        this.totalVenda += this.mapProdutos[indexProduto]['preco'] *
            int.parse(this.quantidade);
        this.totalQtd += int.parse(this.quantidade);
        this.mapProdutos[indexProduto]['quantidade'] -=
            int.parse(this.quantidade);
        this.quantidade = '1';
        this.itemSelecionado = null;
        this.indexProduto = -1;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: this.indexProduto != -1
                ? Text("Estoque Insuficiente")
                : Text("Produto não selecionado!"),
            content: this.indexProduto != -1
                ? Text("Por favor verifique o cadastro de produtos!\n\n" +
                    "Estoque Atual: ${this.mapProdutos[indexProduto]['quantidade']}")
                : Text('Por favor selecione um produto válido!'),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
      setState(() {
        this.quantidade = '1';
      });
    }
  }

  void deletaProdutoItens(int index) {
    setState(() {
      this.totalVenda -= this.mapItensSelecionados[index]['total'];
      this.totalQtd -= this.mapItensSelecionados[index]['quantidade'];

      int indexProduto = this.listaProdutos.indexOf(
          this.mapItensSelecionados[index]['codigo'].toString() +
              ' - ' +
              this.mapItensSelecionados[index]['descricao']);
      this.mapProdutos[indexProduto]['quantidade'] +=
          this.mapItensSelecionados[index]['quantidade'];
      this.mapItensSelecionados.removeAt(index);
    });
  }

  void pagarVenda(bool adicionar) {
    // previnir arredondamentos
    int decimals = 2;
    int fac = pow(10, decimals);
    double valor = double.parse(this.pagar);
    valor = (valor * fac).round() / fac;

    if (adicionar) {
      // Adicionar
      setState(() {
        this.totalPago += valor;
        this.pagar = '';
      });
    } else {
      // Retirar
      setState(() {
        this.totalPago -= valor;
        this.pagar = '';
      });
    }
  }

  void insereBanco() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = documentsDirectory.path + "/estoque.db";
      // Abertura da conexão
      var database = await openDatabase(path, version: 2);

      if (this.update) {
        // Update
        var codigoPessoa =
            pessoaSelecionada.substring(0, pessoaSelecionada.indexOf(' - '));
        await database.rawInsert(
            "UPDATE vendaCompra SET tipo=?,pessoa=?,total=?,pago=?,quantidade=?,data=? WHERE codigo=?",
            [
              tipoPagamento,
              codigoPessoa,
              totalVenda,
              totalPago,
              totalQtd,
              dataEntrega,
              codigoVenda
            ]);
        await database.rawDelete(
            "DELETE FROM movimento Where auxiliar = ?", [codigoVenda]);
        for (var item in mapItensSelecionados) {
          await database.rawInsert(
              "INSERT INTO movimento(codigo,auxiliar,es,produto,valor,quantidade) VALUES(?,?,?,?,?,?)",
              [
                codigoMovimento,
                codigoVenda,
                'VE',
                item["codigo"],
                item["total"],
                item["quantidade"] * -1
              ]);
          this.codigoMovimento++;
        }
        database.close();
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new VendasListagem()));
      } else {
        // Insert cabeçalho da Venda
        var codigoPessoa =
            pessoaSelecionada.substring(0, pessoaSelecionada.indexOf(' - '));

        await database.rawInsert(
            "INSERT INTO vendacompra(codigo,tipo,pessoa,total,pago,quantidade,data) VALUES(?,?,?,?,?,?,?)",
            [
              codigoVenda,
              tipoPagamento,
              codigoPessoa,
              totalVenda,
              totalPago,
              totalQtd,
              dataEntrega
            ]);

        for (var item in mapItensSelecionados) {
          await database.rawInsert(
              "INSERT INTO movimento(codigo,auxiliar,es,produto,valor,quantidade) VALUES(?,?,?,?,?,?)",
              [
                codigoMovimento,
                codigoVenda,
                'VE',
                item["codigo"],
                item["total"],
                item["quantidade"] * -1
              ]);
          this.codigoMovimento++;
        }
        // Insert movimentação
        //Inserir movimentação dos produtos
        database.close();
        Navigator.pop(context);
      }
    } catch (ex) {
      print(ex);
    }
  }

  void deletaVenda() async {
    //Pegar path (caminho do arquivo do banco de dados local)
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/estoque.db";
    // Abertura da conexãocodigo
    var database = await openDatabase(path, version: 2);

    if (this.update) {
      await database.rawDelete(
          'DELETE FROM vendaCompra WHERE codigo = ?', [this.codigoVenda]);
      await database.rawDelete(
          'DELETE FROM movimento WHERE auxiliar = ?', [this.codigoVenda]);
    }
    await database.close();
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new VendasListagem()));
  }

  // Tela //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: Text(
          update
              ? "Editar venda: $codigoVenda"
              : data.isAfter(DateTime.now())
                  ? "Pedido: $codigoVenda"
                  : "Venda: $codigoVenda",
        ),
      ),
      drawer: DrawerOnly(),
      body: Center(
          child: ListView(
        children: [
          Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Cliente",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () async {
                              await Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new PessoasCadastro(0, false)));
                              consultaBanco();
                            })
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(0.0),
                      alignment: Alignment.center,
                      width: 1.7976931348623157e+308,
                      height: 10.0,
                    ),
                    DropdownSearch<String>(
                      mode: Mode.DIALOG,
                      isFilteredOnline: true,
                      showClearButton: true,
                      showSearchBox: true,
                      showSelectedItem: true,
                      selectedItem: pessoaSelecionada,
                      items: this.listaPessoas,
                      label: "Cliente",
                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: (value) {
                        setState(() {
                          pessoaSelecionada = value;
                        });
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.all(0.0),
                      alignment: Alignment.center,
                      height: 5.0,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Data Entrega",
                            ),
                            Container(
                              width: 120,
                              height: 22,
                              padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller:
                                    TextEditingController(text: dataEntrega),
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
                                    dataEntrega =
                                        DateFormat("dd/MM/yyyy").format(data);
                                  });
                                },
                                readOnly: true,
                                onChanged: (value) {
                                  dataEntrega = value;
                                },
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              )),
          Card(
            elevation: 5,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Itens",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () async {
                              await Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new ProdutosListagem()));
                              consultaBanco();
                            })
                      ],
                    ),
                    DropdownSearch<String>(
                      //searchBoxController: TextEditingController(text: "Teste"),
                      // dropdownSearchDecoration: InputDecoration(
                      //     border: UnderlineInputBorder(
                      //   borderSide: BorderSide(color: Color(0xFF01689A)),
                      // )),
                      mode: Mode.DIALOG,
                      isFilteredOnline: true,
                      showClearButton: true,
                      showSearchBox: true,
                      showSelectedItem: true,
                      items: this.listaProdutos,
                      label: "Produto",
                      selectedItem: itemSelecionado,
                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: (value) {
                        setState(() {
                          this.itemSelecionado = value;
                          this.indexProduto = this.listaProdutos.indexOf(value);
                        });
                      },
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
                      children: [
                        Expanded(
                          child: Row(
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
                                    controller:
                                        TextEditingController(text: quantidade),
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
                        ),
                        RaisedButton(
                            key: null,
                            onPressed: () {
                              adicionaProdutoItens();
                            },
                            color: Colors.orange,
                            child: Container(
                                alignment: Alignment.center,
                                width: 120,
                                child: Text(
                                  "Adicionar",
                                  style: TextStyle(color: Colors.white),
                                )))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Total:"),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              indexProduto != -1
                                  ? 'R\$ ${realFormato.format(this.mapProdutos[indexProduto]['preco'] * int.parse(this.quantidade))}'
                                  : 'R\$ 0.00',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ))
                      ],
                    ),
                    Divider(
                      height: 20,
                      thickness: 2,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Produto',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            //width: 60.0,
                            //height: 30.0,
                          ),
                          Container(
                            child: Text(
                              'Unitário',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            alignment: Alignment.center,
                            width: 80.0,
                            //height: 30.0,
                          ),
                          Container(
                            child: Text(
                              'Qtd.',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            alignment: Alignment.center,
                            width: 40.0,
                            //height: 30.0,
                          ),
                          Container(
                            child: Text(
                              'Total',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            alignment: Alignment.center,
                            width: 90.0,
                            //height: 30.0,
                          ),
                        ]),
                    Divider(
                      height: 20,
                      thickness: 2,
                    ),
                    Container(
                      constraints: BoxConstraints(minHeight: 90),
                      child: ListView.builder(
                          itemCount: this.mapItensSelecionados.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Dismissible(
                                background: Container(
                                  color: Colors.red,
                                ),
                                key: Key(this
                                    .mapItensSelecionados[index]['codigo']
                                    .toString()),
                                onDismissed: (direction) {
                                  deletaProdutoItens(index);
                                },
                                child: Container(
                                    height: 45,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                                '${this.mapItensSelecionados[index]['descricao']}'),
                                            //width: 60.0,
                                            //height: 30.0,
                                          ),
                                          Container(
                                            child: Text(
                                                'R\$ ${realFormato.format(this.mapItensSelecionados[index]['unitario'])}'),
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            alignment: Alignment.center,
                                            width: 80.0,
                                            //height: 30.0,
                                          ),
                                          Container(
                                            child: Text(
                                                '${this.mapItensSelecionados[index]['quantidade']}'),
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            alignment: Alignment.center,
                                            width: 40.0,
                                            //height: 30.0,
                                          ),
                                          Container(
                                            child: Text(
                                                'R\$ ${realFormato.format(this.mapItensSelecionados[index]['total'])}'),
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            alignment: Alignment.center,
                                            width: 90.0,
                                            //height: 30.0,
                                          ),
                                        ])));
                          }),
                    ),
                    Divider(
                      height: 20,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text('Totais'),
                          //width: 60.0,
                          //height: 30.0,
                        ),
                        Container(
                          child: Text(
                            '${this.totalQtd}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          alignment: Alignment.center,
                          width: 40.0,
                          //height: 30.0,
                        ),
                        Container(
                          child: Text(
                            'R\$ ${realFormato.format(this.totalVenda)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          alignment: Alignment.center,
                          width: 90.0,
                          //height: 30.0,
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      child: Text(
                        "Pagamento",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    DropdownSearch<String>(
                      //searchBoxController: TextEditingController(text: "Teste"),
                      // dropdownSearchDecoration: InputDecoration(
                      //     border: UnderlineInputBorder(
                      //   borderSide: BorderSide(color: Color(0xFF01689A)),
                      // )),
                      mode: Mode.DIALOG,
                      isFilteredOnline: true,
                      showSelectedItem: true,
                      items: this.listaTiposPagamento,
                      label: "Forma de pagamento",
                      selectedItem: tipoPagamento,
                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: (value) {
                        setState(() {
                          this.tipoPagamento = value;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: TextEditingController(text: pagar),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            onChanged: (value) {
                              pagar = value;
                            },
                            decoration: InputDecoration(
                              labelText: "Pagar",
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RaisedButton(
                              key: null,
                              color: Colors.green,
                              textColor: Colors.white,
                              onPressed: () {
                                pagarVenda(true);
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  width: 60,
                                  child: Text(
                                    "Adicionar",
                                  ))),
                        ),
                        RaisedButton(
                            key: null,
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () {
                              pagarVenda(false);
                            },
                            child: Container(
                                alignment: Alignment.center,
                                width: 50,
                                child: Text(
                                  (this.totalVenda - this.totalPago) >= 0
                                      ? "Retirar"
                                      : "Troco",
                                ))),
                      ],
                    ),
                    RaisedButton(
                        disabledTextColor: Colors.white,
                        disabledColor: (this.totalVenda - this.totalPago) == 0
                            ? Colors.green
                            : Colors.red,
                        textColor: Colors.white,
                        onPressed: null,
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              (this.totalVenda - this.totalPago) == 0
                                  ? "Venda paga:   R\$ ${realFormato.format(this.totalVenda)}"
                                  : (this.totalVenda - this.totalPago) > 0
                                      ? "Falta pagar:   R\$ ${realFormato.format(this.totalVenda - this.totalPago)}"
                                      : "Devolver troco:   R\$ ${realFormato.format(this.totalVenda - this.totalPago)}",
                              style: TextStyle(fontSize: 18),
                            ))),
                  ],
                ),
              )),
          Container(
            height: 40,
          ),
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
                      deletaVenda();
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
                    onPressed: () async {
                      //fazer funcao para inserir no banco
                      await proximoCodigo();
                      insereBanco();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: 120,
                        child: Text(
                          "Salvar",
                        )))
              ]),
          Container(
            height: 40,
          )
        ],
      )),
    );
  }
}
