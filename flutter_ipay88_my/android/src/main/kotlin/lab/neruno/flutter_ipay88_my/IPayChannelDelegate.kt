package lab.neruno.flutter_ipay88_my

import com.ipay.IPayIHResultDelegate
import io.flutter.plugin.common.MethodChannel

class IPayChannelDelegate(private var channel : MethodChannel): IPayIHResultDelegate {
    override fun onConnectionError(
        var1: String?,
        var2: String?,
        var3: String?,
        var4: String?,
        var5: String?,
        var6: String?
    ) {}

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
}