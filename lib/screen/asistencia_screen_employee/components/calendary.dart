import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarSectionAssistant extends StatefulWidget {
  const CalendarSectionAssistant({super.key});

  @override
  State<CalendarSectionAssistant> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSectionAssistant> {
  DateTime currentDate = DateTime.now();
  DateTime? selectedDate;

  List<String> weekDays = ['Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab', 'Dom'];

  @override
  Widget build(BuildContext context) {
    final String monthYear = DateFormat.yMMMM('es_ES').format(currentDate);
    final List<List<int>> daysMatrix = _generateCalendarDays(currentDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          monthYear[0].toUpperCase() + monthYear.substring(1),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left, size: 20),
                            onPressed: () {
                              setState(() {
                                currentDate = DateTime(
                                  currentDate.year,
                                  currentDate.month - 1,
                                );
                                selectedDate = null;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right, size: 20),
                            onPressed: () {
                              setState(() {
                                currentDate = DateTime(
                                  currentDate.year,
                                  currentDate.month + 1,
                                );
                                selectedDate = null;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Table(
                    defaultColumnWidth: const FlexColumnWidth(),
                    children: [
                      TableRow(
                        children: weekDays
                            .map(
                              (day) => Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  day,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      ...daysMatrix.map(
                        (week) => TableRow(
                          children: week
                              .map(
                                (day) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: day > 0
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedDate = DateTime(
                                                currentDate.year,
                                                currentDate.month,
                                                day,
                                              );
                                            });
                                          },
                                          child: Container(
                                            decoration: selectedDate != null &&
                                                    selectedDate!.year ==
                                                        currentDate.year &&
                                                    selectedDate!.month ==
                                                        currentDate.month &&
                                                    selectedDate!.day == day
                                                ? const BoxDecoration(
                                                    color: Colors.orange,
                                                    shape: BoxShape.circle,
                                                  )
                                                : null,
                                            alignment: Alignment.center,
                                            width: 32,
                                            height: 32,
                                            child: Text(
                                              '$day',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: selectedDate != null &&
                                                        selectedDate!.year ==
                                                            currentDate.year &&
                                                        selectedDate!.month ==
                                                            currentDate.month &&
                                                        selectedDate!.day == day
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<List<int>> _generateCalendarDays(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    int startWeekDay = firstDayOfMonth.weekday % 7;
    int totalDays = lastDayOfMonth.day;

    List<List<int>> weeks = [];
    List<int> week = List.filled(7, 0);
    int dayCounter = 1;

    for (int i = startWeekDay; i < 7; i++) {
      week[i] = dayCounter++;
    }
    weeks.add(List.from(week));

    while (dayCounter <= totalDays) {
      week = List.filled(7, 0);
      for (int i = 0; i < 7 && dayCounter <= totalDays; i++) {
        week[i] = dayCounter++;
      }
      weeks.add(List.from(week));
    }

    return weeks;
  }
}
