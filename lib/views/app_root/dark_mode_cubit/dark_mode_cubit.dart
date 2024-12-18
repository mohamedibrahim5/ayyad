import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnelbarh/shared/resources/theme.dart';

import '../../../shared/resources/constant.dart';
import '../../../shared/resources/prefs_helper.dart';
import '../../../shared/resources/service_locator.dart';

class ThemeCubit extends Cubit<ThemeModeChanged> {
  ThemeCubit() : super(ThemeModeChanged(userTheme: AppTheme.lightTheme));
  bool _isDark = false;

  bool get isDark => _isDark;

  static ThemeCubit get(context) => BlocProvider.of(context);
  String currentTheme = Constants.light;

  void getSavedTheme() {
    final response = sl<PrefsHelper>().getTheme();
    currentTheme = response ;
    _checkTheme(currentTheme);
  }

  Future<void> _changeTheme(String theme) async {
    await sl<PrefsHelper>().setData(key: Constants.theme, value: theme);
    currentTheme = theme;
    _checkTheme(theme);
  }

  void toDarkMode() => _changeTheme(Constants.dark);

  void toLightMode() => _changeTheme(Constants.light);

  _checkTheme(String theme) {
    if (currentTheme == Constants.dark) {
      _isDark = true;
      emit(ThemeModeChanged(userTheme: AppTheme.darkTheme));
    } else {
      _isDark = false;
      emit(ThemeModeChanged(userTheme: AppTheme.lightTheme));
    }
  }
}

class ThemeModeChanged {
  final ThemeData userTheme;

  const ThemeModeChanged({required this.userTheme});

  ThemeModeChanged copyWith({
    ThemeData? userTheme,
  }) {
    return ThemeModeChanged(
      userTheme: userTheme ?? this.userTheme,
    );
  }

  List<Object?> get props => [userTheme];
}
