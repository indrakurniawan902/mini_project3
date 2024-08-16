part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {}

final class RegisterEror extends RegisterState {
  final String error;

  const RegisterEror(this.error);

  @override
  List<Object> get props => [error];
}
