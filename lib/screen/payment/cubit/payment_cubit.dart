import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:indie_commerce/models/status_model.dart';
import 'package:indie_commerce/services/payment_service.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  void postStatus(StatusModel data, String uid) async {
    emit(PaymentPostLoading());
    try {
      final response = await PaymentService.instance.addToStatus(data, uid);
      emit(PaymentPostSuccess(response));
    } catch (e) {
      emit(PaymentPostError(e.toString()));
    }
  }

  void getStatus(String uid) async {
    emit(PaymentGetLoading());
    try {
      final response = await PaymentService.instance.getAllStatus(uid);
      emit(PaymentGetSuccess(response));
    } catch (e) {
      emit(PaymentGetError(e.toString()));
    }
  }
}
