import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduled_notifications/scheduled_notifications.dart';

class AlarmItem extends StatefulWidget {
  String title;
  String content;

  DateTime dateTime;

  int _id = -1;

  final ValueChanged<AlarmItem> _onRemove;

  AlarmItem(this.dateTime, this.content, this._onRemove, {this.title = "N'oublie pas !"}) {
    schedule();
  }

  @override
  State<StatefulWidget> createState() => new _AlarmItemState();

  schedule() async {
    if (isTimeElapsed()) {
      _id = -1;
      return;
    }

    if (isSchedule()) {
      unschedule();
    }
    _id = await ScheduledNotifications.scheduleNotification(
        dateTime.millisecondsSinceEpoch, "Ticker", title, content);
  }

  unschedule() async {
    if (isSchedule() &&
        await ScheduledNotifications.hasScheduledNotification(_id)) {
      await ScheduledNotifications.unscheduleNotification(_id);
      _id = -1;
    }
  }

  bool isTimeElapsed() => dateTime.isBefore(new DateTime.now());

  bool isSchedule() => _id != -1 && !isTimeElapsed();
}

class _AlarmItemState extends State<AlarmItem> {
  @override
  Widget build(BuildContext context) {
    var bottomSheetContentController =
        new TextEditingController(text: widget.content);

    return new Card(
        child: new GestureDetector(
            onLongPress: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return new Container(
                        child: new Padding(
                            padding: new EdgeInsets.all(32.0),
                            child: new Column(children: [
                              new Center(
                                  child: new TextField(
                                      decoration: null,
                                      textAlign: TextAlign.center,
                                      controller: bottomSheetContentController,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.content = value;
                                        });
                                      })),
                              new ListTile(
                                  leading: new Icon(Icons.delete),
                                  title: const Text("Supprimer"),
                                  onTap: () { setState(() { widget._onRemove(widget); Navigator.pop(context); });})
                            ])));
                  });
            },
            child: new SwitchListTile(
              title: new Text(widget.content),
              subtitle: new Text(
                  new DateFormat("dd-MM-yyyy HH:mm").format(widget.dateTime)),
              value: widget.isSchedule(),
              onChanged: (bool value) {
                setState(() {
                  value ? widget.schedule() : widget.unschedule();
                });
              },
            )));
  }
}
