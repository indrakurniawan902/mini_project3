import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:indie_commerce/services/user_service.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void registerUser(String username, String email, String password) async {
    emit(RegisterLoading());
    try {
      final response =
          await UserService.instance.createUser(username, email, password);
      if (response == "Success") {
        emit(RegisterSuccess());
      } else {
        emit(RegisterEror(response));
      }
    } catch (e) {
      emit(RegisterEror(e.toString()));
    }
  }
}
