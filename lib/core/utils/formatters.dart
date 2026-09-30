class Formatters {
  Formatters._();

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  /// 1250000 -> "Rp 1.250.000"
  static String rupiah(num value) {
    final digits = value.round().toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      final remaining = digits.length - i;
      if (remaining > 1 && remaining % 3 == 1) buffer.write('.');
    }
    return 'Rp $buffer';
  }

  /// DateTime(2023, 1, 12) -> "12 Jan 2023"
  static String date(DateTime d) => '${d.day} ${_months[d.month - 1]} ${d.year}';


    /// Waktu relatif: "Just now", "5m ago", "3h ago", "2d ago", lalu tanggal
  static String timeAgo(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return date(d);
  }
}