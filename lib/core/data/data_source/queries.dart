class Queries {
  static const String getTodos = '''
    query getTodos(\$completed: Boolean, \$search: String) {
       todos(completed: \$completed, search: \$search) {
         id
         title
         completed
       }
    }
  ''';
}
