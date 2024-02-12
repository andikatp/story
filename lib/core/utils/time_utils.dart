class TimeUtils {
  const TimeUtils._();

  static String formatTimeDifference(String createdAt) {
    final parsedCreatedAt = DateTime.parse(createdAt);
    final now = DateTime.now();
    final difference = now.difference(parsedCreatedAt);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes <= 1) {
          return 'Just now';
        } else {
          return '${difference.inMinutes} minutes ago';
        }
      } else {
        return '${difference.inHours} hours ago';
      }
    } else if (difference.inDays == 1) {
      return '1 day ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}
