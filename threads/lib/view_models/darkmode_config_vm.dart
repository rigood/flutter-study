import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/models/darkmode_config_model.dart';
import 'package:threads/repos/darkmode_config_repo.dart';

class DarkmodeConfigViewModel extends Notifier<DarkmodeConfigModel> {
  final DarkmodeConfigRepository _repository;

  DarkmodeConfigViewModel(this._repository);

  @override
  DarkmodeConfigModel build() {
    return DarkmodeConfigModel(
      isDarkmode: _repository.isDarkmode(),
    );
  }

  void setDarkmode(bool value) {
    _repository.setDarkmode(value);
    state = DarkmodeConfigModel(
      isDarkmode: value,
    );
  }
}

final darkmodeConfigProvider =
    NotifierProvider<DarkmodeConfigViewModel, DarkmodeConfigModel>(
  () => throw UnimplementedError(),
);
