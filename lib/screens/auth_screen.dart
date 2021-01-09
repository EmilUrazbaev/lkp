import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../models/http_exception.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _tokenFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  Map<String, String> _authData = {
    'contractId': '',
    'token': '',
  };

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Произошла ошибка!'),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text('Ok!'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _submit() async {
    _form.currentState.save();
    setState(() {});
    print(_authData['contractId']);
    print(_authData['token']);
    try {
      await Provider.of<Auth>(context, listen: false)
          .signin(_authData['contractId'], _authData['token']);
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Не удалось авторизоваться!');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Авторизация'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: '№ договора'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _authData['contractId'] = value;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_tokenFocusNode);
                },
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: 'Токен'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _authData['token'] = value;
                },
                focusNode: _tokenFocusNode,
              ),
              RaisedButton(
                child: Text("Войти"),
                onPressed: _submit,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class AuthScreen extends StatefulWidget {
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final _tokenfocusNode = FocusNode();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Авторизация'),
//       ),
//       body: Container(
//         child: Form(
//           child: ListView(
//             children: <Widget>[
//               TextFormField(
//                 decoration: InputDecoration(labelText: "Договор"),
//                 textInputAction: TextInputAction.next,
//                 onFieldSubmitted: (_) {
//                   FocusScope.of(context).requestFocus(_tokenfocusNode);
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: "Токен"),
//                 textInputAction: TextInputAction.next,
//                 focusNode: _tokenfocusNode,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
