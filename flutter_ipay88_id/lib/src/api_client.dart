import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ipay88_platform_interface/flutter_ipay88_platform_interface.dart';

class ApiClient {

  ApiClient({
    required Uri baseUrl,
    List<int>? validStatus,
  }): _dio = Dio(
    BaseOptions(
      connectTimeout: 60000,
      receiveTimeout: 60000,
      sendTimeout: 60000,
      baseUrl: baseUrl.toString(),
      validateStatus: (status) => validStatus?.isNotEmpty == true ? validStatus?.contains(status,) == true : true,
      receiveDataWhenStatusError: true,
    ),
  );

  static const apiVersion = "2.0";

  final Dio _dio;

  Future<CheckoutResponse?> checkout({
    required IPayPayment payment,
    required List<ItemTransaction> itemTransactions,
    required IPayAddress shippingAddress,
    IPayAddress? billingAddress,
    required List<IPaySeller> sellers,
    IPayPaymentMethod? method,
    List<SettingField>? settingFields,
  }) async {
    String? methodName = method?.name.toLowerCase();
    num? amount = num.tryParse(payment.amount,);
    if (amount == null) {
      throw ArgumentError.value(payment.amount, "amount", "Not a Numeric value",);
    }
    String? signature = await _createSignature(payment,);
    if (signature == null) {
      throw StateError("Failed to compute signature",);
    }
    var body = <String, dynamic>{
      "ApiVersion": apiVersion,
      "MerchantCode": payment.merchantCode,
      "PaymentId": int.tryParse(payment.paymentId,) ?? (throw ArgumentError.value(payment.paymentId, "paymentId", "Not an Integer",)),
      "Currency": payment.currency,
      "RefNo": payment.refNo,
      "Amount": amount,
      "ProdDesc": payment.prodDesc,
      "UserName": payment.userName,
      "UserEmail": payment.userEmail,
      "UserContact": payment.userContact,
      "RequestType": "REDIRECT", // or "SEAMLESS"
      if (payment.remark != null)
        "Remark": payment.remark,
      "Lang": payment.lang ?? "UTF-8", // or "ISO-8859-1"
      // TODO: Decide source
      // "ResponseURL": payment.responseUrl,
      "BackendURL": payment.backendPostURL,
      "Signature": signature,
      if (methodName?.contains("bca klikpay") == true)
        ...{
          "FullTransactionAmount": amount,
          // TODO: Decide source
          "MiscFee": 0.0,
        },
      "ItemTransactions": itemTransactions.map(
        (e) => e.serialize(),
      ).toList(),
      "ShippingAddress": shippingAddress.serialize(),
      "BillingAddress": (billingAddress ?? shippingAddress).serialize(),
      "Sellers": sellers.map((e) => e.serialize(),).toList(),
      if (settingFields != null)
        "SettingField": settingFields.map((e) => e.serialize(),).toList(),
    };
    var response = await _dio.post(
      "/ePayment/WebService/PaymentAPI/Checkout",
      data: body,
    );
    var data = response.data;
    assert(
      () {
        const logName = "IPay88ID.ApiClient.checkout";
        const encoder = JsonEncoder.withIndent('\t',);
        log(
          response.realUri.toString(),
          name: "$logName.realUri",
        );
        log(
          encoder.convert(body,),
          name: "$logName.body",
        );
        log(
          data is Map<String, dynamic> ? encoder.convert(data,) : data.toString(),
          name: "$logName.response(${response.statusCode})",
        );
        return true;
      }(),
    );
    if (data is Map<String, dynamic>) {
      return CheckoutResponse(data,);
    }
    return null;
  }

  Future<String?> requery({required IPayRequery requery,}) async {
    var body = requery.toArguments();
    var response = await _dio.post(
      "/epayment/enquiry.asp",
      data: body,
    );
    return response.data?.toString();
  }

  static String _computeSignature(String input,) {
    var encodedInput = utf8.encode(input,);
    return sha256.convert(encodedInput,).toString();
  }

  Future<String?> _createSignature(IPayPayment payment,) async {
    String input = [
      payment.merchantKey,
      payment.merchantCode,
      payment.refNo,
      payment.amount,
      payment.currency,
    ].join("||",);
    input = "||$input||";
    try {
      return compute<String, String>(_computeSignature, input,);
    } catch (err) {
      debugPrint(err.toString(),);
      if (err is Error) {
        debugPrint(err.stackTrace.toString(),);
      }
      return null;
    }
  }

}