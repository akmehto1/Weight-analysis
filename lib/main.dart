import 'package:assignment/providers/auth_provider.dart';
import 'package:assignment/providers/weight_data_provider.dart';
import 'package:assignment/providers/weight_entry_provider.dart';
import 'package:assignment/screens/auth/login_screen.dart';
import 'package:assignment/screens/home/home.dart';
import 'package:assignment/screens/line_graph_page/line_graph_page.dart';
import 'package:assignment/screens/switch_user_profile/switch_user_profile.dart';
import 'package:assignment/screens/weight_edit_page/weight_edit_page.dart';
import 'package:assignment/screens/weight_entry_page/weight_entry_page.dart';
import 'package:assignment/shared/theme/app_theme.dart';
import 'package:assignment/shared/utils/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

Future<bool> isLogin() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? isLogin = prefs.getString('sharedPreferenceUserName');
  return isLogin != null;
}


final GoRouter _router = GoRouter(
    routes:[
      ShellRoute(
          builder: (context, state, child) {
            return BottomNavBar(child:child,);
          },
          routes: [
            GoRoute(
                name: "Home page ",
                path: '/home',
                builder: (BuildContext context, GoRouterState state) {
                  return const HomePage();
                }),
            GoRoute(
              name:"Line chart Page",
              path: '/graph',
              builder: (BuildContext context, GoRouterState state) {
                return  LineGraphPage();
              },
            ),
            GoRoute(
              name:"Edit data Page",
              path: '/editWeight',
              builder: (BuildContext context, GoRouterState state) {
                return  WeightUpdatePage();
              },
            ),
            GoRoute(
              name:"Weight Entry page",
              path: '/add',
              builder: (BuildContext context, GoRouterState state) {
                return WeightEntryPage();
              },
            ),
          ]),
      GoRoute(
          name: "Logout Page ",
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const Login();
          }),
      GoRoute(
          name: "Switch Page ",
          path: '/switchProfile',
          builder: (BuildContext context, GoRouterState state) {
            return  SwitchUserProfile();
          }),




    ]


);
class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthServiceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeightDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeightEntryProvider(),
        ),
      ],
      child: MaterialApp.router(
        theme: AppTheme.themeData,
        routerConfig: _router,
      ),
    );
  }
}
