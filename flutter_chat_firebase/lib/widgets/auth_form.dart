import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_firebase/models/auth_data.dart';
import 'package:flutter_chat_firebase/widgets/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthData _authData = AuthData();

  _submit() {
    bool isValid = _formKey.currentState.validate();

    if (_authData.image == null && _authData.isSignup) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Precisamos da sua foto para o cadastro.'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      widget.onSubmit(_authData);
    }
  }

  void _handlePickedImage(File image) {
    _authData.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_authData.isSignup)
                    UserImagePicker(onImagePick: _handlePickedImage),
                  if (_authData.isSignup)
                    TextFormField(
                      key: ValueKey('name'),
                      initialValue: _authData.name,
                      decoration: InputDecoration(labelText: 'Nome'),
                      onChanged: (value) => _authData.name = value,
                      validator: (value) {
                        if (value == null || value.trim().length < 4) {
                          return "Nome inválido";
                        }

                        return null;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    initialValue: _authData.email,
                    decoration: InputDecoration(labelText: 'E-mail'),
                    onChanged: (value) => _authData.email = value,
                    validator: (value) {
                      if (value == null || !value.trim().contains('@')) {
                        return "E-mail inválido";
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    initialValue: _authData.password,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Senha'),
                    onChanged: (value) => _authData.password = value,
                    validator: (value) {
                      if (value == null || value.trim().length < 7) {
                        return "Senha inválido";
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: _submit,
                      child: Text(_authData.isLogin ? 'Entrar' : 'Cadastrar')),
                  TextButton(
                    child: Text(_authData.isLogin
                        ? 'Criar nova conta?'
                        : 'Já possui uma conta?'),
                    onPressed: () {
                      setState(() {
                        _authData.toggleMode();
                      });
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
