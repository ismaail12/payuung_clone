part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class GetUser extends AuthEvent {}
final class CreateUser extends AuthEvent {
  final User user;

  CreateUser(this.user);
}
final class UpdateUser extends AuthEvent {
  final User user;
  final int id;

  UpdateUser(this.user, this.id);
}