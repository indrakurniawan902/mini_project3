import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:indie_commerce/models/user_model.dart';
import 'package:indie_commerce/services/user_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void getUserByEmail(String email) async {
    emit(UserLoadingState());
    try {
      final user = await UserService.instance.getUserByEmail(email);
      emit(UserLoadedState(user));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
}
