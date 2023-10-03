import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_ddd/local_cache/cache_abstract.dart';
import 'package:riverpod_ddd/local_cache/cache_tags.dart';

class CacheHandlerI implements CacheHandler {
  // CacheHandlerI();

  late Box<dynamic> _cacheBox;

  @override
  Box<dynamic> getCacheBox() {
    return _cacheBox;
  }

  @override
  Future<void> init(String baxName) async {
    await Hive.initFlutter();
    _cacheBox = await Hive.openBox(baxName);
  }

  @override
  T? get<T>(String tag, {T? defaultValue}) {
    final dynamic value = _cacheBox.get(tag, defaultValue: defaultValue);
    if (value is T) {
      return value;
    } else {
      return defaultValue;
    }
  }

  @override
  void put(String tag, dynamic value) {
    _cacheBox.put(tag, value);
  }

  @override
  void delete(String tag) {
    _cacheBox.delete(tag);
  }

  @override
  String get locale => get(KCacheTags.locale, defaultValue: 'en') ?? 'en';

  @override
  void localeSet({required String locale}) => put(KCacheTags.locale, locale);

  @override
  void setToken({required String token}) => put(KCacheTags.token, token);

  @override
  String get token => get(KCacheTags.token, defaultValue: '') ?? '';

  @override
  void cleanBox() => _cacheBox.clear();
}
