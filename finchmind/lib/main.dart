import 'package:FinchMind/alarm/alarmpage.dart';
import 'package:FinchMind/diarypage.dart';
import 'package:FinchMind/list/listpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new FinchMindApp());
}

class FinchMindApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _FinchMindState();
}

class _FinchMindState extends State<FinchMindApp> with SingleTickerProviderStateMixin {
  var pages = [
    new ListPage(),
    new AlarmPage(),
    new DiaryPage()
  ];

  @override
  Widget build(BuildContext context) {
    var tabController = new TabController(length: pages.length, vsync: this);

    return new MaterialApp(
      title: 'FinchMind',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  new Scaffold(
        appBar: new AppBar(
          title: const Text("FinchMind"),
          bottom: new TabBar(isScrollable: false, controller: tabController, tabs: pages.map((page) { return new Tab(text: page.pageName, icon: new Icon(page.icon)); }).toList()),
        ),
        body: new TabBarView(controller: tabController, children: pages),
        floatingActionButton: new FloatingActionButton(child: new Icon(Icons.add), onPressed: () { pages[tabController.index].onAddFABClick(); }),
      ),
    );
  }
}