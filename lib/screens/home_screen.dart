import 'package:flutter/material.dart';

import '../databases/member_record_database.dart';
import './add_members.dart';
import './show_month_data.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _allDatas = [];

  @override
  void initState() {
    super.initState();
    // 初めに全ての情報を取得する
    _refreshDatas();
  }

  // 全ての情報を取得する関数
  void _refreshDatas() async {
    final data = await MemberRecordDatabase.getItems();
    setState(() {
      _allDatas = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        title: const Text('戦歴'),
      ),
      body: SizedBox(
        height: deviceHeight,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              ListView.builder(
                itemCount: _allDatas.length,
                itemBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        shadowColor: Colors.black,
                        elevation: 5,
                        color: Colors.red.shade100,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ShowMonthData(id: index),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: Text(
                              '${_allDatas[index]['id']}回戦',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            title: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (int i = 0; i < 4; i++) ...{
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        _allDatas[index]['member${i + 1}'] !=
                                                null
                                            ? '${_allDatas[index]['member${i + 1}']} : ${_allDatas[index]['member${i + 1}Total']}点'
                                            : '',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  }
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      Navigator.of(context).pushNamed(AddMembers.routeName);
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
