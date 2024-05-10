import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:local_db/local_db.dart';
import 'package:models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeightDataProvider with ChangeNotifier {
  Future<List<WeightDataModel>> fetchDataFromDb(userName) async {

    late List<WeightDataModel> chartData = [];
    List<Map<String, dynamic>> userWeightData =
        await UserWeightDatabaseManager.getUserWeightByUsername(userName);

    chartData.clear();
    print(userWeightData);

    for (var data in userWeightData) {
      double weight = data["weight"];
      DateTime createdAt = DateTime.parse(data["createdAt"]);
      int  month = data["month"];
      int? id=data['id'];

      print("Weight: $weight");
      print("month: $month");

      final List<String> months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];

      chartData.add(WeightDataModel(months[month], weight,id:id));
    }

    return chartData;
  }

  Future<List<WeightDataModel>> getChartData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userName = prefs.getString('sharedPreferenceUserName');
    Future<List<WeightDataModel>> userWeightData = fetchDataFromDb(userName);


    return userWeightData;
  }
}
