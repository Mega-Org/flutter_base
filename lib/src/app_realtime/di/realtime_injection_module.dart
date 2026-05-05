import 'package:dio/dio.dart';
import 'package:flutter_base/core/constants/api_constants.dart';
import 'package:flutter_base/core/core.dart';
import 'package:flutter_base/src/app_realtime/app_realtime.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RealtimeInjectionModule {
  /// Replace with [RealtimeTransportConfigPusher] or your Socket.IO server URL.
  @lazySingleton
  RealtimeTransportConfig get realtimeTransportConfig =>
      const RealtimeTransportConfigSocket(
        serverUrl: 'http://127.0.0.1:3000',
        allowGuestConnect: true,
      );

  @lazySingleton
  RealtimeCoordinator realtimeCoordinator(
    RealtimeTransportConfig config,
    Dio dio,
    GetTokenUseCase getTokenUseCase,
  ) {
    Future<dynamic> pusherAuthorizer(
      String channelName,
      String socketId,
    ) async {
      if (config is! RealtimeTransportConfigPusher) {
        return null;
      }
      final token = await getTokenUseCase();
      if (token == null) {
        return null;
      }
      final path = config.authBroadcastingPath;
      final url = path.startsWith('http')
          ? path
          : '${ApiConstants.getBaseApiUrl}$path';
      final response = await dio.post<dynamic>(
        url,
        data: <String, dynamic>{
          'socket_id': socketId,
          'channel_name': channelName,
        },
        options: Options(
          headers: <String, dynamic>{
            'Authorization': 'Bearer ${token.token}',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.data;
    }

    return RealtimeCoordinatorFactory.create(
      transport: config,
      pusherChannelAuthorizer:
          config is RealtimeTransportConfigPusher ? pusherAuthorizer : null,
    );
  }
}
