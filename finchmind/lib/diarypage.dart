import 'package:FinchMind/basepage.dart';
import 'package:flutter/material.dart';

class DiaryPage extends BasePage {
  DiaryPage() : super("Journal", Icons.book);

  @override
  void onAddFABClick() {

  }
  @override
  State<StatefulWidget> createState() => new _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {

  @override
  Widget build(BuildContext context) {
    return new Center(child: new Text("Diary"));
  }
}