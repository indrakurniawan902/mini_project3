import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:indie_commerce/models/payment_model.dart';
import 'package:indie_commerce/models/status_model.dart';
import 'package:indie_commerce/navigation/app_routes.dart';
import 'package:indie_commerce/screen/payment/cubit/payment_cubit.dart';

class BankTransferScreen extends StatefulWidget {
  final PaymentModel cartItems;
  const BankTransferScreen({super.key, required this.cartItems});

  @override
  State<BankTransferScreen> createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Payment"),
        centerTitle: true,
      ),
      body: bankWidget(),
    );
  }

  Widget bankWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Silakan transfer ke nomor rekening berikut : "),
          const SizedBox(height: 20),
          const Text("213142534235"),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {
            final uid = FirebaseAuth.instance.currentUser!.uid;
            StatusModel status = StatusModel(
                total: widget.cartItems.totalPrice,
                items:
                    widget.cartItems.cartItems.map((e) => e.toJson()).toList(),
                paymentMethod: "Bank transfer",
                status: "Waiting for Payment");
            context.read<PaymentCubit>().postStatus(status, uid);
            context.pushNamed(AppRoutes.nrStatusPayment);
          }, child: BlocBuilder<PaymentCubit, PaymentState>(
            builder: (context, state) {
              if (state is PaymentPostLoading) {
                return const CircularProgressIndicator();
              } else {
                return const Text("Done");
              }
            },
          ))
        ],
      ),
    );
  }
}
