import 'dart:convert';

import '../../core.dart';

const String _kTokenKey = 'access_token';
const String _kTokenActivated = 'activation';
const String _kCreatedAtKey = 'TokenCreatedAt';

class TokenModel extends TokenEntity {
  TokenModel({
    required super.token,
    super.isSingleSession = false,
    DateTime? createdAt,
  }) : super(createdAt: createdAt ?? DateTime.now());

  factory TokenModel.fromEntity(Token token) => TokenModel(
    token: token.token,
    createdAt: token.createdAt,
    isSingleSession: token.isSingleSession,
  );

  factory TokenModel.forSingleSession({required String token}) => TokenModel(
    token: token,
    isSingleSession: true,
    createdAt: DateTime.now(),
  );

  factory TokenModel.fromCache(String tokenJson) {
    final Map<String, dynamic> decodedMap = json.decode(tokenJson);
    return TokenModel.fromMap(decodedMap);
  }

  factory TokenModel.fromMap(Map<String, dynamic> tokenMap) {
    final Map<String, dynamic> decodedMap = tokenMap;
    DateTime? createdAt;
    if (decodedMap.containsKey(_kCreatedAtKey)) {
      createdAt = DateTime.fromMillisecondsSinceEpoch(
        decodedMap[_kCreatedAtKey],
      );
    }
    final bool isSingleSession = decodedMap[_kTokenActivated] ?? false;
    final String token = decodedMap[_kTokenKey] ?? '';
    return TokenModel(
      token: token,
      isSingleSession: isSingleSession,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> get toMap => {
    _kTokenKey: token,
    _kTokenActivated: isSingleSession,
    _kCreatedAtKey: createdAt.millisecondsSinceEpoch,
  };

  String get toJson => json.encode(toMap);
}
