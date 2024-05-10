import 'package:flutter/cupertino.dart';

class WeightEntryProvider with ChangeNotifier{
  final TextEditingController weightController = TextEditingController();

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

  String selectedMonth = 'January';

}