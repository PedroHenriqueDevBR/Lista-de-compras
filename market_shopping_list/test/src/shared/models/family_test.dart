import 'package:flutter/physics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';

void main() {
  late Family family;
  setUpAll(() {
    family = Family(
      family_id: 'id01',
      name: 'Familia 01',
      password: '12345678',
    );
  });

  test('Family must not be bull', () {
    expect(family, isNotNull);
  });
  test('family id must be null', () {
    expect(family.id, isNull);
  });
  test('family attributes must not be null', () {
    expect(family.family_id, 'id01');
    expect(family.name, 'Familia 01');
    expect(family.password, '12345678');
  });
}
