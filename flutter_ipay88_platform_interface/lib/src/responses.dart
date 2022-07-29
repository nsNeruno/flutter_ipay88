class CheckoutResponse {

  CheckoutResponse(Map<String, dynamic> data,)
      : refNo = data['RefNo'],
        signature = data['Signature'],
        virtualAccountAssigned = data['VirtualAccountAssigned'],
        transactionExpiryDate = data['TransactionExpiryDate'],
        checkoutId = data['CheckoutID'],
        code = data['Code'],
        message = data['Message'];

  final String? refNo;
  final String? signature;
  final String? virtualAccountAssigned;
  final String? transactionExpiryDate;
  final String? checkoutId;
  final String? code;
  final String? message;

  bool get isPaymentRequestReceived => code == "1";
  bool get isFailed => code == "0";
}