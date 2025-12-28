enum TimeAgoType { justNow, minutes, hours, yesterday, days, weeks }

class TimeAgoResult {
  final TimeAgoType type;
  final int? value;

  const TimeAgoResult(this.type, [this.value]);
}

class TimeAgo {
  static TimeAgoResult calculate(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) {
      return const TimeAgoResult(TimeAgoType.justNow);
    } else if (diff.inMinutes < 60) {
      return TimeAgoResult(TimeAgoType.minutes, diff.inMinutes);
    } else if (diff.inHours < 24) {
      return TimeAgoResult(TimeAgoType.hours, diff.inHours);
    } else if (diff.inDays == 1) {
      return const TimeAgoResult(TimeAgoType.yesterday);
    } else if (diff.inDays < 7) {
      return TimeAgoResult(TimeAgoType.days, diff.inDays);
    } else {
      final weeks = (diff.inDays / 7).floor();
      return TimeAgoResult(TimeAgoType.weeks, weeks);
    }
  }
}
