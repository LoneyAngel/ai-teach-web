import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';//字体


//页面
import 'package:untitled1/pages/tabview/Settingpage.dart';
import 'package:untitled1/pages/tabview/Resourcepage.dart';
import 'package:untitled1/pages/zhuye/Startpage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Map<String, WidgetBuilder> routes = {
    '/tabview/Settingpage': (context) => Settingpage(),
    '/tabview/Resourcepage': (context) => Resourcepage(),
    '/Startpage': (context) => Startpage(),
    // '/Startpage/Questionpage': (context) => Questionpage(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //设置全局的样式
      theme: ThemeData(
        useMaterial3: true,

        // //统一的设置padding的样式
        // inputDecorationTheme: InputDecorationTheme(
        //   contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        // ),
        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent.shade100,
          brightness: Brightness.light    //该变主题的样式，Brightness.dark,
        ),

        // Define the default `TextTheme`
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.oswald(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
        ),
      ),
      home: Startpage(),
      routes: routes,
    );
  }
}











//我需要的组件的类型




//抽屉
class Choupage extends StatefulWidget {
  const Choupage({super.key, required this.title});
  final String title;

  @override
  State<Choupage> createState() => _ChoupageState();
}

class _ChoupageState extends State<Choupage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[

    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [

            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Business'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('School'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}