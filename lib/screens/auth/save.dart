// import 'package:assignment/providers/auth_provider.dart';
// import 'package:assignment/shared/widgets/snack_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class Login extends StatefulWidget {
//   const Login({super.key});
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// bool isEmailValid = false;
//
// class _LoginState extends State<Login> {
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//
//     return Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 100,
//           backgroundColor: colorScheme.primary,
//           elevation: 0,
//         ),
//         body: Consumer<AuthServiceProvider>(
//             builder: (context, authProvider, child) {
//               return content(authProvider);
//             }
//         )
//     );
//   }
//
//   Widget content(authProvider) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             height: 120,
//             decoration: const BoxDecoration(
//               color: Colors.red,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.elliptical(60, 60),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 20.0),
//               child: Container(
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/icons/login_icon.png'),
//                     ),
//                     shape: BoxShape.circle,
//                     color: Colors.white),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 40,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 40.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Welcome",
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 authProvider.isSignUp
//                     ? const Text(
//                   "Sign up to continue.",
//                   style: TextStyle(fontSize: 20),
//                 )
//                     : const Text(
//                   "Sign in to continue.",
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 authProvider.isSignUp
//                     ? inputForm("Name", authProvider.nameController)
//                     : const SizedBox.shrink(),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 inputForm("User Name", authProvider.userNameController),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       if(authProvider.isSignUp){
//                         Future<dynamic>signIn=authProvider.signInWithCredentials();
//                         if(signIn==false){
//                           showSnackBar(context,"Your credentials are wrong");
//                         }
//                       }
//                       else {
//
//                         Future<bool>signUp= authProvider.signUpWithCredentials();
//                       }
//
//                       debugPrint("login or Signup");
//                       debugPrint(authProvider.userNameController.text);
//                     },
//                     child: Container(
//                       width: 200,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: Colors.redAccent,
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child:Center(
//                         child:authProvider.isSignUp?const Text(
//                           "Signup",style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                         ):const Text(
//                           "Login",style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     authProvider.isSignUp
//                         ? const Text("Already have account? ")
//                         : const Text("New User? "),
//                     GestureDetector(
//                       onTap:(){
//                         authProvider.switchBetweenLoginSignup();
//
//                       },
//                       child: authProvider.isSignUp
//                           ? const Text("Sign In", style: TextStyle(color: Colors.red))
//                           : const Text(
//                         "Sign Up",
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget inputForm(String title, TextEditingController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title),
//         const SizedBox(
//           height: 10,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: title == "user Name"
//                 ? Border.all(
//                 width: 0.5,
//                 color: controller.text.isEmpty
//                     ? Colors.grey
//                     : isEmailValid
//                     ? Colors.green
//                     : Colors.red)
//                 : Border.all(width: 0.5, color: Colors.grey),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 10.0),
//             child: TextField(
//               controller: controller,
//               decoration: const InputDecoration(border: InputBorder.none),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
