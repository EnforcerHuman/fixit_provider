import 'package:fixit_provider/common/widgets/app_bar.dart';
import 'package:fixit_provider/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class BookingAcceptanceScreen extends StatelessWidget {
  const BookingAcceptanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Expanded(
          child: Column(
        children: [
          RoundTextField(hintText: '', lefticon: Icon(Icons.macro_off))
        ],
      )),
    );
  }
}
