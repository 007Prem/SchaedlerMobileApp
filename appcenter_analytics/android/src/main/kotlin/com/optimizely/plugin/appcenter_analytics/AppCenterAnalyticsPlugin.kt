package com.optimizely.plugin.appcenter_analytics

import android.app.Activity
import com.microsoft.appcenter.AppCenter
import com.microsoft.appcenter.analytics.Analytics
import com.microsoft.appcenter.crashes.Crashes
import com.microsoft.appcenter.crashes.WrapperSdkExceptionManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class AppCenterAnalyticsPlugin : FlutterPlugin, ActivityAware, AppCenterApi, AppCenterAnalyticsApi,
    AppCenterCrashesApi {
    private var mainActivity: Activity? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        AppCenterApi.setUp(binding.binaryMessenger, this)
        AppCenterAnalyticsApi.setUp(binding.binaryMessenger, this)
        AppCenterCrashesApi.setUp(binding.binaryMessenger, this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        AppCenterApi.setUp(binding.binaryMessenger, null)
        AppCenterAnalyticsApi.setUp(binding.binaryMessenger, null)
        AppCenterCrashesApi.setUp(binding.binaryMessenger, null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        mainActivity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        mainActivity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        mainActivity = binding.activity
    }

    override fun onDetachedFromActivity() {
        mainActivity = null
    }

    // App Center
    override fun start(secret: String) {
        mainActivity?.let {
            if (!AppCenter.isConfigured()) {
                AppCenter.start(it.application, secret, Analytics::class.java, Crashes::class.java)
            }
        }
    }

    override fun setUserId(userId: String) {
        AppCenter.setUserId(userId)
    }

    override fun setEnabled(enabled: Boolean, callback: (Result<Unit>) -> Unit) {
        AppCenter.setEnabled(enabled).thenAccept { callback(Result.success(Unit)) }
    }

    override fun isEnabled(callback: (Result<Boolean>) -> Unit) {
        AppCenter.isEnabled().thenAccept { value -> callback(Result.success(value)) }
    }

    override fun isConfigured(): Boolean = AppCenter.isConfigured()

    override fun getInstallId(callback: (Result<String>) -> Unit) {
        AppCenter.getInstallId().thenAccept { uuid -> callback(Result.success(uuid.toString())) }
    }

    override fun isRunningInAppCenterTestCloud(): Boolean = AppCenter.isRunningInAppCenterTestCloud()

    // App Center Analytics
    override fun trackEvent(name: String, properties: Map<String, String>?, flags: Long?) {
        if (flags != null) {
            Analytics.trackEvent(name, properties, flags.toInt())
        } else {
            Analytics.trackEvent(name, properties)
        }
    }

    override fun pause() {
        Analytics.pause()
    }

    override fun resume() {
        Analytics.resume()
    }

    override fun analyticsSetEnabled(enabled: Boolean, callback: (Result<Unit>) -> Unit) {
        Analytics.setEnabled(enabled).thenAccept { callback(Result.success(Unit)) }
    }

    override fun analyticsIsEnabled(callback: (Result<Boolean>) -> Unit) {
        Analytics.isEnabled().thenAccept { value -> callback(Result.success(value)) }
    }

    override fun enableManualSessionTracker() {
        Analytics.enableManualSessionTracker()
    }

    override fun startSession() {
        Analytics.startSession()
    }

    override fun setTransmissionInterval(seconds: Long): Boolean = Analytics.setTransmissionInterval(seconds.toInt())

    // App Center Crashes
    override fun generateTestCrash() {
        Crashes.generateTestCrash()
    }

    override fun hasReceivedMemoryWarningInLastSession(callback: (Result<Boolean>) -> Unit) {
        Crashes.hasReceivedMemoryWarningInLastSession()
            .thenAccept { value -> callback(Result.success(value)) }
    }

    override fun hasCrashedInLastSession(callback: (Result<Boolean>) -> Unit) {
        Crashes.hasCrashedInLastSession()
            .thenAccept { value -> callback(Result.success(value)) }
    }

    override fun crashesSetEnabled(enabled: Boolean, callback: (Result<Unit>) -> Unit) {
        Crashes.setEnabled(enabled).thenAccept { callback(Result.success(Unit)) }
    }

    override fun crashesIsEnabled(callback: (Result<Boolean>) -> Unit) {
        Crashes.isEnabled().thenAccept { value -> callback(Result.success(value)) }
    }

    override fun trackException(
        message: String,
        type: String?,
        stackTrace: String?,
        properties: Map<String, String>?
    ) {
        val exceptionModel = com.microsoft.appcenter.crashes.ingestion.models.Exception()
        exceptionModel.message = message
        exceptionModel.type = type
        exceptionModel.stackTrace = stackTrace
        exceptionModel.wrapperSdkName = "optimizely.flutter"
        WrapperSdkExceptionManager.trackException(exceptionModel, properties, null)
    }
    // App Center Crashes
}
