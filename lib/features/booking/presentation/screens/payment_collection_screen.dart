import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit_provider/common/widgets/app_bar.dart';
import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:fixit_provider/common/widgets/text_editing_field.dart';
import 'package:fixit_provider/features/booking/data/model/booking_model.dart';
import 'package:fixit_provider/features/booking/presentation/bloc/payment_request_bloc/payment_request_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCollectionScreen extends StatelessWidget {
  final BookingModel bookingModel;
  const PaymentCollectionScreen({super.key, required this.bookingModel});

  @override
  Widget build(BuildContext context) {
    TextEditingController workhourController = TextEditingController();
    return BlocListener<PaymentRequestBloc, PaymentRequestState>(
      listener: (context, state) {
        if (state is PaymentRequested) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Payment requested  succesfully updated'),
          ));
        }
        if (state is PaymentRequestFailed) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Payment requested Failed Try Again'),
          ));
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Expanded(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextEditingField(
                  keyboardType: TextInputType.number,
                  controller: workhourController,
                  hintText: 'Enter Total Work Hours'),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RoundButton(
                    title: 'Request To pay',
                    onPressed: () {
                      int totalAmount = int.parse(workhourController.text) *
                          int.parse(bookingModel.hourlyPayment);
                      print((workhourController.text *
                          int.parse(bookingModel.hourlyPayment)));
                      context.read<PaymentRequestBloc>().add(RequestPayment(
                          bookingModel.id, totalAmount.toString()));
                    }),
              )
            ],
          ),
        )),
      ),
    );
  }
}
