class Mutations {
  static const String createTodo = '''
    mutation createTodo(\$completed: Boolean, \$title: String!) {
      createTodo(completed: \$completed, title: \$title) {
        todo {
          id
          title
          completed
        }
      }
    }
  ''';
}
