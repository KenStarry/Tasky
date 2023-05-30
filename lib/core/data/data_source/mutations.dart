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

  static const String updateTodo = '''
    mutation updateTodo(\$completed: Boolean, \$id: ID!, \$title: String){
      updateTodo(completed: \$completed, id: \$id, title: \$title) {
        todo {
          id
          title
          completed
        }
      }
    }
  ''';

  static const String deleteTodo = '''
    mutation deleteTodo(\$id: ID!) {
      deleteTodo(id: \$id) {
        success
      }
    }
  ''';
}
