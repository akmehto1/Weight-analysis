import 'package:assignment/shared/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:local_db/local_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String userLastWeightData = '';
  late String userLastWeightDateData = '';
  late String userLastWeightTimeData = '';





  @override
  void initState() {
    super.initState();
    fetchLastUserWeight();
  }

  void fetchLastUserWeight() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userName = prefs.getString('sharedPreferenceUserName');

    final Map<String, dynamic>? lastData = await UserWeightDatabaseManager.getLastUserWeightByUsername(userName!);
    if (lastData != null) {
      setState(() {


        DateTime parsedDateTime = DateTime.parse(lastData['createdAt']);

        String formattedDate =
            DateFormat("dd MMMM yyyy").format(parsedDateTime);


        String time =
            "${parsedDateTime.hour}:${parsedDateTime.minute}:${parsedDateTime.second}";

        userLastWeightTimeData = time;
        userLastWeightData = lastData['weight'].toString();
        userLastWeightDateData = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Weight Analysis",
              style: TextStyle(color: colorScheme.onPrimary),
            )
          ],
        ),
        actions: [
          IconButton(onPressed:()async{
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('sharedPreferenceUserName');
            GoRouter.of(context).go('/');
          }, icon:const Icon(Icons.logout)
          )
        ],
        backgroundColor: colorScheme.primary,
      ),
      body: isLandscape ? _buildLandscapeContent() : _buildPortraitContent(),
    );
  }

  Widget _buildPortraitContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          cardWidget(userLastWeightDateData, userLastWeightData,userLastWeightTimeData),
        ],
      ),
    );
  }

  Widget _buildLandscapeContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                cardWidget(userLastWeightData, userLastWeightDateData,userLastWeightTimeData),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
          ),
        ),
      ],
    );
  }
}
