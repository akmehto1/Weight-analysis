import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:assignment/providers/weight_data_provider.dart';
import 'package:models/models.dart';
import 'package:local_db/local_db.dart';

class WeightUpdatePage extends StatefulWidget {
  @override
  State<WeightUpdatePage> createState() => _WeightUpdatePageState();
}

class _WeightUpdatePageState extends State<WeightUpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Update"),
      ),
      body: Center(
        child: FutureBuilder<List<WeightDataModel>>(
          future: Provider.of<WeightDataProvider>(context).getChartData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<WeightDataModel> chartData = snapshot.data!;
              return ListView.builder(
                itemCount: chartData.length,
                itemBuilder: (BuildContext context, int index) {
                  return listItem(
                    id: chartData[index].id,
                    weight: chartData[index].weight,
                    month: chartData[index].month,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget listItem({int? id, required double weight, required String month}) {
    TextStyle styleContent = const TextStyle(
      color: Colors.black,
      fontSize: 25,
    );
    return AspectRatio(
      aspectRatio: 3 / 1,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(month, style: styleContent),
                const Text("---"),
                Text("$weight KG", style: styleContent)
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                TextEditingController updateWeightController =
                TextEditingController();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Write new Weight'),
                    content: TextField(
                      decoration: const InputDecoration(
                        hintText: "Updated Weight",
                      ),
                      controller: updateWeightController,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          int? userId = id;
                          final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          final String? userName =
                          prefs.getString('sharedPreferenceUserName');

                          double? updatedWeight =
                          double.tryParse(updateWeightController.text);

                          await UserWeightDatabaseManager.updateUserWeight(
                              userId!, userName!, updatedWeight);
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
