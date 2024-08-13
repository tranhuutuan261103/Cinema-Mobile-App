import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/datetime_helper.dart';

class DateSelectionBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DateSelectionBottomSheet({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<DateSelectionBottomSheet> createState() =>
      _DateSelectionBottomSheetState();
}

class _DateSelectionBottomSheetState extends State<DateSelectionBottomSheet> {
  late DateTime _selectedDate;
  late final List<String> _days;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _days = List.generate(7, (index) {
      final date = DateTime.now().add(Duration(days: index));
      return DatetimeHelper.getFormattedDate(date);
    });
  }

  void _onDateSelected(int index) {
    setState(() {
      _selectedDate = DateTime.now().add(Duration(days: index));
    });
    widget.onDateSelected(_selectedDate);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: const Center(
            child: Text(
              'Chọn ngày',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListView.builder(
              itemCount: _days.length,
              itemBuilder: (context, index) {
                final date = DateTime.now().add(Duration(days: index));
                final isSelected = _selectedDate.day == date.day &&
                    _selectedDate.month == date.month &&
                    _selectedDate.year == date.year;
            
                return ListTile(
                  title: Text(_days[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      )),
                  tileColor: isSelected ? colorPrimary : null,
                  textColor: isSelected ? Colors.white : null,
                  onTap: () => _onDateSelected(index),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
