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
        handlePaymentRequestResult(context, state);
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
                      // print((workhourController.text *
                      //     int.parse(bookingModel.hourlyPayment)));
                      // context.read<PaymentRequestBloc>().add(RequestPayment(
                      //     bookingModel.id, totalAmount.toString()));
                      _showWarningDialog(
                          context,
                          totalAmount,
                          bookingModel.hourlyPayment,
                          bookingModel.id,
                          workhourController.text);
                    }),
              )
            ],
          ),
        )),
      ),
    );
  }
}

void handlePaymentRequestResult(
    BuildContext context, PaymentRequestState state) {
  if (state is PaymentRequested) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Payment requested successfully updated'),
    ));
  } else if (state is PaymentRequestFailed) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Payment request failed. Try again'),
    ));
  }
}

void _showWarningDialog(BuildContext context, int totalAmount, String hourlypay,
    String id, String workHours) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmation'),
        // content: Text('Total Work Hours: $workHours /n '),
        actions: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Work hours : $workHours'),
              const SizedBox(
                height: 10,
              ),
              Text('Hourly payment : $hourlypay'),
              const SizedBox(
                height: 10,
              ),
              Text('Total Amount : $totalAmount'),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<PaymentRequestBloc>()
                          .add(RequestPayment(id, totalAmount.toString()));
                      Navigator.pop(context);
                    },
                    child: const Text('Request'),
                  ),
                ],
              )
            ],
          ),
        ],
      );
    },
  );
}
