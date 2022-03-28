import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kjcapp/src/AccPage.dart';
import 'package:kjcapp/src/circ.dart';
import 'package:kjcapp/src/HomePage.dart';
import 'package:kjcapp/src/Attendance.dart';
import 'package:kjcapp/src/tt.dart';
import 'package:kjcapp/src/LoginPage.dart';
import 'package:flutter/services.dart';

const barCol = Color(0xff120e43);
const hovCol = Color(0xfff9ca24);
const headName = "Name";
const urlImage = NetworkImage(
    "https://static.wikia.nocookie.net/bleach/images/f/f2/686Byakuya_profile.png/revision/latest/scale-to-width-down/346?cb=20200322080959&path-prefix=en");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'KJC App';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  final List<Widget> _children = [
    const HomePage(),
    const MyAttendance(),
    const MyTT(),
    const LoginScreen(),
    //const MyAcc()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('KJC APP', style: TextStyle(fontFamily: 'Aovel')),
          centerTitle: true,
          backgroundColor: barCol,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.account_circle),
              iconSize: 27,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          actions: const [
            CircleAvatar(
                radius: 15,
                backgroundImage: ExactAssetImage('assets/images/logo.png')),
            // IconButton(
            //   icon: Image.asset('assets/images/logo.png'),
            //   onPressed: () {
            //     //no action
            //   },
            // )
          ],
        ),
        body: _children[_selectedIndex],
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: hovCol,
                ),
                child: CircleAvatar(
                  backgroundImage: urlImage,
                ),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: barCol,
              primaryColor: Colors.white,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: const TextStyle(color: Colors.grey))),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.badge),
                label: 'Attendance',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event),
                label: 'Time-Table',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label: 'Circulars',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.account_circle),
              //   label: 'Account',
              // ),
            ],
            selectedItemColor: hovCol,
          ),
        ),
      ),
    );
  }
}
