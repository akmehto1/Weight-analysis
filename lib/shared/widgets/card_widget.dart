import 'package:flutter/material.dart';

Widget cardWidget(String date,String weight,String time) {


  TextStyle styleHeading=const TextStyle(
    color:Colors.white,
    fontSize:40,
  );

  TextStyle styleSubHeading=const TextStyle(
    color:Colors.white70,
    fontSize:30,
  );


  TextStyle styleContent=const TextStyle(
    color:Colors.white70,
    fontSize:25,
  );

  return AspectRatio(aspectRatio:1/1,child:Container(

    margin:EdgeInsets.all(10.0),
    padding:EdgeInsets.all(10.0),
    decoration:BoxDecoration(
        color:Colors.red,
      borderRadius:BorderRadius.circular(15.0)
    ),
    child: Column(
      crossAxisAlignment:CrossAxisAlignment.center,
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        Text("Last Weight",style:styleHeading,),
        Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children: [Text("Weight:",style:styleSubHeading), Text("$weight KG",style:styleContent,)],
        ),
        Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,

          children: [Text("Date:",style:styleSubHeading,),Text("$date",style:styleContent,)],
        ),
        Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,

          children: [Text("Time:",style:styleSubHeading,),Text("$time",style:styleContent,)],
        ),
      ],
    ),
  ),);
}
