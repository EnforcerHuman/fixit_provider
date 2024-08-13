import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// ignore: must_be_immutable
class CustomCalendar extends StatelessWidget {
  DateTime selectedDate = DateTime.now();
  final Function(DateRangePickerSelectionChangedArgs args) onDateChanged;
  CustomCalendar({super.key, required this.onDateChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SfDateRangePicker(
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.single,
          initialSelectedDate: selectedDate,
          onSelectionChanged: onDateChanged,
          monthViewSettings: const DateRangePickerMonthViewSettings(
            firstDayOfWeek: 7, // Sunday
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
          headerStyle: const DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          monthCellStyle: const DateRangePickerMonthCellStyle(
            textStyle: TextStyle(fontSize: 14, color: Colors.black87),
            todayTextStyle: TextStyle(fontSize: 14, color: Colors.blue),
          ),
          selectionColor: Colors.blue,
          todayHighlightColor: Colors.blue,
        ),
      ),
    );
  }
}
