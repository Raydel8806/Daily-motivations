package campingstudio.motivaciones_diarias

import android.app.Notification
import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import androidx.test.platform.app.InstrumentationRegistry
import org.json.JSONObject
import org.junit.Assert.*
import org.junit.Test
import java.util.Calendar

class DailyQuoteReceiverTest {
    @Test fun deliversTheCurrentQuoteWithoutStartingTheFlutterActivity() {
        val context = InstrumentationRegistry.getInstrumentation().targetContext
        val prefs = context.getSharedPreferences("daily_quote_notifications", Context.MODE_PRIVATE)
        val previous = prefs.all.toMap()
        val manager = context.getSystemService(NotificationManager::class.java)
        val permission = "android.permission.POST_NOTIFICATIONS"
        val grantNeeded = Build.VERSION.SDK_INT >= 33 &&
            context.checkSelfPermission(permission) != PackageManager.PERMISSION_GRANTED
        if (grantNeeded) {
            InstrumentationRegistry.getInstrumentation().uiAutomation
                .grantRuntimePermission(context.packageName, permission)
        }
        try {
            prefs.edit().clear().commit()
            val quoteKey = ReminderSchedule.quoteKey(Calendar.getInstance())
            val catalogs = JSONObject().put("en", JSONObject().put(quoteKey, "Reminder integration test.\nTest author"))
            DailyQuoteNotifications.initialize(context, catalogs.toString(), "en")
            assertTrue(DailyQuoteNotifications.configure(context, true, 9, 0))
            DailyQuoteReceiver().onReceive(context, Intent(DailyQuoteNotifications.ACTION_DELIVER))
            val posted = manager.activeNotifications.first { it.id == 702 }
            assertEquals("Daily Motivations", posted.notification.extras.getString(Notification.EXTRA_TITLE))
            assertEquals("Reminder integration test.\nTest author",
                posted.notification.extras.getString(Notification.EXTRA_BIG_TEXT))
            assertNotNull(prefs.getString("last_delivery", null))
            val deliveredDate = prefs.getString("last_delivery", null)
            DailyQuoteReceiver().onReceive(context, Intent(DailyQuoteNotifications.ACTION_DELIVER))
            assertEquals(deliveredDate, prefs.getString("last_delivery", null))
            assertEquals(1, manager.activeNotifications.count { it.id == 702 })
            assertTrue(DailyQuoteNotifications.configure(context, false, 9, 0))
            assertFalse(manager.activeNotifications.any { it.id == 702 })
        } finally {
            manager.cancel(702)
            val editor = prefs.edit().clear()
            for ((key, value) in previous) {
                when (value) {
                    is String -> editor.putString(key, value)
                    is Boolean -> editor.putBoolean(key, value)
                    is Int -> editor.putInt(key, value)
                    is Long -> editor.putLong(key, value)
                    is Float -> editor.putFloat(key, value)
                }
            }
            editor.commit()
            DailyQuoteNotifications.scheduleNext(context)
        }
    }
}
