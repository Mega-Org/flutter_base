part of core;


/// Events are:
/// 1- AppStarted
/// 2- OnFinishWalkThrowEvent
/// 3- RoleChanged
/// 4- Authenticated
/// 5- LoggedOut
/// 6- WalkthroughDone
/// 7- AuthRestart

abstract class AppAuthenticationEvent extends Equatable {
  const AppAuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStartedEvent extends AppAuthenticationEvent {
  const AppStartedEvent();
}

class OnFinishWalkThrowEvent extends AppAuthenticationEvent {
  const OnFinishWalkThrowEvent();
}

class AuthenticatedEvent extends AppAuthenticationEvent {
  const AuthenticatedEvent();
}

class GuestEvent extends AppAuthenticationEvent {
  const GuestEvent();
}

class LoggedOutEvent extends AppAuthenticationEvent {
  const LoggedOutEvent();
}

class AuthRestartEvent extends AppAuthenticationEvent {
  const AuthRestartEvent();
}