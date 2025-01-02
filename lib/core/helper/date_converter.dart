import 'package:intl/intl.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static Duration getTimezoneOffset(String timezone) {
    DateTime now = DateTime.now();
    Duration offset = now.timeZoneOffset;
    if (timezone == "UTC") {
      return const Duration(hours: 0);
    } else {
      return offset;
    }
  }

  static String formatValidityDate(String dateString) {
    var inputDate = DateFormat('yyyy-MM-dd hh:mm:ss').parse(dateString);
    var outputFormat = DateFormat('dd MMM yyyy').format(inputDate);
    return outputFormat;
  }

  static String formatDepositTimeWithAmFormat(String dateString) {
    var newStr = '${dateString.substring(0, 10)} ${dateString.substring(11, 23)}';
    DateTime dt = DateTime.parse(newStr);
    String formatedDate = DateFormat("yyyy-MM-dd").format(dt);

    return formatedDate;
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime, {String? timeZone}) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(dateTime).toUtc().add(getTimezoneOffset(timeZone ?? 'UTC'));
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('hh:mm aa').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String gameDate(String dateTime) {
    try {
      DateTime d = DateTime.parse(dateTime);
      String formattedDate = DateFormat("d MMM yyyy").format(d);
      printx(formattedDate);
      return formattedDate;
    } catch (e) {
      return dateTime;
    }
  }

  static String localDateTime(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime.toUtc());
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime.toUtc());
  }

  static String convertTimeToTime(String time) {
    return DateFormat('hh:mm a').format(DateFormat('hh:mm:ss').parse(time));
  }

  static bool isDateOver(String time) {
    try {
      DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
      DateTime givenDate = format.parse(time);
      DateTime currentTime = DateTime.now();

      return givenDate.isBefore(currentTime);
    } catch (e) {
      return true;
    }
  }

  static String getFormateSubtractTime(
    String time, {
    bool numericDates = false,
    String timeZone = 'UTC',
  }) {
    // Given date
    DateTime givenDate = convertStringToDatetime(time, timeZone: timeZone);

    // Current date in the given timezone
    DateTime currentDate = DateTime.now().toUtc().add(getTimezoneOffset(timeZone));

    // Calculate the difference
    Duration difference = givenDate.difference(currentDate);

    // Format the difference in a human-readable format
    String formattedDuration = formatDuration(difference.abs());

    printx('Given date: ${DateFormat('dd-MM-yyyy HH:mm:ss').format(givenDate)}');
    return '$formattedDuration From now';
  }

  static String getFormatedSubtractTime(String time, {bool numericDates = false}) {
    final date1 = DateTime.now();
    final isoDate = isoStringToLocalDate(time);
    final difference = date1.difference(isoDate);

    if ((difference.inDays / 365).floor() >= 1) {
      int year = (difference.inDays / 365).floor();
      return '$year year ago';
    } else if ((difference.inDays / 30).floor() >= 1) {
      int month = (difference.inDays / 30).floor();
      return '$month month ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      int week = (difference.inDays / 7).floor();
      return '$week week ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  static String formatDuration(Duration duration) {
    if (duration.inDays >= 30) {
      int months = (duration.inDays / 30).floor();
      return '$months month${months != 1 ? 's' : ''}';
    } else if (duration.inDays >= 7) {
      int weeks = (duration.inDays / 7).floor();
      return '$weeks week${weeks != 1 ? 's' : ''}';
    } else if (duration.inDays > 0) {
      return '${duration.inDays} day${duration.inDays != 1 ? 's' : ''}';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} hour${duration.inHours != 1 ? 's' : ''}';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} minute${duration.inMinutes != 1 ? 's' : ''}';
    } else {
      return '${duration.inSeconds} second${duration.inSeconds != 1 ? 's' : ''}';
    }
  }
}
