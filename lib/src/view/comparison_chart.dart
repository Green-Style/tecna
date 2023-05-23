import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/controller/home_controller.dart';

class ComparisonChart extends StatelessWidget {
  ComparisonChart({super.key});
  final homeCtrl = HomeController();

  Future<String?> getUserToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: userTokenKey);
  }

  Future<BarChartData> _getComparisonChartData() async {
    final data = await homeCtrl.getComparisonChartData(await getUserToken());

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getComparisonChartData(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return SingleChildScrollView(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: darkBackgroundColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text( // TODO: Alterar para sugestão buscada da API
                          'algo',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DecoratedBox( // Legendas
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                          border: Border.all(
                            style: BorderStyle.none
                          )
                        ),
                        child: SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: Center(
                            child: BarChart(
                              snapshot.data!
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
        }
      },
    );
  }
}