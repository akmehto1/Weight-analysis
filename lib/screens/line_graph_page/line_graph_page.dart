import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:assignment/providers/weight_data_provider.dart';

class LineGraphPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:colorScheme.primary,
        title: const Text('Weight Changes Over Months',style:TextStyle(color:Colors.white),),
      ),
      body: Center(
        child: FutureBuilder<List<WeightDataModel>>(
          future: Provider.of<WeightDataProvider>(context).getChartData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While the future is loading, display a loading indicator
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // If an error occurred, display an error message
              return Text('Error: ${snapshot.error}');
            } else {
              // Once the future completes, use the data to build your widget
              List<WeightDataModel> chartData = snapshot.data!;
              return Column(
                children: [
                Container(
                height: 300,
                padding: const EdgeInsets.all(16),
                child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  // Chart title
                  title: const ChartTitle(text: 'Weight Changes Over Months'),
                  // Enable legend
                  legend: const Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series:[
                    LineSeries<WeightDataModel, String>(
                      dataSource: chartData,
                      xValueMapper: (WeightDataModel data, _) => data.month,
                      yValueMapper: (WeightDataModel data, _) => data.weight,
                      // Enable data label
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                    )
                  ],
                ),
              )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
