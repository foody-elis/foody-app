
import '../../main.dart' show objectBox;
import '../../models/settings.dart';
import '../interface/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final _settingsBox = objectBox.store.box<Settings>();

  @override
  void add(Settings settings) {
    _settingsBox.put(settings);
  }

  @override
  Settings? get() {
    final settings = _settingsBox.getAll();

    return settings.isNotEmpty ? settings[0] : null;
  }

  @override
  void removeAll() {
    _settingsBox.removeAll();
  }

  @override
  void update(Settings settings) {
    _settingsBox.put(settings);
  }
}
