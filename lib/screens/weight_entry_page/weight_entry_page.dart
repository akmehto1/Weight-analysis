import 'package:assignment/providers/weight_entry_provider.dart';
import 'package:flutter/material.dart';
import 'package:local_db/local_db.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WeightEntryPage extends StatefulWidget {
  const WeightEntryPage({Key? key}) : super(key: key);

  @override
  State<WeightEntryPage> createState() => _WeightEntryPageState();
}

class _WeightEntryPageState extends State<WeightEntryPage> {



  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:colorScheme.primary,
        title: const Text('Weight Entry'),
      ),
      body: Consumer<WeightEntryProvider>(
        builder: (context, provider, child) {
          return _buildContent(provider);
        },
      ),
    );
  }

  Widget _buildContent(WeightEntryProvider provider) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            colors: [Colors.grey, Theme.of(context).colorScheme.primary],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/weight_entry_icon/weight_icon.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 30),
              TextField(
                controller: provider.weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Weight (kg)',
                ),
              ),
              const SizedBox(height: 10),
              _buildMonthDropDown(provider),
              const SizedBox(height: 16.0),
              _buildSaveButton(provider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(WeightEntryProvider provider) {
    return ElevatedButton(
      onPressed: () async {
        String weightText = provider.weightController.text;
        provider.weightController.clear();
        String monthName = provider.selectedMonth.toString();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? userName = prefs.getString('sharedPreferenceUserName');

        int check = await UserWeightDatabaseManager.addUserWeight(userName!, double.tryParse(weightText),monthName);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Weight Saved'),
            content: const Text('Your weight has been saved successfully.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
      child: const Text('Save Weight'),
    );
  }

  Widget _buildMonthDropDown(WeightEntryProvider provider) {
    return Container(
      color: Colors.white70,
      child: DropdownButton<String>(
        value: provider.selectedMonth,
        onChanged: (String? newValue) {
          setState(() {
            provider.selectedMonth = newValue!;
          });
        },
        items: provider.months
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        })
            .toList(),
      ),
    );
  }
}
