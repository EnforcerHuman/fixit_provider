import 'package:fixit_provider/common/widgets/text_editing_field.dart';
import 'package:flutter/material.dart';

Widget buildEditingFields(
  TextEditingController hourlyPaymentController,
  TextEditingController experienceController,
  TextEditingController descriptionController,
) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: [
        TextEditingField(
          keyboardType: TextInputType.number,
          label: 'Hourly Payment',
          controller: hourlyPaymentController,
          hintText: hourlyPaymentController.text,
        ),
        const SizedBox(height: 20),
        TextEditingField(
          label: 'Experience',
          controller: experienceController,
          hintText: experienceController.text,
        ),
        const SizedBox(height: 20),
        TextEditingField(
          label: 'Description',
          controller: descriptionController,
          hintText: descriptionController.text,
        ),
      ],
    ),
  );
}
