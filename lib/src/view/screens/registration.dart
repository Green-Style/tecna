import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/controller/register_controller.dart';

TextEditingController _passwordController = TextEditingController();
TextEditingController _confirmPasswordController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _nameController = TextEditingController();

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/icons/green_style_white_small.png',
                  width: 155,
                ),
                //textfield Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(22.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nome',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //textfield Email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(22.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //textfield Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(22.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Senha',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //textfield Confirm Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(22.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirme a Senha',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //button Register
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _registerBtnAction(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(buttonBackgroundColor),
                      foregroundColor: MaterialStateProperty.all(
                          activebuttonBackgroundColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.5),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(100),
                    ),
                    child: Center(
                        child: Text(
                      'Registrar',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _registerBtnAction(BuildContext context) async {
  if (!_validateInputs(context)) {
    return;
  }
  try {
    await _submitRegister(context);
  } catch (_) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Erro'),
              content: Text('Verifique seus dados e tente novamente!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                )
              ],
            ));
    return;
  }

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Parabéns!'),
            content:
                Text('Seu registro foi efetuado, por favor confirme o e-mail.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: Text('Ir para Login'))
            ],
          )).then((value) => Navigator.of(context).pushNamed('/login'));
}

bool _validateInputs(BuildContext context) {
  String password = _passwordController.text;
  String confirmPassword = _confirmPasswordController.text;
  String email = _emailController.text;
  String name = _nameController.text;

  if (password.isEmpty ||
      confirmPassword.isEmpty ||
      email.isEmpty ||
      name.isEmpty) {
    //Mensagem de erro caso vazio
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Erro'),
              content: Text('Por favor, preencha todos os campos.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                )
              ],
            ));
    return false;
  }

  if (!validateEmail(email)) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Erro'),
              content: Text('Por favor, digite um e-mail válido.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                )
              ],
            ));
    return false;
  }

  if (password != confirmPassword) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Erro'),
              content: Text('As senhas não correspondem'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                )
              ],
            ));
    return false;
  }
  return true;
}

Future<void> _submitRegister(BuildContext context) async {
  final registerCtl = RegisterController();
  String password = _passwordController.text;
  String email = _emailController.text;
  String name = _nameController.text;

  await registerCtl.signUp(email, password, name);
}

bool validateEmail(String email) {
  final String emailRegex =
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';

  final RegExp regex = RegExp(emailRegex);

  return regex.hasMatch(email);
}
