import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit() : super(null);

  void toggleLocale(Locale currentLocale) {
    if (currentLocale.languageCode == 'id') {
      emit(const Locale('en'));
    } else {
      emit(const Locale('id'));
    }
  }
}