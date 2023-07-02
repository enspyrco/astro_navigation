import 'dart:convert';

import 'package:navigation_for_perception/src/state/sections/navigation_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('NavigationState json encodes', () {
    expect(jsonEncode(const DefaultNavigationState(stack: [])), isA<String>());
  });
}
