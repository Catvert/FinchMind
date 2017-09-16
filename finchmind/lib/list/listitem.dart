import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  String text;
  bool checked;

  bool addNow = true;

  ListItem(this.text, {this.checked = false});

  @override
  State<StatefulWidget> createState() => new _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return new CheckboxListTile(
      title: new TextField(
        controller: new TextEditingController(text: widget.text),
        decoration: null,
        autofocus: widget.addNow,
        onSubmitted: (value) {
          setState(() {
            widget.text = value;
            widget.addNow = false;
          });
        },
        onChanged: (value) {
          widget.text = value;
        },
      ),
      value: widget.checked,
      onChanged: (bool value) {
        setState(() {
          widget.checked = value;
        });
      },
    );
  }
}
