import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit({required Locale locale}) : super(LocaleState(locale: locale));

  void changeLanguage(Locale lang) {
    if (lang == state.locale) return;
    emit(LocaleState(locale: lang));
  }
}
