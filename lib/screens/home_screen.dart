import 'package:flutter/material.dart';

import './add_information.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // 全ての情報
    List<Map<String, dynamic>> members = [];

    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SizedBox(
        height: deviceHeight,
        child: Stack(
          children: [
            ListView.builder(
              itemCount: members.length,
              itemBuilder: ((context, index) => Card(
                    color: Theme.of(context).colorScheme.secondary,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    Navigator.of(context).pushNamed(AddInformation.routeName);
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
