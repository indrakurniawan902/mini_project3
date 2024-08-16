part of 'add_item_cubit.dart';

sealed class AddItemState extends Equatable {
  const AddItemState();

  @override
  List<Object> get props => [];
}

final class AddItemInitial extends AddItemState {}

final class AddItemLoading extends AddItemState {}

final class AddItemSuccess extends AddItemState {
  final String message;
  const AddItemSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class AddItemError extends AddItemState {
  final String message;
  const AddItemError(this.message);

  @override
  List<Object> get props => [message];
}

final class AddItemCartLoading extends AddItemState {}

final class AddItemCartSuccess extends AddItemState {
  final String message;
  const AddItemCartSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class AddItemCartError extends AddItemState {
  final String message;
  const AddItemCartError(this.message);

  @override
  List<Object> get props => [message];
}
