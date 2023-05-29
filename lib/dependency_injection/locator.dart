import 'package:get_it/get_it.dart';

import 'graphql_di.dart';

var locator = GetIt.instance;

void init() {
  graphQlDI(locator: locator);
}
