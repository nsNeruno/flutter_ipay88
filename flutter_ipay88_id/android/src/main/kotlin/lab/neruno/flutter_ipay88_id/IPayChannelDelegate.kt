/*
package lab.neruno.flutter_ipay88_id

import com.ipay.IpayResultDelegate
import io.flutter.plugin.common.MethodChannel

class IPayChannelDelegate(private var channel : MethodChannel): IpayResultDelegate {

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
*/