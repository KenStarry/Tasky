import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../core/data/utils/constants.dart';

var locator = GetIt.instance;

void init() {
  //  providing our HttpLink
  locator.registerSingleton<HttpLink>(HttpLink(Constants.httpLink));

  //  providing query client
  locator.registerLazySingleton<ValueNotifier<GraphQLClient>>(() {
    Link? httpLink = locator.get<HttpLink>();

    return ValueNotifier(GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
        defaultPolicies: DefaultPolicies(
            watchMutation: Policies(fetch: FetchPolicy.networkOnly),
            watchQuery: Policies(fetch: FetchPolicy.networkOnly))));
  });
}
