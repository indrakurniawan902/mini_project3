import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void checkUserLogin() async {
    emit(SplashLoading());
    try {
      Future.delayed(const Duration(seconds: 1), () {
        if (FirebaseAuth.instance.currentUser != null) {
          emit(SplashSuccess());
        } else {
          emit(SplashError());
        }
      });
    } catch (e) {
      emit(SplashError());
    }
  }
}
