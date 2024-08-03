import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());
   try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(const LoginError('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(const LoginError('Wrong password provided for that user.'));
      }
      else{
        emit(LoginError(e.code));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
