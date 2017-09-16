import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:FinchMind/basepage.dart';
import 'package:FinchMind/list/listgroup.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ListPage extends BasePage {
  ListPage() : super("Listes", Icons.list);

  _ListPageState _state;

  List<ListGroup> _groups = [new ListGroup("test", [])];

  @override
  State<StatefulWidget> createState() {
    var state = new _ListPageState();
    _state = state;
    return state;
  }

  @override
  void onAddFABClick() {
    var titleController = new TextEditingController();

    var dialog = new SimpleDialog(title: new Text("Ajouter"), children: [
      new Column(children: [new Text("Titre"), new TextField(controller: titleController)]),
      new ButtonTheme.bar(
          child: new ButtonBar(children: [
        new FlatButton(
            onPressed: () {
              _state.add(titleController.text);
              Navigator.pop(_state.context);
            },
            child: new Text("Ajouter"))
      ]))
    ]);

    showDialog(context: _state.context, child: dialog);
  }
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();

    _getListFile().then((file) {
        if(file.existsSync()) {
          setState(() {
            var listgroups = JSON.decode(file.readAsStringSync());
            widget._groups = listgroups;
          });
        }
    });
  }

  @override
  void dispose() {
    super.dispose();

    /*_getListFile().then((value) {
      print(JSON.encode(widget._groups));
      //value.writeAsString();
    });*/
  }

  Future<File> _getListFile() async => new File("${(await getApplicationDocumentsDirectory()).path}/listdata.json");

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
        child: new Column(children: widget._groups));
  }

  void add(String title) {
    setState(() {
      widget._groups.add(new ListGroup(title, []));
    });

   /* _getListFile().then((file) {
      file.writeAsString(JSON.encode(widget._groups));
    });*/
  }
}
