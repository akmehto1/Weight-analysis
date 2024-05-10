import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    backgroundColor:const Color.fromRGBO(161, 8, 8,1),
    content:SizedBox(
      height:23,
      child:Row(
        mainAxisAlignment:MainAxisAlignment.start,
        children: [
          Text(
            message,
            style: const TextStyle(color: Colors.white,fontSize:18,fontWeight:FontWeight.w400),
          ),
        ],

      ),
    ),

  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
