import 'package:flutter/material.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/controller/forgotPassword_controller.dart';

TextEditingController _emailController = TextEditingController();

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreen createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
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

                //button Register
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _fogotPasswordBtnAction(context);
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
                      'Recuperar senha',
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

Future<void> _fogotPasswordBtnAction(BuildContext context) async {
  if (!_validateInputs(context)) {
    return;
  }
  try {
    await _submitForgotPassword(context);
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
                'Foi enviado um email com link para recuperação de senha.'),
            actions: [
              TextButton(
                  onPressed: () {
                    _emailController.clear();
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: const Text('Ir para Login'))
            ],
          )).then((value) {
    _emailController.clear();
    Navigator.of(context).pushNamed('/login');
  });
}

bool _validateInputs(BuildContext context) {
  String email = _emailController.text;

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
  return true;
}

Future<void> _submitForgotPassword(BuildContext context) async {
  final forgotPasswordCtl = ForgotPasswordController();
  String email = _emailController.text;

  await forgotPasswordCtl.exec(email);
}

bool validateEmail(String email) {
  final String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  final RegExp regex = RegExp(emailRegex);

  return regex.hasMatch(email);
}
