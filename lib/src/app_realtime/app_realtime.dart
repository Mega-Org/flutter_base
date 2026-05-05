library app_realtime;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'config/realtime_connect_context.dart';
part 'config/realtime_transport_config.dart';
part 'models/realtime_envelope.dart';
part 'models/subscription_state.dart';
part 'models/realtime_listen_options.dart';
part 'data/realtime_transport.dart';
part 'data/adapters/pusher_realtime_adapter.dart';
part 'data/adapters/socket_realtime_adapter.dart';
part 'data/debounce_stream_transformer.dart';
part 'data/realtime_coordinator.dart';
part 'data/realtime_coordinator_factory.dart';
part 'domain/realtime_auth_provider.dart';
part 'domain/realtime_auth_provider_impl.dart';
part 'domain/realtime_params.dart';
part 'domain/realtime_repository.dart';
part 'domain/realtime_repository_impl.dart';
part 'domain/i_realtime_listen_use_case.dart';
part 'domain/i_realtime_emit_use_case.dart';
part 'domain/use_cases/listen_realtime_envelope_use_case.dart';
part 'domain/use_cases/emit_realtime_event_use_case.dart';
