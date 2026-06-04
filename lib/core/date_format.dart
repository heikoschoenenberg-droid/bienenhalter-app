String formatDate(DateTime? date) {
  if (date == null) {
    return 'Noch keine Kontrolle';
  }

  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day.$month.${date.year}';
}

String formatDateTime(DateTime date) {
  return '${formatDate(date)} um ${formatTime(date)} Uhr';
}

String formatTime(DateTime date) {
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

String formatDueDate(DateTime date, DateTime? time) {
  if (time == null) {
    return formatDate(date);
  }

  return '${formatDate(date)} um ${formatTime(time)} Uhr';
}
