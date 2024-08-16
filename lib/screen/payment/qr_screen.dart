import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:indie_commerce/models/payment_model.dart';
import 'package:indie_commerce/models/status_model.dart';
import 'package:indie_commerce/navigation/app_routes.dart';
import 'package:indie_commerce/screen/payment/cubit/payment_cubit.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatefulWidget {
  final PaymentModel cartItems;
  const QrScreen({super.key, required this.cartItems});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("QR Payment"),
          centerTitle: true,
        ),
        body: qrWidget());
  }

  Widget qrWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Silakan melakukan pembayaran dengan scan QR berikut :",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          QrImageView(
            data: widget.cartItems.totalPrice,
            version: QrVersions.auto,
            size: 200.0,
          ),
          const SizedBox(height: 30),
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
