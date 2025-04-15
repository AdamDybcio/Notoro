import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notoro/models/settings/app_settings_model.dart';

class SettingsNotifier extends ChangeNotifier {
  final Box<AppSettingsModel> box;
  late AppSettingsModel _settings;

  AppSettingsModel get settings => _settings;
  ThemeMode get themeMode => _settings.themeMode;

  SettingsNotifier(this.box) {
    _settings = box.get('settings') ?? AppSettingsModel();
  }

  void updateThemeMode(int index) {
    _settings = _settings.copyWith(themeModeIndex: index);
    box.put('settings', _settings);
    notifyListeners();
  }
}
