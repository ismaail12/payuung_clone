part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class Authenticated extends AuthState {
  final User user;
  final int userId;

  Authenticated(this.user, this.userId);
}
final class UnAuthenticated extends AuthState {}
