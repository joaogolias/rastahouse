import 'package:flutter/material.dart';
import 'package:rastahouse/mocks/user.dart';
import 'package:rastahouse/models/taskWeek.dart';
import 'package:intl/intl.dart';
import '../../models/task.dart';
import '../../models/user.dart';
import '../../mocks/task.dart';
import '../../mocks/user.dart';

class TasksPage extends StatefulWidget {
  TasksPage({Key key, this.taskWeek, this.edit = false}) : super(key: key);

  final TaskWeek taskWeek;
  final bool edit;

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

  DateTime initialDate;
  DateTime finalDate;

  final SnackBar _onSaveSuccess =
      SnackBar(content: Text('Alterações salvas :)'));

  @override
  void initState() {
    tasks = widget.edit ? emptyTasksList : tasksList;
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

  void Function(String value) onTitleFieldChange(Task item) => (String value) {
        List<Task> tasksCopy = [...tasks];

        tasksCopy[tasksCopy.indexOf(item)].title = value;
        setState(() {
          tasks = tasksCopy;
        });
        changeIsSaveButtonEnabled(true);
      };

  Future<DateTime> _showDefaultDatePicker(BuildContext context) async {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
  }

  Future<void> _selectInitialDate(BuildContext context) async {
    final DateTime picked = await _showDefaultDatePicker(context);

    if (picked != null && picked != initialDate)
      setState(() {
        initialDate = picked;
      });
  }

  Future<void> _selectFinalDate(BuildContext context) async {
    final DateTime picked = await _showDefaultDatePicker(context);

    if (picked != null && picked != finalDate)
      setState(() {
        finalDate = picked;
      });
  }

  void onAddTaskClick() {
    List<Task> tasksCopy = [...tasks];

    tasksCopy.add(Task(""));
    setState(() {
      tasks = tasksCopy;
    });
  }

  void Function() onRemoveTaskClick(Task item) => () {
        List<Task> tasksCopy = [...tasks];

        tasksCopy.remove(item);
        setState(() {
          tasks = tasksCopy;
        });
      };

  Widget getTitleFiled(Task item) {
    return widget.edit
        ? TextFormField(
            initialValue: item.title,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: onTitleFieldChange(item),
            decoration: InputDecoration(hintText: "Tarefa"),
          )
        : Text(item.title);
  }

  Widget buildTasksList(BuildContext context, int index) {
    if (index < tasks.length) {
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
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(width: 112, child: getTitleFiled(item)),
                Container(
                    width: 102,
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: DropdownButton<User>(
                        hint: Text("Selecione"),
                        onChanged: onTaskResponsibleChange(item),
                        value: item?.responsible,
                        items: createDropdownMenuItems(responsibles))),
                Container(
                    height: 64,
                    child: Center(
                        child: Checkbox(
                      value: item.isFinished,
                      onChanged: onTaskFinishedChange(item),
                    ))),
                Visibility(
                    visible: widget.edit,
                    child: Container(
                        child: Center(
                            child: IconButton(
                                padding: new EdgeInsets.all(0.0),
                                onPressed: onRemoveTaskClick(item),
                                icon: Icon(Icons.delete)))))
              ])));
    } else {
      return Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Container(
              margin: EdgeInsets.only(top: 16),
              child: RaisedButton(
                  color: Colors.blue,
                  onPressed: onAddTaskClick,
                  child: Icon(Icons.add))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.edit ? 'Criando Tarefas' : 'Tarefas da Semana'),
        ),
        body: Column(children: [
          Visibility(
              visible: !widget.edit,
              child: Center(
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(widget.taskWeek?.duration ?? "")))),
          Visibility(
              visible: widget.edit,
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Data inicial: ",
                              style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )),
                          Container(
                              child: InkWell(
                            child: Text(
                                initialDate != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(initialDate)
                                    : "Clique aqui",
                                style: new TextStyle(
                                  fontSize: 16.0,
                                )),
                            onTap: () => _selectInitialDate(context),
                          ))
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Row(
                            children: [
                              Text("Data final: ",
                                  style: new TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Container(
                                  child: InkWell(
                                child: Text(
                                    finalDate != null
                                        ? DateFormat('dd/MM/yyyy')
                                            .format(finalDate)
                                        : "Clique aqui",
                                    style: new TextStyle(
                                      fontSize: 16.0,
                                    )),
                                onTap: () => _selectFinalDate(context),
                              ))
                            ],
                          ))
                    ],
                  ))),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 64),
                  child: ListView.builder(
                      itemCount: widget.edit ? tasks.length + 1 : tasks.length,
                      itemBuilder: buildTasksList)))
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
