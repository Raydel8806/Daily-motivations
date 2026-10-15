package campingstudio.motivaciones_diarias

import android.app.AlarmManager
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.LocaleList
import android.util.Log
import org.json.JSONObject
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale

object DailyQuoteNotifications {
    const val CHANNEL = "daily_quotes"
    const val ACTION_DELIVER = "campingstudio.motivaciones_diarias.DAILY_QUOTE"
    const val DATE_EXTRA = "quote_notification_date"
    private const val ALARM_ID = 701
    private const val NOTIFICATION_ID = 702
    private const val PREVIEW_ID = 703
    private const val STORE = "daily_quote_notifications"

    private fun preferences(context: Context) =
        context.getSharedPreferences(STORE, Context.MODE_PRIVATE)

    fun settings(context: Context): Map<String, Any> {
        val prefs = preferences(context)
        return mapOf("enabled" to prefs.getBoolean("enabled", false),
            "hour" to prefs.getInt("hour", 9).coerceIn(0, 23),
            "minute" to prefs.getInt("minute", 0).coerceIn(0, 59))
    }

    fun initialize(context: Context, catalogs: String, manualLanguage: String?) {
        JSONObject(catalogs) // Reject malformed catalogs before changing stored data.
        val editor = preferences(context).edit().putString("catalogs", catalogs)
        if (manualLanguage in listOf("es", "en", "fr")) {
            editor.putString("manual_language", manualLanguage)
        } else {
            editor.remove("manual_language")
        }
        check(editor.commit()) { "Could not save notification data" }
        createChannel(context)
        scheduleNext(context)
    }

    fun updateLanguage(context: Context, manualLanguage: String?) {
        val editor = preferences(context).edit()
        if (manualLanguage in listOf("es", "en", "fr")) {
            editor.putString("manual_language", manualLanguage)
        } else {
            editor.remove("manual_language")
        }
        check(editor.commit()) { "Could not save notification language" }
        createChannel(context)
    }

    private fun language(context: Context): String {
        val manual = preferences(context).getString("manual_language", null)
        if (manual in listOf("es", "en", "fr")) return manual!!
        val locales = LocaleList.getDefault()
        for (index in 0 until locales.size()) {
            val language = locales[index].language
            if (language in listOf("es", "en", "fr")) return language
        }
        return "en"
    }

    private fun title(language: String) = when (language) {
        "es" -> "Motivaciones Diarias"
        "fr" -> "Motivations quotidiennes"
        else -> "Daily Motivations"
    }

    fun createChannel(context: Context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = when (language(context)) {
                "es" -> "Frases diarias"
                "fr" -> "Citations quotidiennes"
                else -> "Daily quotes"
            }
            context.getSystemService(NotificationManager::class.java)
                .createNotificationChannel(NotificationChannel(CHANNEL, name,
                    NotificationManager.IMPORTANCE_DEFAULT))
        }
    }

    fun notificationsAllowed(context: Context): Boolean {
        val manager = context.getSystemService(NotificationManager::class.java)
        if (!manager.areNotificationsEnabled()) return false
        return Build.VERSION.SDK_INT < Build.VERSION_CODES.O ||
            manager.getNotificationChannel(CHANNEL)?.importance != NotificationManager.IMPORTANCE_NONE
    }

    fun configure(context: Context, enabled: Boolean, hour: Int, minute: Int): Boolean {
        require(hour in 0..23 && minute in 0..59) { "Invalid reminder time" }
        if (enabled && !notificationsAllowed(context)) return false
        if (enabled) check(preferences(context).getString("catalogs", null) != null) {
            "Notification catalog is unavailable"
        }
        check(preferences(context).edit().putBoolean("enabled", enabled)
            .putInt("hour", hour).putInt("minute", minute).commit()) {
            "Could not save notification settings"
        }
        scheduleNext(context)
        if (!enabled) context.getSystemService(NotificationManager::class.java).cancel(NOTIFICATION_ID)
        return true
    }

    private fun alarmIntent(context: Context): PendingIntent = PendingIntent.getBroadcast(
        context, ALARM_ID,
        Intent(context, DailyQuoteReceiver::class.java).setAction(ACTION_DELIVER),
        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)

    fun scheduleNext(context: Context) {
        val manager = context.getSystemService(AlarmManager::class.java)
        val pendingIntent = alarmIntent(context)
        manager.cancel(pendingIntent)
        val settings = settings(context)
        if (settings["enabled"] != true) return
        val next = ReminderSchedule.nextOccurrence(settings["hour"] as Int, settings["minute"] as Int)
        // A single inexact alarm is renewed after delivery, using local calendar time.
        manager.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, next.timeInMillis, pendingIntent)
    }

    fun showToday(context: Context, preview: Boolean = false): Boolean {
        if (!notificationsAllowed(context)) return false
        val prefs = preferences(context)
        val now = Calendar.getInstance()
        val isoDate = SimpleDateFormat("yyyy-MM-dd", Locale.US).format(now.time)
        if (!preview && prefs.getString("last_delivery", null) == isoDate) return true
        val language = language(context)
        val dayKey = ReminderSchedule.quoteKey(now)
        val encoded = prefs.getString("catalogs", null) ?: return false
        val text = JSONObject(encoded).optJSONObject(language)?.optString(dayKey).orEmpty()
        if (text.isEmpty()) return false
        createChannel(context)
        val intent = Intent(context, MainActivity::class.java)
            .putExtra(DATE_EXTRA, isoDate)
            .addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP)
        val notificationId = if (preview) PREVIEW_ID else NOTIFICATION_ID
        val contentIntent = PendingIntent.getActivity(context, notificationId, intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val builder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Notification.Builder(context, CHANNEL)
        } else {
            @Suppress("DEPRECATION")
            Notification.Builder(context)
        }
        builder.setSmallIcon(R.drawable.ic_stat_quote)
            .setContentTitle(title(language)).setContentText(text)
            .setStyle(Notification.BigTextStyle().bigText(text))
            .setSubText(SimpleDateFormat("d MMMM", Locale(language)).format(now.time))
            .setCategory(Notification.CATEGORY_REMINDER)
            .setAutoCancel(true).setContentIntent(contentIntent)
        context.getSystemService(NotificationManager::class.java).notify(notificationId, builder.build())
        if (!preview) prefs.edit().putString("last_delivery", isoDate).apply()
        return true
    }
}

class DailyQuoteReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        try {
            if (intent.action == DailyQuoteNotifications.ACTION_DELIVER &&
                DailyQuoteNotifications.settings(context)["enabled"] == true) {
                DailyQuoteNotifications.showToday(context)
            }
        } catch (error: Exception) {
            Log.w("DailyQuotes", "Could not display the daily quote", error)
        } finally {
            try {
                DailyQuoteNotifications.scheduleNext(context)
            } catch (error: Exception) {
                Log.w("DailyQuotes", "Could not reschedule the daily quote", error)
            }
        }
    }
}
