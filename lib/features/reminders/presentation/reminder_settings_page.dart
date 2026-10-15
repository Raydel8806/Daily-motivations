import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../data/daily_reminder_service.dart';
import '../models/reminder_settings.dart';

class ReminderSettingsPage extends StatefulWidget {
  const ReminderSettingsPage({Key? key, required this.service})
      : super(key: key);
  final DailyReminderService service;

  @override
  State<ReminderSettingsPage> createState() => _ReminderSettingsPageState();
}

class _ReminderSettingsPageState extends State<ReminderSettingsPage> {
  ReminderSettings _settings = const ReminderSettings();
  bool _loading = true;
  bool _loadFailed = false;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _loadFailed = false;
    });
    try {
      _settings = await widget.service.load();
    } catch (_) {
      _loadFailed = true;
    }
    if (mounted) setState(() => _loading = false);
  }

  void _message(String text) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    }
  }

  Future<void> _save(ReminderSettings next) async {
    setState(() => _busy = true);
    try {
      if (next.enabled && !await widget.service.requestPermission()) {
        if (mounted) {
          _message(AppStrings.of(context).notificationPermissionDenied);
        }
      } else if (await widget.service.save(next)) {
        if (mounted) setState(() => _settings = next);
      } else if (mounted) {
        _message(AppStrings.of(context).notificationPermissionDenied);
      }
    } catch (_) {
      if (mounted) _message(AppStrings.of(context).reminderError);
    }
    if (mounted) setState(() => _busy = false);
  }

  Future<void> _preview() async {
    setState(() => _busy = true);
    try {
      if (!await widget.service.requestPermission() ||
          !await widget.service.preview()) {
        if (mounted) {
          _message(AppStrings.of(context).notificationPermissionDenied);
        }
      }
    } catch (_) {
      if (mounted) _message(AppStrings.of(context).reminderError);
    }
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.dailyReminder)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _loadFailed
              ? Center(
                  child:
                      TextButton(onPressed: _load, child: Text(strings.retry)))
              : ListView(
                  children: [
                    SwitchListTile(
                      title: Text(strings.dailyReminder),
                      subtitle: Text(strings.reminderDescription),
                      value: _settings.enabled,
                      onChanged: _busy
                          ? null
                          : (enabled) => _save(ReminderSettings(
                              enabled: enabled,
                              hour: _settings.hour,
                              minute: _settings.minute)),
                    ),
                    ListTile(
                      title: Text(strings.reminderTime),
                      trailing: Text(TimeOfDay(
                              hour: _settings.hour, minute: _settings.minute)
                          .format(context)),
                      onTap: _busy
                          ? null
                          : () async {
                              final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(
                                      hour: _settings.hour,
                                      minute: _settings.minute));
                              if (time != null && mounted) {
                                await _save(ReminderSettings(
                                    enabled: _settings.enabled,
                                    hour: time.hour,
                                    minute: time.minute));
                              }
                            },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(strings.reminderTimingNote),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: OutlinedButton.icon(
                        onPressed: _busy ? null : _preview,
                        icon: const Icon(Icons.notifications_active_outlined),
                        label: Text(strings.testNotification),
                      ),
                    ),
                    TextButton(
                      onPressed: _busy
                          ? null
                          : () async {
                              try {
                                await widget.service.openSystemSettings();
                              } catch (_) {
                                if (mounted) _message(strings.reminderError);
                              }
                            },
                      child: Text(strings.systemNotificationSettings),
                    ),
                  ],
                ),
    );
  }
}
