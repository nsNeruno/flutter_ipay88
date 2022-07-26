package lab.neruno.flutter_ipay88_my

import android.app.Activity
import androidx.annotation.NonNull
import com.ipay.IPayIH
import com.ipay.IPayIHPayment
import com.ipay.IPayIHR
import com.ipay.IPayIHResultDelegate

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterIpay88MyPlugin */
class FlutterIpay88MyPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, IPayIHResultDelegate {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "my.lab.neruno.ipay88/platform")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "checkout" -> {
        result.success(null)
        activity?.let { a ->
          IPayIHPayment().apply {
            merchantCode = call.argument<String>("merchantCode") ?: ""
            paymentId = call.argument<String>("paymentId") ?: ""
            refNo = call.argument<String>("refNo") ?: ""
            amount = call.argument<String>("amount") ?: "1.00"
            currency = call.argument<String>("currency") ?: "MYR"
            prodDesc = call.argument<String>("prodDesc") ?: ""
            userName = call.argument<String>("userName") ?: ""
            userEmail = call.argument<String>("userEmail") ?: ""
            actionType = call.argument<String>("actionType")
            remark = call.argument<String>("remark")
            lang = call.argument<String>("lang")
            country = call.argument<String>("country") ?: "MY"
            backendPostURL = call.argument<String>("backendPostURL") ?: ""
            appdeeplink = call.argument<String>("appDeepLink")
          }.let {
            val intent = IPayIH.getInstance().checkout(it, a, this, IPayIH.PAY_METHOD_CREDIT_CARD)
            a.startActivityForResult(intent, 1)
          }
        }
      }
      "requery" -> {
        result.success(null)
        activity?.let { a ->
          IPayIHR().apply {
            merchantCode = call.argument<String>("merchantCode") ?: ""
            amount = call.argument<String>("amount") ?: "1.00"
            refNo = call.argument<String>("refNo") ?: ""
            country_Code = call.argument<String>("countryCode") ?: "MY"
          }.let {
            val intent = IPayIH().requery(it, a, this)
            a.startActivityForResult(intent, 2)
          }
        }
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onPaymentSucceeded(transId: String?, refNo: String?, amount: String?, remark: String?, authCode: String?) {
    channel.invokeMethod(
      "onPaymentSucceeded",
      mapOf(
        "transId" to transId,
        "refNo" to refNo,
        "amount" to amount,
        "authCode" to authCode,
      )
    )
  }

  override fun onPaymentFailed(transId: String?, refNo: String?, amount: String?, remark: String?, errDesc: String?) {
    channel.invokeMethod(
      "onPaymentFailed",
      mapOf(
        "transId" to transId,
        "refNo" to refNo,
        "amount" to amount,
        "errDesc" to errDesc,
      )
    )
  }

  override fun onPaymentCanceled(transId: String?, refNo: String?, amount: String?, remark: String?, errDesc: String?) {
    channel.invokeMethod(
      "onPaymentCanceled",
      mapOf(
        "transId" to transId,
        "refNo" to refNo,
        "amount" to amount,
        "errDesc" to errDesc,
      )
    )
  }

  override fun onRequeryResult(merchantCode: String?, refNo: String?, amount: String?, result: String?) {
    channel.invokeMethod(
      "onRequeryResult",
      mapOf(
        "merchantCode" to merchantCode,
        "refNo" to refNo,
        "amount" to amount,
        "result" to result,
      )
    )
  }

  /**
   * This `ActivityAware` [io.flutter.embedding.engine.plugins.FlutterPlugin] is now
   * associated with an [android.app.Activity].
   *
   *
   * This method can be invoked in 1 of 2 situations:
   *
   *
   *  * This `ActivityAware` [io.flutter.embedding.engine.plugins.FlutterPlugin] was
   * just added to a [io.flutter.embedding.engine.FlutterEngine] that was already
   * connected to a running [android.app.Activity].
   *  * This `ActivityAware` [io.flutter.embedding.engine.plugins.FlutterPlugin] was
   * already added to a [io.flutter.embedding.engine.FlutterEngine] and that [       ] was just connected to an [       ].
   *
   *
   * The given [ActivityPluginBinding] contains [android.app.Activity]-related
   * references that an `ActivityAware` [ ] may require, such as a reference to the
   * actual [android.app.Activity] in question. The [ActivityPluginBinding] may be
   * referenced until either [.onDetachedFromActivityForConfigChanges] or [ ][.onDetachedFromActivity] is invoked. At the conclusion of either of those methods, the
   * binding is no longer valid. Clear any references to the binding or its resources, and do not
   * invoke any further methods on the binding or its resources.
   */
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  /**
   * The [android.app.Activity] that was attached and made available in [ ][.onAttachedToActivity] has been detached from this `ActivityAware`'s [io.flutter.embedding.engine.FlutterEngine] for the purpose of
   * processing a configuration change.
   *
   *
   * By the end of this method, the [android.app.Activity] that was made available in
   * [.onAttachedToActivity] is no longer valid. Any references to the
   * associated [android.app.Activity] or [ActivityPluginBinding] should be cleared.
   *
   *
   * This method should be quickly followed by [ ][.onReattachedToActivityForConfigChanges], which signifies that a new
   * [android.app.Activity] has been created with the new configuration options. That method
   * provides a new [ActivityPluginBinding], which references the newly created and associated
   * [android.app.Activity].
   *
   *
   * Any `Lifecycle` listeners that were registered in [ ][.onAttachedToActivity] should be deregistered here to avoid a possible
   * memory leak and other side effects.
   */
  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  /**
   * This plugin and its [io.flutter.embedding.engine.FlutterEngine] have been re-attached to
   * an [android.app.Activity] after the [android.app.Activity] was recreated to handle
   * configuration changes.
   *
   *
   * `binding` includes a reference to the new instance of the [ ]. `binding` and its references may be cached and used from now until
   * either [.onDetachedFromActivityForConfigChanges] or [.onDetachedFromActivity]
   * is invoked. At the conclusion of either of those methods, the binding is no longer valid. Clear
   * any references to the binding or its resources, and do not invoke any further methods on the
   * binding or its resources.
   */
  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  /**
   * This plugin has been detached from an [android.app.Activity].
   *
   *
   * Detachment can occur for a number of reasons.
   *
   *
   *  * The app is no longer visible and the [android.app.Activity] instance has been
   * destroyed.
   *  * The [io.flutter.embedding.engine.FlutterEngine] that this plugin is connected to
   * has been detached from its [io.flutter.embedding.android.FlutterView].
   *  * This `ActivityAware` plugin has been removed from its [       ].
   *
   *
   * By the end of this method, the [android.app.Activity] that was made available in [ ][.onAttachedToActivity] is no longer valid. Any references to the
   * associated [android.app.Activity] or [ActivityPluginBinding] should be cleared.
   *
   *
   * Any `Lifecycle` listeners that were registered in [ ][.onAttachedToActivity] or [ ][.onReattachedToActivityForConfigChanges] should be deregistered here to
   * avoid a possible memory leak and other side effects.
   */
  override fun onDetachedFromActivity() {
    activity = null
  }
}
