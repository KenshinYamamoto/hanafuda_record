import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/member_provider.dart';

class AddInformation extends StatefulWidget {
  static const routeName = '/add-information';
  const AddInformation({super.key});

  @override
  State<AddInformation> createState() => _AddInformationState();
}

class _AddInformationState extends State<AddInformation> {
  // Widget generateMemberTextField(String member, String label) {
  //   return TextField(
  //     onChanged: (value) {
  //       setState(() {
  //         member = value;
  //         print('$member');
  //       });
  //     },
  //     decoration: InputDecoration(
  //       labelText: label,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final memberData = Provider.of<MemberProvider>(context);
    final List<String> members = memberData.getMembers;
    String dropDownValue = memberData.getDropDownValue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AddInformation'),
        leading: IconButton(
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
          ),
          onPressed: () {
            memberData.deleteMembers();
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/',
              (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                memberData.setMember1(value);
                print(members[0]);
              },
              decoration: const InputDecoration(
                labelText: 'member1(必須)',
              ),
            ),
            TextField(
              onChanged: (value) {
                memberData.setMember2(value);
                print(members[1]);
              },
              decoration: const InputDecoration(
                labelText: 'member2(必須)',
              ),
            ),
            TextField(
              onChanged: (value) {
                memberData.setMember3(value);
                print(members[2]);
              },
              decoration: const InputDecoration(
                labelText: 'member3(オプション)',
              ),
            ),
            TextField(
              onChanged: (value) {
                memberData.setMember4(value);
                print(members[3]);
              },
              decoration: const InputDecoration(
                labelText: 'member4(オプション)',
              ),
            ),
            if (members[0].isNotEmpty && members[1].isNotEmpty)
              Row(
                children: [
                  const Text('1月: '),
                  DropdownButton(
                    value: dropDownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onChanged: (value) {
                      memberData.setDropDownValue(value!);
                    },
                    items:
                        members.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                        value: value.isNotEmpty ? value : null,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const Text('が'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
