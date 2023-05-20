import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/controller/home_controller.dart';
import 'package:green_style/src/model/home_data.dart';

class InfoChart extends StatelessWidget {
  InfoChart({super.key});
  final homeCtrl = HomeController();

  Future<String?> getUserToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: userTokenKey);
  }

  Future<HomeData> _getUserInfoChartData() async {
    final data = await homeCtrl.getUserInfoChartData(await getUserToken());

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserInfoChartData(),
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
                      Column(
                        children: [
                          SizedBox(
                            height: 250,
                            width: double.infinity,
                            child: Center(
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 60,
                                  borderData: FlBorderData(show: false),
                                  sections: snapshot.data!.sections,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text( // TODO: Alterar para sugestão buscada da API
                                'Alguma coisa',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ],
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: snapshot.data!.userChartData.map(
                                  (e) => Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 16,
                                            height: 16,
                                            margin: const EdgeInsetsDirectional.only(end: 6),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: homeCtrl.selectColorByCategory(e.categoryId)
                                            ),
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            "${homeCtrl.selectCategoryTitle(e.categoryId)} - ${e.value} ton",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ).toList()
                              ),
                            )
                          ],
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