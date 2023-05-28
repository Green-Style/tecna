import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:green_style/src/constants.dart';
import 'package:green_style/src/controller/home_controller.dart';
import 'package:green_style/src/model/home_data.dart';

import '../model/user_info_chart_data.dart';

class InfoChart extends StatefulWidget {
  const InfoChart({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;
  String selectedSuggestion = '';
  final homeCtrl = HomeController();

  Future<String?> getUserToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: userTokenKey);
  }

  Future<HomeData> _getUserInfoChartData() async {
    final data = await homeCtrl.getUserInfoChartData(await getUserToken());
    // selectedSuggestion = data.suggestion;
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
                  decoration: const BoxDecoration(
                    color: darkBackgroundColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                    child: Text(
                                      "${snapshot.data!.co2.toStringAsFixed(2).replaceAll('.', ',')}\nKg",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          shadows: [
                                            Shadow(
                                                color: Colors.black,
                                                blurRadius: 7)
                                          ],
                                          color: Colors.white,
                                          fontSize: 30),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 250,
                                width: double.infinity,
                                child: Center(
                                  child: AspectRatio(
                                    aspectRatio: 1.3,
                                    child: Column(
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Expanded(
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: PieChart(
                                              PieChartData(
                                                pieTouchData: PieTouchData(
                                                  touchCallback:
                                                      (FlTouchEvent event,
                                                          pieTouchResponse) {
                                                    setState(() {
                                                      if (!event
                                                              .isInterestedForInteractions ||
                                                          pieTouchResponse ==
                                                              null ||
                                                          pieTouchResponse
                                                                  .touchedSection ==
                                                              null) {
                                                        return;
                                                      }

                                                      touchedIndex =
                                                          pieTouchResponse
                                                              .touchedSection!
                                                              .touchedSectionIndex;

                                                      _setSelectedSuggestion(
                                                          snapshot.data!
                                                              .userChartData,
                                                          touchedIndex);
                                                    });
                                                  },
                                                ),
                                                borderData: FlBorderData(
                                                  show: true,
                                                ),
                                                sectionsSpace: 0,
                                                centerSpaceRadius: 70,
                                                sections: showingSections(
                                                    snapshot
                                                        .data!.userChartData),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 35,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 25.0, bottom: 5),
                            child: Center(
                              child: Text(
                                selectedSuggestion == ''
                                    ? snapshot.data!.suggestion
                                    : selectedSuggestion,
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DecoratedBox(
                        // Legendas
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0)),
                            border: Border.all(style: BorderStyle.none)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: snapshot.data!.userChartData
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    int idx = entry.key;
                                    UserInfoChartData data = entry.value;

                                    final isTouched = idx == touchedIndex;

                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: isTouched ? 30.0 : 20,
                                              height: 20,
                                              margin:
                                                  const EdgeInsetsDirectional
                                                      .only(end: 6),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: homeCtrl
                                                      .selectColorByPercentage(
                                                          data.percentage)),
                                            ),
                                            const SizedBox(width: 2),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  touchedIndex =
                                                      touchedIndex == idx
                                                          ? -1
                                                          : idx;

                                                  _setSelectedSuggestion(
                                                      snapshot
                                                          .data!.userChartData,
                                                      touchedIndex);
                                                });
                                              },
                                              child: Text(
                                                "${data.categoryName} - ${data.value.toString().replaceAll('.', ',')} Kg",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: isTouched
                                                        ? FontWeight.bold
                                                        : FontWeight.w400,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList()),
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

  _setSelectedSuggestion(userChartData, touchedIndex) {
    if (touchedIndex >= 0) {
      selectedSuggestion = userChartData[touchedIndex].suggestion;
    } else {
      selectedSuggestion = '';
    }
  }

  List<PieChartSectionData> showingSections(
      List<UserInfoChartData> userChartData) {
    return userChartData.asMap().entries.map((entry) {
      int idx = entry.key;
      UserInfoChartData data = entry.value;

      final isTouched = idx == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 7)];
      return PieChartSectionData(
          color: homeCtrl.selectColorByPercentage(data.percentage),
          value: data.percentage,
          title: '${data.percentage}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.mainTextColor1,
            shadows: shadows,
          ));
    }).toList();
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}
