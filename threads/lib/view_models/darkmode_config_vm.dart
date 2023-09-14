import 'package:flutter/material.dart';
import 'package:threads/models/darkmode_config_model.dart';
import 'package:threads/repos/darkmode_config_repo.dart';

class DarkmodeConfigViewModel extends ChangeNotifier {
  final DarkmodeConfigRepository _repository;

  late final DarkmodeConfigModel _model = DarkmodeConfigModel(
    darkmode: _repository.isDarkmode(),
  );

  DarkmodeConfigViewModel(this._repository);

  bool get darkmode => _model.darkmode;

  void setDarkmode(bool value) {
    _repository.setDarkmode(value);
    _model.darkmode = value;
    notifyListeners();
  }
}
