import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late dynamic _preferences;
  static const _keyLocale = 'locale';
  static const _keyMail = 'mail';
  static const _keyName = 'name';
  static const _keyPublicKey = 'public-key';
  static const _keyToken = 'token';
  static const _keyUsername = 'username';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setLocale(String locale) async =>
      await _preferences.setString(_keyLocale, locale);

  static Future setMail(String mail) async =>
      await _preferences.setString(_keyMail, mail);

  static Future setName(String name) async =>
      await _preferences.setString(_keyName, name);

  static Future setPublicKey(String publicKey) async =>
      await _preferences.setString(_keyPublicKey, publicKey);

  static Future setToken(String token) async =>
      await _preferences.setString(_keyToken, token);

  static Future setUsername(String username) async =>
      await _preferences.setString(_keyUsername, username);

  static String getLocale() => _preferences.getString(_keyLocale) ?? '';
  static String getMail() => _preferences.getString(_keyMail) ?? '';
  static String getName() => _preferences.getString(_keyName) ?? '';
  static String getPublicKey() => _preferences.getString(_keyPublicKey) ?? '';
  static String getToken() => _preferences.getString(_keyToken) ?? '';
  static String getUsername() => _preferences.getString(_keyUsername) ?? '';

  static Future clear() async {
    await _preferences.remove(_keyMail);
    await _preferences.remove(_keyName);
    await _preferences.remove(_keyPublicKey);
    await _preferences.remove(_keyToken);
    await _preferences.remove(_keyUsername);
  }
}
