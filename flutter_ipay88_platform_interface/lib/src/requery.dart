class IPayRequery {

  IPayRequery({this.merchantCode, this.refNo, this.amount,});

  String? merchantCode;
  String? refNo;
  String? amount;

  Map<String, dynamic> toArguments() {
    return {
      'merchantCode': merchantCode,
      'refNo': refNo,
      'amount': amount,
    };
  }
}