class ReminderSettings {
  const ReminderSettings(
      {this.enabled = false, this.hour = 9, this.minute = 0});
  final bool enabled;
  final int hour;
  final int minute;

  factory ReminderSettings.fromMap(Map<Object?, Object?> data) {
    final hour = data['hour'];
    final minute = data['minute'];
    return ReminderSettings(
      enabled: data['enabled'] == true,
      hour: hour is int && hour >= 0 && hour < 24 ? hour : 9,
      minute: minute is int && minute >= 0 && minute < 60 ? minute : 0,
    );
  }

  Map<String, Object> toMap() =>
      {'enabled': enabled, 'hour': hour, 'minute': minute};
}
