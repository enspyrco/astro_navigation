import 'package:types_for_perception/core_types.dart';
import 'package:types_for_perception/navigation_types.dart';
import 'package:types_for_perception/state_types.dart';

import '../state/sections/navigation_state.dart';

class PushRoute<S extends AstroState> extends LandingMission<S> {
  const PushRoute(this.pageState);

  final PageState pageState;

  @override
  S landingInstructions(S state) {
    DefaultNavigationState navigation =
        (state as dynamic).navigation as DefaultNavigationState;
    var newNavigation =
        navigation.copyWith(stack: [pageState, ...navigation.stack]);
    return (state as dynamic).copyWith(navigation: newNavigation) as S;
  }

  @override
  toJson() => {
        'name_': 'PushRoute',
        'state_': {'pageState': (pageState as AstroState).toJson()}
      };
}
