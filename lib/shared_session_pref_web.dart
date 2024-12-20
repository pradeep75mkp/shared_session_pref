







// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show json;
import 'dart:html' as html;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:shared_session_pref/shared_session_pref_platform_interface.dart';
import 'package:shared_session_pref/types.dart';



/// The web implementation of [SharedPreferencesStorePlatform].
///
/// This class implements the `package:shared_preferences` functionality for the web.
class SharedSessionPrefWeb extends SharedSessionPrefPlatform {
  /// Registers this class as the default instance of [SharedPreferencesStorePlatform].
  static void registerWith(Registrar? registrar) {
    SharedSessionPrefPlatform.instance = SharedSessionPrefWeb();
  }

  static const String _defaultPrefix = 'flutter.mkp.';

  @override
  Future<bool> clear() async {
    return clearWithParameters(
      ClearParameters(
        filter: PreferencesFilter(prefix: _defaultPrefix),
      ),
    );
  }

  @override
  Future<bool> clearWithPrefix(String prefix) async {
    return clearWithParameters(
        ClearParameters(filter: PreferencesFilter(prefix: prefix)));
  }

  @override
  Future<bool> clearWithParameters(ClearParameters parameters) async {
    final PreferencesFilter filter = parameters.filter;
    // IMPORTANT: Do not use html.window.sessionStorage.clear() as that will
    //            remove _all_ local data, not just the keys prefixed with
    //            _prefix
    _getFilteredKeys(filter.prefix, allowList: filter.allowList)
        .forEach(html.window.sessionStorage.remove);
    return true;
  }

  @override
  Future<Map<String, Object>> getAll() async {
    return getAllWithParameters(
      GetAllParameters(
        filter: PreferencesFilter(prefix: _defaultPrefix),
      ),
    );
  }

  @override
  Future<Map<String, Object>> getAllWithPrefix(String prefix) async {
    return getAllWithParameters(
        GetAllParameters(filter: PreferencesFilter(prefix: prefix)));
  }

  @override
  Future<Map<String, Object>> getAllWithParameters(
      GetAllParameters parameters) async {
    final PreferencesFilter filter = parameters.filter;
    final Map<String, Object> allData = <String, Object>{};
    for (final String key
    in _getFilteredKeys(filter.prefix, allowList: filter.allowList)) {
      allData[key] = _decodeValue(html.window.sessionStorage[key]!);
    }
    return allData;
  }

  @override
  Future<bool> remove(String key) async {
    html.window.sessionStorage.remove(key);
    return true;
  }

  @override
  Future<bool> setValue(String valueType, String key, Object? value) async {
    html.window.sessionStorage[key] = _encodeValue(value);
    return true;
  }

  Iterable<String> _getFilteredKeys(
      String prefix, {
        Set<String>? allowList,
      }) {
    return html.window.sessionStorage.keys.where((String key) =>
    key.startsWith(prefix) && (allowList?.contains(key) ?? true));
  }

  String _encodeValue(Object? value) {
    return json.encode(value);
  }

  Object _decodeValue(String encodedValue) {
    final Object? decodedValue = json.decode(encodedValue);

    if (decodedValue is List) {
      // JSON does not preserve generics. The encode/decode roundtrip is
      // `List<String>` => JSON => `List<dynamic>`. We ha
      // ve to explicitly
      // restore the RTTI.
      return decodedValue.cast<String>();
    }

    return decodedValue!;
  }
}




