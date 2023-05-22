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
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nome',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

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
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Senha',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

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
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirme a Senha',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

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
                    child: const Center(
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
              title: const Text('Erro'),
              content: const Text('Verifique seus dados e tente novamente!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                )
              ],
            ));
    return;
  }

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Parabéns!'),
            content: const Text(
                'Seu registro foi efetuado, por favor confirme o e-mail.'),
            actions: [
              TextButton(
                  onPressed: () {
                    _clearInputs();
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: const Text('Ir para Login'))
            ],
          )).then((value){
          _clearInputs(); 
          Navigator.of(context).pushNamed('/login');
          });
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
              title: const Text('Erro'),
              content: const Text('Por favor, preencha todos os campos.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                )
              ],
            ));
    return false;
  }

  if (!validateEmail(email)) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Erro'),
              content: const Text('Por favor, digite um e-mail válido.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                )
              ],
            ));
    return false;
  }

  if (password != confirmPassword) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Erro'),
              content: const Text('As senhas não correspondem'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
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
  final String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  final RegExp regex = RegExp(emailRegex);

  return regex.hasMatch(email);
}

void _clearInputs(){
  _passwordController.clear();
  _confirmPasswordController.clear();
  _emailController.clear();
  _nameController.clear();
}
