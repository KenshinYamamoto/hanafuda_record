import 'package:flutter/material.dart';

import '../databases/month_winner_database.dart';
import '../databases/month_point_database.dart';
import '../databases/member_record_database.dart';

class ShowMonthData extends StatefulWidget {
  final int id;
  const ShowMonthData({super.key, required this.id});

  @override
  State<ShowMonthData> createState() => _ShowMonthDataState();
}

class _ShowMonthDataState extends State<ShowMonthData> {
  List<Map<String, dynamic>> _monthWinnerDatas = [
    {'init': 0}
  ];
  List<Map<String, dynamic>> _monthPointDatas = [
    {'init': 0}
  ];
  List<Map<String, dynamic>> _memberDatas = [
    {'init': 0}
  ];
  final List<String> _initMonth = [
    'january',
    'february',
    'march',
    'april',
    'may',
    'june',
    'july',
    'august',
    'september',
    'october',
    'november',
    'december',
  ];

  @override
  void initState() {
    super.initState();
    _refreshDatas();
  }

  void _refreshDatas() async {
    final winnerDatas = await MonthWinnerDatabase.getItem(widget.id + 1);
    final pointDatas = await MonthPointDatabase.getItem(widget.id + 1);
    final memberDatas = await MemberRecordDatabase.getItem(widget.id + 1);
    setState(() {
      _monthWinnerDatas = winnerDatas;
      _monthPointDatas = pointDatas;
      _memberDatas = memberDatas;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.id + 1}回戦'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < 12; i++) ...{
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    color: Colors.amber.shade100,
                    elevation: 3,
                    child: ListTile(
                      leading: Text(
                        '${i + 1}月',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        '${_monthWinnerDatas[0][_initMonth[i]]}が${_monthPointDatas[0][_initMonth[i]]}点取得',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              },
              Container(
                color: Colors.green.shade100,
                height: deviceHeight * 0.05,
                width: deviceWidth * 0.5,
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    '合計点',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              for (int i = 0; i < 2; i++) ...{
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.blue.shade100,
                        elevation: 3,
                        child: ListTile(
                          leading: Text(
                            '${_memberDatas[0]['member${i + 1}']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            '${_memberDatas[0]['member${i + 1}Total']}点',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              },
              if (_memberDatas[0]['member3'] != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.blue.shade100,
                        elevation: 3,
                        child: ListTile(
                          leading: Text(
                            '${_memberDatas[0]['member3']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            '${_memberDatas[0]['member3Total']}点',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (_memberDatas[0]['member4'] != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.blue.shade100,
                        elevation: 3,
                        child: ListTile(
                          leading: Text(
                            '${_memberDatas[0]['member4']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            '${_memberDatas[0]['member4Total']}点',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
