part of app_realtime;

/// Pusher: cannot trigger client events until subscription succeeds.
enum SubscriptionState {
  idle,
  subscribing,
  ready,
  failed,
}
