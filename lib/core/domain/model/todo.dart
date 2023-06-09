class Todo {
  String? id;
  String? title;
  bool? completed;

  Todo({this.id, this.title, this.completed});

  //  method to convert map to model class
  static Todo convertFromMap({required Map map}) =>
      Todo(id: map['id'], title: map['title'], completed: map['completed']);
}
