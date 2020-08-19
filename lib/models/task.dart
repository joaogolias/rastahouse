import "./user.dart";

class Task {
  Task(this.title, [this.responsible, this.isFinished = false]);

  String title;
  User responsible;
  bool isFinished;
}
