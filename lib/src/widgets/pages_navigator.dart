import 'package:core_of_perception/core_of_perception.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:types_for_perception/core_types.dart';
import 'package:types_for_perception/navigation_types.dart';
import 'package:types_for_perception/state_types.dart';
import 'package:flutter/material.dart';

import '../../navigation_for_perception.dart';

/// An [OnStateChangeBuilder] that updates the [Navigator] whenever [AppState.pages]
/// changes.
class PagesNavigator<S extends AstroState> extends StatelessWidget {
  const PagesNavigator({this.onInit, Key? key}) : super(key: key);

  final void Function(MissionControl<S>)? onInit;

  @override
  Widget build(BuildContext context) {
    return OnStateChangeBuilder<S, List<PageState>>(
        onInit: onInit,
        transformer: (state) => (state as AppStateNavigation).navigation.stack,
        builder: (context, stack) {
          var generator = locate<PageGenerator>();
          return Navigator(
              pages: [
                for (var pageState in stack.reversed)
                  generator.applyTo(pageState)
              ],
              onPopPage: (route, dynamic result) {
                if (!route.didPop(result)) {
                  return false;
                }

                if (route.isCurrent) {
                  locate<MissionControl<S>>().land(RemoveCurrentRoute<S>());
                }

                return true;
              });
        });
  }
}
