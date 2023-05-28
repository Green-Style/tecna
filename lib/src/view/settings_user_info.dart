import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/controller/settings_controller.dart';
import 'package:green_style/src/model/settings_data.dart';

class SettingsUserInfo extends StatelessWidget {
  SettingsUserInfo({super.key});
  final settingsCtrl = SettingsController();
  String _name = '';
  String _email = '';

  Future<SettingsData> _getUserInfo() async {
    final userInfo = await settingsCtrl.getUserInfoSettings();
    _email = userInfo.userEmail;
    _name = userInfo.userName;
    return userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserInfo(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return DecoratedBox(
                  decoration: const BoxDecoration(
                    color: darkBackgroundColor,
                  ),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: const [
                            SizedBox(
                              height: 160,
                              width: double.infinity,
                              child: Center(
                                child: CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: AssetImage(
                                      'assets/icons/green_style_white_small.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(22.5),
                                      topRight: Radius.circular(22.5),
                                      bottomLeft: Radius.circular(22.5),
                                      bottomRight: Radius.circular(22.5)),
                                  border: Border.all(style: BorderStyle.none)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Form(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: TextFormField(
                                          enabled: false,
                                          initialValue: _name,
                                          decoration: const InputDecoration(
                                              labelText: 'Nome'),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: TextFormField(
                                          enabled: false,
                                          initialValue: _email,
                                          decoration: const InputDecoration(
                                              labelText: 'Email'),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Deseja trocar sua senha?',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed('/changePassword');
                                            },
                                            child: const Text(
                                              ' Clique aqui',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 40),
                                      Align(
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _logoutBtnAction(context);
                                          },
                                          child: const Text('Logout'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ]));
            }
        }
      },
    );
  }

  Future<void> _logoutBtnAction(BuildContext context) async {
    try {
      await settingsCtrl.logoutUser();
    } catch (_) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Erro'),
                content: const Text('Problemas o deslogar'),
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
              title: const Text('Volte Logo!'),
              content: const Text('Você foi deslogado com sucesso'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: const Text('Sair'))
              ],
            )).then((value) {
      Navigator.of(context).pushNamed('/login');
    });
  }
}
/* 

    */