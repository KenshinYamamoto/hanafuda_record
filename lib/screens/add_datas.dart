import 'dart:io';

import 'package:flutter/material.dart';

import '../databases/member_record_database.dart';
import '../databases/month_winner_database.dart';
import '../databases/month_point_database.dart';

class AddDatas extends StatefulWidget {
  static const routeName = '/add-datas';
  final List<String> members;
  const AddDatas({super.key, required this.members});

  @override
  State<AddDatas> createState() => _AddDatasState();
}

class _AddDatasState extends State<AddDatas> {
  final _formKey = GlobalKey<FormState>();

  late List<String> newMemberLists = widget.members
    ..removeWhere(
      (element) => element == '',
    );
  late List<String> dropdownValues = List.filled(12, newMemberLists.first);
  late List<int> monthPoints = List.filled(12, 0);
  late List<int> totalPoints = List.filled(newMemberLists.length, 0);

  void submitDatabase(BuildContext context) async {
    final bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();

      for (int i = 0; i < newMemberLists.length; i++) {
        for (int j = 0; j < monthPoints.length; j++) {
          if (newMemberLists[i] == dropdownValues[j]) {
            setState(() {
              totalPoints[i] += monthPoints[j];
            });
          }
        }
      }

      await _addMemberRecord();
      await _addWinnerData();
      await _addPointData();

      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/',
        (route) => false,
      );
    }
  }

  // itemを追加する
  Future<void> _addMemberRecord() async {
    if (newMemberLists.length == 2) {
      await MemberRecordDatabase.createRecordItem(
        member1: newMemberLists[0],
        member2: newMemberLists[1],
        member3: null,
        member4: null,
        member1Total: totalPoints[0],
        member2Total: totalPoints[1],
        member3Total: null,
        member4Total: null,
      );
    } else if (newMemberLists.length == 3) {
      await MemberRecordDatabase.createRecordItem(
        member1: newMemberLists[0],
        member2: newMemberLists[1],
        member3: newMemberLists[2],
        member4: null,
        member1Total: totalPoints[0],
        member2Total: totalPoints[1],
        member3Total: totalPoints[2],
        member4Total: null,
      );
    } else {
      await MemberRecordDatabase.createRecordItem(
        member1: newMemberLists[0],
        member2: newMemberLists[1],
        member3: newMemberLists[2],
        member4: newMemberLists[3],
        member1Total: totalPoints[0],
        member2Total: totalPoints[1],
        member3Total: totalPoints[2],
        member4Total: totalPoints[3],
      );
    }
  }

  Future<void> _addWinnerData() async {
    await MonthWinnerDatabase.createMonthWinnerItem(
      january: dropdownValues[0],
      february: dropdownValues[1],
      march: dropdownValues[2],
      april: dropdownValues[3],
      may: dropdownValues[4],
      june: dropdownValues[5],
      july: dropdownValues[6],
      august: dropdownValues[7],
      september: dropdownValues[8],
      october: dropdownValues[9],
      november: dropdownValues[10],
      december: dropdownValues[11],
    );
  }

  Future<void> _addPointData() async {
    await MonthPointDatabase.createMonthWinnerItem(
      january: monthPoints[0],
      february: monthPoints[1],
      march: monthPoints[2],
      april: monthPoints[3],
      may: monthPoints[4],
      june: monthPoints[5],
      july: monthPoints[6],
      august: monthPoints[7],
      september: monthPoints[8],
      october: monthPoints[9],
      november: monthPoints[10],
      december: monthPoints[11],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('点数入力'),
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/',
              (route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < monthPoints.length; i++) ...{
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${i + 1}月: '),
                      DropdownButton(
                        value: dropdownValues[i],
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        items: newMemberLists.map((String member) {
                          return DropdownMenuItem(
                            value: member,
                            child: Text(member),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropdownValues[i] = value!;
                          });
                        },
                      ),
                      const Text('が '),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          validator: (value) {
                            try {
                              if (value!.trim().isEmpty) {
                                return '数値を入力';
                              } else if (int.parse(value) < 0) {
                                return '0以上の値を入力';
                              }
                              return null;
                            } catch (e) {
                              return '数値を入力';
                            }
                          },
                          textAlign: TextAlign.end,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              monthPoints[i] = int.parse(value);
                            });
                          },
                        ),
                      ),
                      const Text('点取得'),
                    ],
                  ),
                },
                SizedBox(
                  width: deviceWidth * 0.2,
                  child: ElevatedButton(
                    onPressed: () {
                      submitDatabase(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '送信',
                          style: TextStyle(fontSize: deviceWidth * 0.03),
                        ),
                        Icon(
                          Icons.send,
                          size: deviceWidth * 0.03,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
