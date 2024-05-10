import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatefulWidget {
  final Widget child;
  const BottomNavBar({super.key,required this.child});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
      switch (index) {
        case 1:
          GoRouter.of(context).go('/add');
          break;
        case 2:
          GoRouter.of(context).go('/graph');
          break;
        case 3:
          GoRouter.of(context).go('/editWeight');
          break;
        default:
          GoRouter.of(context).go('/home');
          break;
        // Handle other cases
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:widget.child,
      bottomNavigationBar:bottomNavigation(),
    );
  }

  Widget bottomNavigation() {
    return SizedBox(
      height: 80,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: _selectedIndex == 0 ? 40 : 25,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined,size: _selectedIndex == 1 ? 40 : 25,),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq,size: _selectedIndex == 2 ? 40 : 25,),
            label: 'Graph',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map,size: _selectedIndex == 3 ? 40 : 25,),
            label: 'View',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:const Color.fromRGBO(20,60, 120,1),
        onTap: _onItemTapped,
        backgroundColor:Colors.red,
      ),
    );
  }

}
