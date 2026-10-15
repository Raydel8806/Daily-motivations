package campingstudio.motivaciones_diarias

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings

class MainActivity: FlutterActivity() {
    private var reminderChannel: MethodChannel? = null
    private var permissionResult: MethodChannel.Result? = null
    private val notificationPermissionRequest = 704

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        reminderChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger,
            "daily_motivations/reminders").also { channel ->
            channel.setMethodCallHandler { call, result ->
                try {
                    when (call.method) {
                        "initialize" -> {
                            DailyQuoteNotifications.initialize(this,
                                call.argument<String>("catalogs") ?: error("Missing catalogs"),
                                call.argument<String>("manualLanguage"))
                            result.success(null)
                        }
                        "updateLanguage" -> {
                            DailyQuoteNotifications.updateLanguage(this, call.argument<String>("manualLanguage"))
                            result.success(null)
                        }
                        "settings" -> result.success(DailyQuoteNotifications.settings(this))
                        "configure" -> result.success(DailyQuoteNotifications.configure(this,
                            call.argument<Boolean>("enabled") == true,
                            call.argument<Int>("hour") ?: 9, call.argument<Int>("minute") ?: 0))
                        "preview" -> result.success(DailyQuoteNotifications.showToday(this, true))
                        "requestPermission" -> {
                            if (Build.VERSION.SDK_INT >= 33 &&
                                checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) {
                                if (permissionResult != null) {
                                    result.error("busy", "A permission request is already pending", null)
                                } else {
                                    permissionResult = result
                                    requestPermissions(arrayOf(Manifest.permission.POST_NOTIFICATIONS), notificationPermissionRequest)
                                }
                            } else {
                                result.success(DailyQuoteNotifications.notificationsAllowed(this))
                            }
                        }
                        "openSystemSettings" -> {
                            startActivity(Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS)
                                .putExtra(Settings.EXTRA_APP_PACKAGE, packageName))
                            result.success(null)
                        }
                        "consumeOpenedDate" -> {
                            val date = intent.getStringExtra(DailyQuoteNotifications.DATE_EXTRA)
                            intent.removeExtra(DailyQuoteNotifications.DATE_EXTRA)
                            result.success(date)
                        }
                        else -> result.notImplemented()
                    }
                } catch (error: Exception) {
                    result.error("notification_error", error.message, null)
                }
            }
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == notificationPermissionRequest) {
            permissionResult?.success(DailyQuoteNotifications.notificationsAllowed(this))
            permissionResult = null
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        val date = intent.getStringExtra(DailyQuoteNotifications.DATE_EXTRA)
        if (date != null) {
            intent.removeExtra(DailyQuoteNotifications.DATE_EXTRA)
            reminderChannel?.invokeMethod("notificationOpened", date)
        }
    }
}
