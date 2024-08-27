import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';

class Calender extends StatelessWidget {
  final Function(DateTime) onSelected;
  const Calender({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return CalendarAgenda(
      padding: 30,
      dateColor: Colors.blue,
      backgroundColor: Colors.white.withOpacity(0.3),
      // controller: calendarAgendaControllerAppBar,
      appbar: true,
      selectedDayPosition: SelectedDayPosition.left,

      weekDay: WeekDay.long,
      fullCalendarScroll: FullCalendarScroll.horizontal,
      fullCalendarDay: WeekDay.long,
      selectedDateColor: Colors.green.shade900,
      locale: 'en',
      initialDate: DateTime.now(),
      calendarEventColor: Colors.green,
      firstDate: DateTime.now().subtract(const Duration(days: 140)),
      lastDate: DateTime.now().add(const Duration(days: 60)),
      onDateSelected: onSelected,
    );
  }
}
