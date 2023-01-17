import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hanafuda_record/screens/home_screen.dart';

import './screens/add_members.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hanahuda Record',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue,
          error: Colors.red,
          secondary: Colors.pink,
        ),
      ),
      // home: const HomeScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        AddMembers.routeName: (context) => const AddMembers(),
      },
    );
  }
}
