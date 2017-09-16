import 'package:FinchMind/list/listitem.dart';
import 'package:flutter/material.dart';

class ListGroup extends StatefulWidget {
  List<ListItem> items;

  String groupName;

  ListGroup(this.groupName, this.items);

  @override
  State<StatefulWidget> createState() => new _ListGroupState(groupName);
}

class _ListGroupState extends State<ListGroup> {
  String groupName;

  _ListGroupState(this.groupName);

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    widget.items.sort((a, b) {
      if (a.checked && b.checked) return 0;
      if (a.checked && !b.checked)
        return 1;
      else
        return -1;
    });

    children.addAll(widget.items);

    children.add(new ButtonTheme.bar(
        child: new ButtonBar(children: [
      new FlatButton(
          onPressed: () {
            setState(() {
              //_showAddItemDialog(context);
              widget.items.add(new ListItem(""));
            });
          },
          child: new Text("Ajouter")),
      new FlatButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return new Container(
                      child: new Padding(
                          padding: new EdgeInsets.all(32.0),
                          child: new Row(children: [])));
                });
          },
          child: new Text("Modifier"))
    ])));

    return new Padding(padding: new EdgeInsets.all(32.0), child: new ExpansionTile(title: new Text(widget.groupName), children: children));
  }
}
