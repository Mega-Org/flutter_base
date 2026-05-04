part of core;

Future<T> mapApiException<T>({
  required Future<Response?> Function() task,
}) async {
  try {
    final Response? taskResult = await task();
    final Response? response = taskResult;
    if (response == null) {
      throw UnexpectedException(message: appLocalizer.unexpectedError);
    }
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        return response.data;
      case 400:
      case 422:
        final data = response.data;
        throw ApiRequestException(message: data['message'].toString());

      case 401:
        final data = response.data;
        final String errorMessage =
            data["message"] ?? appLocalizer.unauthorizedUserException;
        throw UnauthorizedException(message: errorMessage);

      case 403:
        final data = response.data;
        final String errorMessage =
            data["message"] ?? appLocalizer.unauthorizedUserException;
        throw ApiRequestException(message: errorMessage);

      case 423:
        throw UnVerifiedUserException.fromResponse(response.data);

      case 500:
      default:
        throw UnexpectedException(
          message:
              response.data["error"] ??
              response.data["message"] ??
              appLocalizer.unexpectedError,
        );
    }
  } on SocketException {
    throw ServerException(message: appLocalizer.noInternetConnection);
  } on DioException catch (e) {
    final Response? response = e.response;
    String? errorMessage = response?.data["message"] ?? e.message;

    if (errorMessage?.isEmpty ?? false) {
      errorMessage = null;
    }

    if (response?.statusCode == 423) {
      final Object? data = response?.data;
      if (data is Map<String, dynamic>) {
        throw UnVerifiedUserException.fromResponse(data);
      }
      throw UnexpectedException(message: appLocalizer.unexpectedError);
    } else if (response?.statusCode == 300) {
      throw UserNeedsSubscriptionException();
    }

    if (e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionTimeout) {
      throw ApiRequestException(message: appLocalizer.noInternetConnection);
    } else if (e.type == DioExceptionType.badResponse) {
      throw ApiRequestException(
        message: errorMessage ?? appLocalizer.noInternetConnection,
      );
    } else if (e.type == DioExceptionType.connectionError) {
      throw ApiRequestException(message: appLocalizer.noInternetConnection);
    } else {
      throw UnexpectedException(
        message: errorMessage ?? appLocalizer.unexpectedError,
      );
    }
  } on UnexpectedException catch (_) {
    rethrow;
  } on ApiRequestException catch (_) {
    rethrow;
  } on SecureStorageException catch (_) {
    rethrow;
  } on UnauthorizedException catch (_) {
    rethrow;
  } on String catch (e) {
    throw UnexpectedException(message: e);
  } catch (e) {
    throw UnexpectedException(message: appLocalizer.unexpectedError);
  }
}
