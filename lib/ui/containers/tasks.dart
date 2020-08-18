import 'package:flutter/material.dart';
import 'package:rastahouse/mocks/user.dart';
import 'package:rastahouse/models/taskWeek.dart';
import '../../models/task.dart';
import '../../models/user.dart';
import '../../mocks/task.dart';
import '../../mocks/user.dart';

class TasksPage extends StatefulWidget {
  TasksPage({Key key, this.taskWeek}) : super(key: key);

  final TaskWeek taskWeek;

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<TasksPage> {
  String generateTitle() {
    return 'Tarefas da Semana';
  }

  List<Task> tasks = [];

  List<User> responsibles = [];

  bool isSaveButtonEnabled = false;

  final SnackBar _onSaveSuccess =
      SnackBar(content: Text('Alterações salvas :)'));

  @override
  void initState() {
    tasks = tasksList;
    responsibles = usersList;
    super.initState();
  }

  void changeIsSaveButtonEnabled(bool value) {
    setState(() => {isSaveButtonEnabled = value});
  }

  Function onTaskFinishedChange(Task item) => (bool value) {
        List<Task> tasksCopy = [...tasks];

        tasksCopy[tasksCopy.indexOf(item)].isFinished = value;
        setState(() {
          tasks = tasksCopy;
        });
        changeIsSaveButtonEnabled(true);
      };

  Function onTaskResponsibleChange(Task item) => (User user) {
        List<Task> tasksCopy = [...tasks];

        tasksCopy[tasksCopy.indexOf(item)].responsible = user;
        setState(() {
          tasks = tasksCopy;
        });
        changeIsSaveButtonEnabled(true);
      };

  Function onSaveButtonClick(BuildContext context) => () {
        if (isSaveButtonEnabled) {
          Scaffold.of(context).showSnackBar(_onSaveSuccess);
          changeIsSaveButtonEnabled(false);
        }
      };

  List<DropdownMenuItem> createDropdownMenuItems(List<User> users) {
    return users.map<DropdownMenuItem<User>>((User value) {
      return DropdownMenuItem<User>(
        value: value,
        child: Text(value.name),
      );
    }).toList();
  }

  Widget buildTasksList(BuildContext context, int index) {
    Task item = tasks[index];
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Container(
            height: 60,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.blue,
              width: 1.0,
            ))),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(width: 128, child: Text(item.title)),
              Container(
                  width: 102,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: DropdownButton<User>(
                      onChanged: onTaskResponsibleChange(item),
                      value: item.responsible,
                      items: createDropdownMenuItems(responsibles))),
              Container(
                  height: 64,
                  child: Center(
                      child: Checkbox(
                    value: item.isFinished,
                    onChanged: onTaskFinishedChange(item),
                  )))
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tarefas da Semana'),
        ),
        body: Column(children: [
          Center(
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(widget.taskWeek.duration))),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 64),
                  child: ListView.builder(
                      itemCount: tasks.length, itemBuilder: buildTasksList)))
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (context) => Container(
              width: MediaQuery.of(context).size.width * 0.8,
              // decoration: ,
              child: RaisedButton(
                  color: isSaveButtonEnabled ? Colors.blue : Colors.grey[200],
                  onPressed: onSaveButtonClick(context),
                  child: Text("Salvar"))),
        ));
  }
}
