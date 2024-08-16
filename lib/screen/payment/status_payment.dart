import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:indie_commerce/navigation/app_routes.dart';
import 'package:indie_commerce/screen/payment/cubit/payment_cubit.dart';
import 'package:intl/intl.dart';

class StatusPayment extends StatefulWidget {
  const StatusPayment({super.key});

  @override
  State<StatusPayment> createState() => _StatusPaymentState();
}

class _StatusPaymentState extends State<StatusPayment> {
  @override
  void initState() {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    context.read<PaymentCubit>().getStatus(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Payment"),
        centerTitle: true,
      ),
      body: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          if (state is PaymentGetSuccess) {
            if (state.data.isEmpty) {
              return const Center(
                child: Text("You dont Have Any Transactions"),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  List<String> formattedDate = [];
                  for (var i = 0; i < state.data.length; i++) {
                    formattedDate.add(DateFormat("dd MMMM yyyy")
                        .format(DateTime.parse(state.data[index].date!)));
                  }
                  return Container(
                    margin: const EdgeInsets.all(10),
                    height: 150,
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoutes.nrStatusDetail,
                            extra: state.data[index]);
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(formattedDate[index]),
                                  Text(state.data[index].status)
                                ],
                              ),
                              ListTile(
                                title: Text(
                                  state.data[index].items.first["title"],
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: Image.network(
                                  state.data[index].items.first["image"],
                                  fit: BoxFit.cover,
                                ),
                                subtitle: Text(state.data[index].items.length ==
                                        1
                                    ? "1 Items"
                                    : "+${state.data[index].items.length - 1} Other Items"),
                              ),
                              const Text("Total"),
                              Text("\$${state.data[index].total}"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: state.data.length,
              );
            }
          } else if (state is PaymentGetLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PaymentGetError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
