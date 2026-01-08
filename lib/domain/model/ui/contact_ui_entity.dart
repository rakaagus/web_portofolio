import 'package:drift/drift.dart';

class ContactUiEntity extends Table {
  late final email = text()();
  late final phoneNumber = text()();
  late final address = text()();
}