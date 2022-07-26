import 'dart:convert';
import 'dart:ui';

class IPayPayment {

  IPayPayment({
    this.paymentId = "",
    this.merchantKey = "",
    this.merchantCode = "",
    this.refNo = "",
    this.amount = "1.00",
    this.currency = "",
    this.prodDesc = "",
    this.userName = "",
    this.userEmail = "",
    this.userContact = "",
    this.remark,
    this.lang,
    this.country = "",
    this.backendPostURL = "",
  });

  String paymentId;
  String merchantKey;
  String merchantCode;
  String refNo;
  String amount;
  String currency;
  String prodDesc;
  String userName;
  String userEmail;
  String userContact;
  String? remark;
  String? lang;
  String country;
  String backendPostURL;

  /// Not available in Indonesian implementation
  String? actionType;
  String? appDeepLink;

  Map<String, dynamic> toArguments() {
    return {
      'paymentId': paymentId,
      'merchantKey': merchantKey,
      'merchantCode': merchantCode,
      'refNo': refNo,
      'amount': amount,
      'currency': currency,
      'prodDesc': prodDesc,
      'username': userName,
      'userEmail': userEmail,
      'userContact': userContact,
      'remark': remark,
      'lang': lang,
      'country': country,
      'backEndPostURL': backendPostURL,
      'actionType': actionType,
      'appDeepLink': appDeepLink,
    };
  }

  @override
  String toString() => const JsonEncoder.withIndent('\t',).convert(
    toArguments(),
  );
}

class IPayPaymentMethod implements Comparable {

  const IPayPaymentMethod({
    required this.id,
    required this.name,
    required this.currency,
    this.remark,
  });

  final int id;
  final String name;
  final String currency;
  final String? remark;

  @override
  int compareTo(other) {
    if (other is! IPayPaymentMethod) {
      return -1;
    }
    return id.compareTo(other.id,);
  }

  @override
  bool operator ==(Object other) {
    if (other is! IPayPaymentMethod) {
      return false;
    }
    return [
      id == other.id,
      name == other.name,
      currency == other.currency,
    ].every((cnd) => cnd,);
  }

  @override
  int get hashCode => hashValues(id, name, currency,);

  @override
  String toString() => "$runtimeType#$id(${[name, currency, remark,].join(", ",)})";
}