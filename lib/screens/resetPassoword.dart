import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar senha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('Por favor informe seu email e enviaremos um link para a troca de senha.'),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira seu email.';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Por favor insira uma email válido.';
                  }
                  return null;
                },
                onSaved: (value) {
                  if(value != null){
                    _email = value.trim();
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                )
              // ),
              // SizedBox(height: 20),
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     onPressed: () {
              //           if (_formKey.currentState != null && _formKey.currentState.validate()) {
              //           _formKey.currentState.save();
              //           }
              //         // TODO: send password reset link to the user's email address
              //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //           content: Text('Link para recuperação de senha enviado para $_email'),
              //         ));
              //       }
              //     },
              //     child: Text('Enviar link para recuperação de senha'),
              //   ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
