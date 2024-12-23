import 'package:banco1/view/email.dart';
import 'package:banco1/view/carrinho.dart';
import 'package:banco1/view/generator_page.dart';
import 'package:banco1/view/produto.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = Produto();
        break;
      case 2:
        page = Carrinho();
        break;
      case 3:
        page = Email();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  const NavigationRailDestination(
                    icon: Icon(Icons.person),
                    label: Text('Perfil'),
                  ),
                  const NavigationRailDestination(
                    icon: Icon(Icons.shopping_basket),
                    label: Text('Produto'),
                  ),
                  const NavigationRailDestination(
                    icon: Icon(Icons.add_shopping_cart),
                    label: Text('Carrinho'),
                  ),
                  const NavigationRailDestination(
                    icon: Icon(Icons.email),
                    label: Text('Email'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  print('selected: $value');
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class Enviar {}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // ↓ Add
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary, // ← Add
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  // ↓ Adicione o código abaixo
  var favorites = <WordPair>[];

  void marcarFavorito() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void removerFavorito(var pair) {
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    }
    notifyListeners();
  }
}

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Perfil'),
    );
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have'
              '${appState.favorites.length} favorites: '),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.delete_outline),
            title: Text(pair.asCamelCase),
            onTap: () {
              appState.removerFavorito(pair);
            },
          ),
      ],
    );
  }
}
