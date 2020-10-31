class UploadDate {
  String uploadDate;

  String getTimeSinceUpload(uploadDate) {
    DateTime date = DateTime.parse(uploadDate);
    DateTime now = DateTime.now();
    int minutes = now.difference(date).inMinutes;

    int hours = now.difference(date).inHours;
    int days = now.difference(date).inDays;
    double weeks = days / 7;
    double months = weeks / 4;
    double years = days / 365;

    if (years >= 1) {
      String year = " year";
      if (years >= 2) {
        year = " years";
      }
      return years.toInt().toString() + year;
    } else if (months >= 1) {
      String month = " month";
      if (months >= 2) {
        month = " months";
      }
      return months.toInt().toString() + month;
    } else if (weeks >= 1) {
      String week = " week";
      if (weeks >= 2) {
        week = " weeks";
      }
      return weeks.toInt().toString() + week;
    } else if (days >= 1) {
      String day = " day";
      if (days >= 2) {
        day = " days";
      }
      return days.toInt().toString() + day;
    } else if (hours >= 1) {
      String hour = " hour";
      if (hours >= 2) {
        hour = " hours";
      }
      return hours.toInt().toString() + hour;
    } else if (minutes >= 1) {
      String minute = " minute";
      if (minutes >= 2) {
        minute = " minutes";
      }
      return minutes.toInt().toString() + minute;
    } else {
      return "not long";
    }
  }
}
