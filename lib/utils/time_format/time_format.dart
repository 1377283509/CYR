enum TimeFormatType {
  YEAR_MONTH_DAY,
  MONTH_DAY_HOUR_MINUTE,
  YEAR_MONTH_DAY_DOUR_MINUTE
}

String formatTime(DateTime time, {TimeFormatType format}) {
  String s;
  try {
    int year = time.year;
    int month = time.month;
    int day = time.day;
    int hour = time.hour;
    int minute = time.minute;
    TimeFormatType type = format??TimeFormatType.YEAR_MONTH_DAY_DOUR_MINUTE;
    switch (type) {
      case TimeFormatType.YEAR_MONTH_DAY: {
        s = "$year-$month-$day";
        break;
      }
      case TimeFormatType.MONTH_DAY_HOUR_MINUTE: {
        s = "$month月$day日  $hour:$minute";
        break;
      }
      case TimeFormatType.YEAR_MONTH_DAY_DOUR_MINUTE: {
        s = "$year-${month<10?"0":""}$month-${day<10?"0":""}$day  ${hour<10?"0":""}$hour:${minute<10?"0":""}$minute";
        break;
      }
    }
  } catch (e) {
    s = "暂无";
  }
  return s;
}

int calculateTime(DateTime start, DateTime end) {
  if(start == null || end == null){
    return -1;
  }
  Duration diff = start.difference(end);
  int minutes = diff.inMinutes;
  return minutes.abs();
}

int calculateAge(DateTime birth){
  int age = 0;
  DateTime dateTime = DateTime.now();
  int yearNow = dateTime.year;  //当前年份
  int monthNow = dateTime.month;  //当前月份
  int dayOfMonthNow = dateTime.day; //当前日期

  int yearBirth = birth.year;
  int monthBirth = birth.month;
  int dayOfMonthBirth = birth.day;
  age = yearNow - yearBirth;   //计算整岁数
  if (monthNow <= monthBirth) {
    if (monthNow == monthBirth) {
      if (dayOfMonthNow < dayOfMonthBirth) age--;//当前日期在生日之前，年龄减一
    } else {
      age--;//当前月份在生日之前，年龄减一
    }
  }
  return age;
}
