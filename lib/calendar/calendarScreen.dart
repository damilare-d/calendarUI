import 'package:countappwithbloc/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DApp());
}

class DApp extends StatelessWidget {
  const DApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalendarScreen(),
    );
  }
}

bool onTapCalendarDate = false;

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  int currentMonthIndex = DateTime.march;

  String selectedMonth = 'March';
  bool onTapCalendarDate = false;

  final DateTime _selectedDate = DateTime.now();
  List<String> weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  List<TableRow> _buildCalendarDays() {
    List<TableRow> rows = [];
    List<DateTime> days = [];
    //now to determine the rows
    DateTime firstDayOfMonth =
        DateTime(_selectedDate.year, currentMonthIndex, 1);
    DateTime lastDayOfMonth =
        DateTime(_selectedDate.year, currentMonthIndex + 1, 0);

    print("Last Day of the Month: $lastDayOfMonth");
    int daysInMonth = lastDayOfMonth.day;
    int dayOfWeek = firstDayOfMonth.weekday;

    int day = 1;

    int rowCount = (lastDayOfMonth.day / 7).ceil() + 1;
    for (int i = 0; i < rowCount; i++) {
      List<Widget> weekDays = List.filled(7, Container());
      for (int j = 0; j < 7; j++) {
        if (day > lastDayOfMonth.day) {
          break;
        } else if (i == 0 && j < firstDayOfMonth.weekday) {
          weekDays[j] = Container();
        } else if (i == (rowCount - 1) && j > lastDayOfMonth.weekday) {
          weekDays[j] = Container();
        } else {
          weekDays[j] = DayBox(
            day: day,
            currentMonthIndex: currentMonthIndex,
            onTap: (day) =>
                print(DateTime(_selectedDate.year, currentMonthIndex, day)),
          );

          day++;
        }
      }
      rows.add(TableRow(children: weekDays));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 44,
            ),
            const Text(
              'Calendar',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'DM Sans'),
            ),
            const SizedBox(
              height: 21,
            ),
            const Text(
              'My Class Schedules',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'DM Sans'),
            ),
            const SizedBox(
              height: 31,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PopupMenuButton<String>(
                    color: const Color(0xff7D3EE4),
                    initialValue: selectedMonth,
                    onSelected: (value) {
                      setState(() {
                        selectedMonth = value;
                        currentMonthIndex = months.indexOf(selectedMonth) + 1;
                        print(currentMonthIndex);
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return months
                          .map((month) => PopupMenuItem<String>(
                                value: month,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        month,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_drop_down,
                                        size: 7.5,
                                        color: Color(0xffffffff),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList();
                    },
                    child: Container(
                      height: 31,
                      width: 356,
                      decoration: BoxDecoration(
                        color: const Color(0xff7D3EE4),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              selectedMonth,
                              style: const TextStyle(
                                  fontFamily: 'DM Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffffffff)),
                            ),
                            const Icon(
                              Icons.arrow_drop_up,
                              color: Color(0xffffffff),
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Table(
                    children: [
                      TableRow(
                          children: List.generate(
                        7,
                        (index) => Center(
                          child: Text(
                            weekDays[index],
                            style: const TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )),
                      ..._buildCalendarDays(),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DayBox extends StatefulWidget {
  const DayBox({
    super.key,
    required this.day,
    required this.currentMonthIndex,
    required this.onTap,
  });

  final int day;
  final int currentMonthIndex;
  final void Function(int day) onTap;

  @override
  State<DayBox> createState() => _DayBoxState();
}

class _DayBoxState extends State<DayBox> {
  bool onTapCalendarDate = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (_) {
          setState(() {
            onTapCalendarDate = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            onTapCalendarDate = false;
          });
        },
        onTapCancel: () {
          setState(() {
            onTapCalendarDate = false;
          });
        },
        onTap: () {
          widget.onTap(widget.day);
          setState(() {
            onTapCalendarDate == true;
          });
          print(widget.day);
          print(DateTime(
              DateTime.now().year, widget.currentMonthIndex, widget.day));
        },
        child: Container(
            height: 45,
            width: 37,
            decoration: BoxDecoration(
              color: onTapCalendarDate ? const Color(0xff7D3EE4) : null,
              borderRadius: onTapCalendarDate ? BorderRadius.circular(6) : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  widget.day.toString(),
                  style: TextStyle(
                    color: onTapCalendarDate ? Color(0xffffffff) : Colors.black,
                  ),
                ),
                if (onTapCalendarDate == true)
                  Row(
                    children: [
                      Container(
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  )
              ],
            )));
  }
}
