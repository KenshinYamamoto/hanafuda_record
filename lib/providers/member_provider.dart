import 'package:flutter/material.dart';

class MemberProvider with ChangeNotifier {
  final List<String> _members = ['', '', '', ''];
  String _dropDownValue = '';

  void setMember1(String member) {
    _members[0] = member;
    _dropDownValue = member;
    notifyListeners();
  }

  void setMember2(String member) {
    _members[1] = member;
    notifyListeners();
  }

  void setMember3(String member) {
    _members[2] = member;
    notifyListeners();
  }

  void setMember4(String member) {
    _members[3] = member;
    notifyListeners();
  }

  void setDropDownValue(String value) {
    _dropDownValue = value;
    notifyListeners();
  }

  void deleteMembers() {
    _members.fillRange(0, 4, '');
    notifyListeners();
  }

  List<String> get getMembers {
    // final List<String> newMembers = _members
    //   ..removeWhere((member) => member.trim().isEmpty);
    // return newMembers;
    return _members;
  }

  String get getDropDownValue {
    return _dropDownValue;
  }
}
