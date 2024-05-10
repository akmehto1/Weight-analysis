import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_db/local_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchUserProfile extends StatefulWidget {
  const SwitchUserProfile({Key? key}) : super(key: key);

  @override
  State<SwitchUserProfile> createState() => _SwitchUserProfileState();
}

class _SwitchUserProfileState extends State<SwitchUserProfile> {
  List<String> distinctUserName = [];

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  void fetchUserName() async {
    distinctUserName = await UserWeightDatabaseManager.getDistinctUserNames();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Switch between user profile"),
        actions: [
          IconButton(onPressed: (){
            GoRouter.of(context).go('/');
          }, icon:Icon(Icons.logout))
        ],
      ),

      body: Container(
        child: ListView.builder(
          itemCount: distinctUserName.length,
          itemBuilder: (BuildContext context, int index) {
            return ListItem(distinctUserName[index]);
          },
        ),
      ),
    );
  }

  Widget ListItem(String userName) {
    return GestureDetector(
      onTap: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('sharedPreferenceUserName', userName);
        GoRouter.of(context).go('/home');
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        color: Colors.redAccent,
        child: ListTile(
          trailing: const CircleAvatar(),
          leading: Text(
            userName,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
