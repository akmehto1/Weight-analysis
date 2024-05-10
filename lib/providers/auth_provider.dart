import 'package:flutter/cupertino.dart';
import 'package:local_db/local_db.dart';

class AuthServiceProvider with ChangeNotifier{
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isSignUp=true;

  Future<bool> signInWithCredentials() async {
    try {
      String userName = userNameController.text.toString();

      List<Map<String, dynamic>>? userData =
      await UserDatabaseManager.getUserByUsername(userName);

      if (userData.isEmpty) {
        return false;
      }



      return true; // Or you might return userWeightData directly here if needed.
    } catch (e) {
      debugPrint("Error: $e");
      return false; // Or handle error as needed.
    }
  }

 Future<bool>signUpWithCredentials()async{

   String userName = userNameController.text.toString();
   String name=nameController.text.toString();

   List<Map<String, dynamic>> alreadyExisiting=await UserDatabaseManager.getUserByUsername(userName);
   print(alreadyExisiting);


   // int id=await UserDatabaseManager.createUser(userName,name);




   return false;
 }





}