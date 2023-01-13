import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/tabs_screen.dart';
import './screens/add_information.dart';
import './providers/member_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MemberProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
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
          '/': (context) => const TebsScreen(),
          AddInformation.routeName: (context) => const AddInformation(),
        },
      ),
    );
  }
}
