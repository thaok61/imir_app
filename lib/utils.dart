double valueFromPercentageInRange(
    {required final double min, max, percentage}) {
  return percentage * (max - min) + min;
}

double percentageFromValueInRange({required final double min, max, value}) {
  return (value - min) / (max - min);
}

String convertSecondsToString(int seconds) {
  int minute = (seconds / 60).toInt();
  int second = seconds % 60;
  String strMinute = minute < 10 ? '0$minute' : '$minute';
  String strSecond = second < 10 ? '0$second' : '$second';
  return '$strMinute:$strSecond';
}
