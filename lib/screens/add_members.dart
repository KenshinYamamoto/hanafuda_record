import 'package:flutter/material.dart';

import './add_datas.dart';

class AddMembers extends StatefulWidget {
  static const routeName = '/add-information';
  const AddMembers({super.key});

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  final _formKey = GlobalKey<FormState>();

  List<String> memberNames = ['', '', '', ''];

  void judgementMembers() {
    final bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddDatas(members: memberNames),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メンバー登録'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: const ValueKey('member1'),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return '名前を入力';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        memberNames[0] = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'member1(必須)'),
                  ),
                  TextFormField(
                    key: const ValueKey('member2'),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return '名前を入力';
                      } else if (memberNames[1].trim() ==
                          memberNames[0].trim()) {
                        return '名前の重複';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        memberNames[1] = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'member2(必須)'),
                  ),
                  TextFormField(
                    key: const ValueKey('member3'),
                    validator: (value) {
                      if ((memberNames[0].isEmpty || memberNames[1].isEmpty) &&
                          value!.trim().isEmpty) {
                        return '必須項目の欠如';
                      } else if (memberNames[2].trim() ==
                              memberNames[0].trim() ||
                          memberNames[2].trim() == memberNames[1].trim()) {
                        return '名前の重複';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        memberNames[2] = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration:
                        const InputDecoration(labelText: 'member3(オプション)'),
                  ),
                  TextFormField(
                    key: const ValueKey('member4'),
                    validator: (value) {
                      if ((memberNames[0].isEmpty || memberNames[1].isEmpty) &&
                          value!.trim().isEmpty) {
                        return '必須項目の欠如';
                      } else if (memberNames[3].trim() ==
                              memberNames[0].trim() ||
                          memberNames[3].trim() == memberNames[1].trim() ||
                          (memberNames[3].trim() != '' &&
                              memberNames[3].trim() == memberNames[2].trim())) {
                        return '名前の重複';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        memberNames[3] = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration:
                        const InputDecoration(labelText: 'member4(オプション)'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      judgementMembers();
                    },
                    child: const Text('登録'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
