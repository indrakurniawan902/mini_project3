import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:indie_commerce/models/payment_model.dart';
import 'package:indie_commerce/navigation/app_routes.dart';

class SelectPaymentScreen extends StatefulWidget {
  final PaymentModel cartItems;
  const SelectPaymentScreen({super.key, required this.cartItems});

  @override
  State<SelectPaymentScreen> createState() => _SelectPaymentScreenState();
}

class _SelectPaymentScreenState extends State<SelectPaymentScreen> {
  List<String> paymentMetod = ["QRIS", "E-wallet", "Bank Transfer"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Method"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: SizedBox(
              height: 70,
              child: GestureDetector(
                onTap: () {
                  if (index == 0) {
                    context.pushNamed(AppRoutes.nrQrPayment,
                        extra: widget.cartItems);
                  } else if (index == 1) {
                    context.pushNamed(AppRoutes.nrEwalletPayment,
                        extra: widget.cartItems);
                  } else if (index == 2) {
                    context.pushNamed(AppRoutes.nrBankTransferPayment,
                        extra: widget.cartItems);
                  }
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(paymentMetod[index]),
                        const Icon(Icons.chevron_right)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: paymentMetod.length,
      ),
    );
  }
}
