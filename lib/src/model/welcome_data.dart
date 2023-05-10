import 'package:green_style/src/model/general_info.dart';

class WelcomeData {
  List<GeneralInfo> info;
  String token;

  WelcomeData({
    required this.info,
    required this.token
  });

  factory WelcomeData.fromJson(Map<String, dynamic> json) {
    return WelcomeData(
      info: json['info'] ?? [GeneralInfo(id: '', description: '')],
      token: json['token'] ?? ''
    );
  }
}
