import 'package:get_it/get_it.dart';
import 'package:tasky/dependency_injection/core_di.dart';

import 'graphql_di.dart';

var locator = GetIt.instance;

void init() {
  coreDI(locator: locator);
  graphQlDI(locator: locator);
}
