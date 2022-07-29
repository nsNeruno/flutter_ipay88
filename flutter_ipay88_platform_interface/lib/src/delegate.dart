abstract class IPayResultDelegate {

  void onPaymentSucceeded(String? transId, String? refNo, String? amount, String? remark, String? authCode,);

  void onPaymentFailed(String? transId, String? refNo, String? amount, String? remark, String? errDesc,);

  void onPaymentCanceled(String? transId, String? refNo, String? amount, String? remark, String? errDesc,);

  void onRequeryResult(String? merchantCode, String? refNo, String? amount, String? result, String? errDesc,);
}