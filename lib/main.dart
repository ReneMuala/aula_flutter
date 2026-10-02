import 'package:flutter/material.dart';

// Conceitos a saber
/* 
- Scaffold
- hot restart
- hot reload
- adição de bilbioteca
*/

void main() {
  runApp(App());
}

class Item {
  String nome;
  int quantidade;

  Item({required this.nome, required this.quantidade});
}

enum TipoDeMovimento { adicao, remocao }

class Movimento {
  TipoDeMovimento tipo;
  int quantidade;
  String item;

  Movimento({required this.tipo, required this.quantidade, required this.item});
}

class App extends StatelessWidget {
  List<Item> itens = [
    Item(nome: "Lapis", quantidade: 10),
    Item(nome: "Papel", quantidade: 97),
    Item(nome: "Caneta", quantidade: 5),
  ];

  List<Movimento> movimentos = [
    Movimento(tipo: TipoDeMovimento.adicao, quantidade: 10, item: "Caneta"),
    Movimento(tipo: TipoDeMovimento.remocao, quantidade: 50, item: "Papel"),
    Movimento(tipo: TipoDeMovimento.remocao, quantidade: 50, item: "Caderno"),
  ];

  void adicionarItem(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            children: [
              Text("Adicionar item"),
              TextField(decoration: InputDecoration(label: Text("Nome"))),
              TextField(decoration: InputDecoration(label: Text("Quantidade"))),
            ],
          ),
        );
      },
    );
  }

  void adicionarMovimento(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            children: [
              Text("Adicionar Movimento"),
              TextField(
                onChanged: (texto) {
                  print(texto);
                },
                decoration: InputDecoration(label: Text("Tipo")),
              ),
              TextField(decoration: InputDecoration(label: Text("Quantidade"))),
              TextField(decoration: InputDecoration(label: Text("Item"))),
            ],
          ),
        );
      },
    );
  }

  void lidarComClique(BuildContext context) {
    int aba = DefaultTabController.of(context).index;
    if (aba == 0) {
      print("adicionar item");
      adicionarItem(context);
    } else {
      print("adicionar movimento");
      adicionarMovimento(context);
    }
    print("aba: ${aba}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Gestão de stock"),
                bottom: TabBar(tabs: [Text("Itens"), Text("Movimentos")]),
              ),
              body: TabBarView(
                children: [
                  ListaDeItens(itens: itens),
                  ListaDeMovimentos(movimentos: movimentos),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  lidarComClique(context);
                },
                child: Icon(Icons.add),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ListaDeItens extends StatelessWidget {
  List<Item> itens;

  ListaDeItens({required this.itens});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var item in itens)
          ListTile(
            leading: Icon(Icons.numbers_outlined),
            title: Text(item.nome),
            subtitle: Text("${item.quantidade} itens"),
            trailing: Icon(Icons.delete),
          ),
      ],
    );
  }
}

class ListaDeMovimentos extends StatelessWidget {
  List<Movimento> movimentos;

  ListaDeMovimentos({required this.movimentos});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var movimento in movimentos)
          ListTile(
            leading: Icon(
              movimento.tipo == TipoDeMovimento.adicao
                  ? Icons.add
                  : Icons.close,
            ),
            title: Text(
              "${movimento.tipo == TipoDeMovimento.adicao ? "Adição" : "Remoção"} de Papel",
            ),
            subtitle: Text("${movimento.quantidade} itens"),
          ),
      ],
    );
  }
}
