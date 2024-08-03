part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class UserLoadingState extends ProfileState {}

class UserLoadedState extends ProfileState {
  final UserModel users;
  const UserLoadedState(this.users);
  @override
  List<Object> get props => [users];
}

class UserErrorState extends ProfileState {
  final String error;
  const UserErrorState(this.error);
  @override
  List<Object> get props => [error];
}
