// convert DateTime object to String yyymmdd
String convertDateTimeToString(DateTime dateTime) {
  // year in format --> yyy
  String year = dateTime.year.toString();

  // month in the format --> mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    // appending 0 with month, example 2 becomes 02
    month = '0' + month;
  }

  // day in the format --> dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0' + day;
  }

  // final format --> yyymmdd
  String yyymmdd = year + month + day;

  return yyymmdd;
}
