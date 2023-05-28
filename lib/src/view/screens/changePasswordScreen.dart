import 'package:flutter/material.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/controller/settings_controller.dart';
import 'package:green_style/src/model/settings_data.dart';

TextEditingController _passwordCtrl = TextEditingController();
TextEditingController _passwordConfirmCtrl = TextEditingController();
TextEditingController _oldPasswordCtrl = TextEditingController();

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final settingsCtrl = SettingsController();

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
              width: 250,
            ),
            const Text(
              'Troca de Senha',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Por favor preencha os campos a seguir com atenção!',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            //senha atual textfield
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
                    controller: _oldPasswordCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Sua senha atual.',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            //senha nova textfield
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
                    controller: _passwordCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Sua nova senha.',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            //senha nova confirm textfield
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
                    controller: _passwordConfirmCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Confirme sua nova senha.',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            //botao de trocar senha
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ElevatedButton(
                  onPressed: () {
                    _submitChange(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(buttonBackgroundColor),
                    foregroundColor:
                        MaterialStateProperty.all(activebuttonBackgroundColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.5),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(100),
                  ),
                  child: const Center(
                      child: Text(
                    'Trocar Senha',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ))),
            ),
          ],
        )),
      )),
    );
  }

  Future<void> _submitChange(BuildContext context) async {
    String password = _passwordCtrl.text;
    String confirmPassword = _passwordConfirmCtrl.text;
    String currentPassword = _oldPasswordCtrl.text;

    if (_validateInputs(context, password, confirmPassword)) {
      try {
        await settingsCtrl.changePassword(currentPassword, password, context);
      } catch (_) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Erro'),
                  content:
                      const Text('Verifique seus dados e tente novamente!'),
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
                title: const Text('Sucesso!'),
                content: const Text('Sua senha foi alterada.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/home');
                      },
                      child: const Text('OK!'))
                ],
              )).then((value) {
        Navigator.of(context).pushNamed('/home');
      });
    }
  }

  bool _validateInputs(
      BuildContext context, String password, String confirmPassword) {
    if (password.isEmpty || confirmPassword.isEmpty) {
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
}
