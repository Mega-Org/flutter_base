part of app_realtime;

/// Supplies bearer tokens for realtime connections (private channels, socket auth).
abstract class RealtimeAuthProvider {
  Future<String?> getBearerToken();
}
