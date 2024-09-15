import 'dart:async';
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:payuung/model/user.dart';
import 'package:payuung/service/secure_storage.dart';
import 'package:payuung/service/user_services.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final userService = UserService();

  final secureStorageService = SecureStorageService();

  AuthBloc() : super(AuthInitial()) {
    on<GetUser>(_onGetUser);
    on<CreateUser>(_onCreateUser);
    on<UpdateUser>(_onUpdateUser);
  }

  FutureOr<void> _onGetUser(GetUser event, Emitter<AuthState> emit) async {

    emit(AuthLoading());


    final String? userIdString =
        (await secureStorageService.secureRead(SecureKey.userId));

    if (userIdString != null) {
      final int userId = int.parse(userIdString);
      final user = await userService.getUserById(userId);

      if (user != null) {
        emit(Authenticated(user, userId));
        return;
      }
    }

    emit(UnAuthenticated());
  }

  FutureOr<void> _onCreateUser(
      CreateUser event, Emitter<AuthState> emit) async {

    final userId = await userService.createUser(event.user);
    secureStorageService.secureWrite(
        key: SecureKey.userId, value: userId.toString());

    final user = await userService.getUserById(userId);

    if (user != null) {
      emit(Authenticated(user, userId));
    }
  }

  FutureOr<void> _onUpdateUser(
      UpdateUser event, Emitter<AuthState> emit) async {


    final userId = await userService.updateUser(event.user, event.id);
    final user = await userService.getUserById(userId);

    if (user != null) {
      emit(Authenticated(user, userId));
    }
  }
}
