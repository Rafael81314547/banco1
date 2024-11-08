import 'package:banco1/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  var _controller = TextEditingController();
  var _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text("Acesso ao perfil"),
          ),
        ),
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Nome Completo'),
          maxLength: 100,
          //validator: _validarName,
          onSaved: (String? val) {},
        ),
        TextFormField(
            controller: _controller2,
            decoration: InputDecoration(hintText: 'Idade'),
            keyboardType: TextInputType.number,
            maxLength: 3,
            //validator: _validarIdade,
            onSaved: (String? val) {}),
        SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: () {
            // TO DO:
          },
          child: Text('Enviar'),
        ),
        ElevatedButton(
          onPressed: () {
            _controller.clear();
            _controller2.clear();
          },
          child: Text('Limpar'),
        )
      ],
    );
  }
}
