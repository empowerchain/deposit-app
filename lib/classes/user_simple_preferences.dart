import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late dynamic _preferences;
  static const _keyLastName = 'last-name';
  static const _keyLocale = 'locale';
  static const _keyMail = 'mail';
  static const _keyName = 'name';
  static const _keyPublicKey = 'public-key';
  static const _keyToken = 'token';
  static const _keyUsername = 'username';
  static const _keyOrganization = 'organization';
  static const _keyOrganizationId = 'organizationId';
  static const _keyAddress = 'address';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setAddress(String address) async =>
      await _preferences.setString(_keyAddress, address);

  static Future setLastName(String lastName) async =>
      await _preferences.setString(_keyLastName, lastName);

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

  static Future setOrganizationList(List<String> organization) async {
      await _preferences.setStringList(_keyOrganization, organization);
    }

  static Future setOrganizationIdList(List<String> organizationId) async {
      await _preferences.setStringList(_keyOrganizationId, organizationId);
    }

  static String getAddress() => _preferences.getString(_keyAddress) ?? '';
  static String getLastName() => _preferences.getString(_keyLastName) ?? '';
  static String getLocale() => _preferences.getString(_keyLocale) ?? '';
  static String getMail() => _preferences.getString(_keyMail) ?? '';
  static String getName() => _preferences.getString(_keyName) ?? '';
  static String getPublicKey() => _preferences.getString(_keyPublicKey) ?? '';
  static String getToken() => _preferences.getString(_keyToken) ?? '';
  static String getUsername() => _preferences.getString(_keyUsername) ?? '';
  
  static List<String> getOrganization() => _preferences.getStringList(_keyOrganization) ?? [];
  static List<String> getOrganizationId() => _preferences.getStringList(_keyOrganizationId) ?? [];

  static Future clear() async {
    await _preferences.remove(_keyMail);
    await _preferences.remove(_keyLastName);
    await _preferences.remove(_keyName);
    await _preferences.remove(_keyPublicKey);
    await _preferences.remove(_keyToken);
    await _preferences.remove(_keyUsername);
  }
}
