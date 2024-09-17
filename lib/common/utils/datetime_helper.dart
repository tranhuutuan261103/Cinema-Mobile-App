class DatetimeHelper {
  static String getFormattedDate(DateTime date) {
    String weekDay = '';
    switch (date.weekday) {
      case 1:
        weekDay = 'Thứ 2';
        break;
      case 2:
        weekDay = 'Thứ 3';
        break;
      case 3:
        weekDay = 'Thứ 4';
        break;
      case 4:
        weekDay = 'Thứ 5';
        break;
      case 5:
        weekDay = 'Thứ 6';
        break;
      case 6:
        weekDay = 'Thứ 7';
        break;
      case 7:
        weekDay = 'Chủ nhật';
        break;
    }

    if (date.day == DateTime.now().day) {
      weekDay = 'Hôm nay';
    }

    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}  $weekDay';
  }

  static String getFormattedWeekDay(int day) {
    String weekDay = '';
    switch (day) {
      case 1:
        weekDay = 'Thứ 2';
        break;
      case 2:
        weekDay = 'Thứ 3';
        break;
      case 3:
        weekDay = 'Thứ 4';
        break;
      case 4:
        weekDay = 'Thứ 5';
        break;
      case 5:
        weekDay = 'Thứ 6';
        break;
      case 6:
        weekDay = 'Thứ 7';
        break;
      case 7:
        weekDay = 'C.Nhật';
        break;
    }

    if (day == DateTime.now().weekday) {
      weekDay = 'H.nay';
    }

    return weekDay;
  }
}