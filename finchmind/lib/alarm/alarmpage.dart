import 'package:FinchMind/alarm/alarmitem.dart';
import 'package:FinchMind/basepage.dart';
import 'package:flutter/material.dart';

class AlarmPage extends BasePage {
  AlarmPage() : super("Alarmes", Icons.alarm);

  List<AlarmItem> _items = [];

  _AlarmPageState _state;

  Key key;

  @override
  void onAddFABClick() {
    var nowDate = new DateTime.now().add(new Duration(minutes: 1));

    showDatePicker(
        context: _state.context,
        initialDate: nowDate,
        firstDate: nowDate,
        lastDate: nowDate.add(new Duration(days: 100))).then((date) {
      showTimePicker(context: _state.context, initialTime: new TimeOfDay.now())
          .then((time) {
        var titleController = new TextEditingController();

        showDialog(
            context: _state.context,
            child: new SimpleDialog(
                title: const Text("Se rappeler de .."),
                children: [
                  new TextField(controller: titleController),
                  new ButtonTheme.bar(
                      child: new ButtonBar(children: [
                    new FlatButton(
                        onPressed: () {
                          _state.add(new AlarmItem(
                              new DateTime(date.year, date.month, date.day,
                                  time.hour, time.minute),
                              titleController.text, (removeItem) {
                                removeItem.unschedule();
                            _state.remove(removeItem);
                          }));
                          Navigator.pop(_state.context);
                        },
                        child: const Text("Ajouter"))
                  ]))
                ]));
      });
    });
  }

  @override
  State<StatefulWidget> createState() {
    var state = new _AlarmPageState();
    _state = state;
    return state;
  }
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
        child: new Column(children: widget._items));
  }

  void add(AlarmItem item) {
    setState(() {
      widget._items.add(item);
    });
  }

  void remove(AlarmItem item) {
    setState(() {
      widget._items.remove(item);
    });
  }
}
