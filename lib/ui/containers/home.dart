import 'package:flutter/material.dart';
import '../../models/taskWeek.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TaskWeek> taskWeeks = [
    TaskWeek(DateTime.utc(2020, 08, 13), DateTime.utc(2020, 08, 29)),
    TaskWeek(DateTime.utc(2020, 08, 16), DateTime.utc(2020, 08, 22)),
    TaskWeek(DateTime.utc(2021, 08, 9), DateTime.utc(2020, 08, 15)),
  ];

  List<Widget> generateTaskWeekUI(List<TaskWeek> tasks) {
    return tasks.map((e) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
                child: Text('${e.startTimeString} - ${e.endTimeString}')),
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: taskWeeks.length,
        itemBuilder: (context, index) {
          TaskWeek item = taskWeeks[index];
          return Container(
              margin: new EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                    child: Text(
                        '${item.startTimeString} - ${item.endTimeString}')),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Criar semana com tarefas',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
