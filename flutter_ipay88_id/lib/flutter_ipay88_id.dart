library flutter_ipay88_id;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ipay88_id/src/api_client.dart';
import 'package:flutter_ipay88_platform_interface/flutter_ipay88_platform_interface.dart';

@immutable
class IPay88Indonesia extends IPay {

  IPay88Indonesia._({this.isSandbox = true,}): _apiClient = ApiClient(
    baseUrl: Uri.https(
      "${isSandbox ? "sandbox" : "payment"}.ipay88.co.id",
      "",
    ),
  );

  static late final IPay88Indonesia _instance = IPay88Indonesia._(isSandbox: false,);
  static late final IPay88Indonesia _sandboxInstance = IPay88Indonesia._();

  factory IPay88Indonesia({bool isSandbox = true,}) => isSandbox ? _sandboxInstance : _instance;

  factory IPay88Indonesia.sandbox() => _sandboxInstance;

  factory IPay88Indonesia.production() => _instance;

  @override
  Future<void> checkout({
    required IPayPayment payment,
    List<ItemTransaction>? itemTransactions,
    IPayAddress? shippingAddress,
    IPayAddress? billingAddress,
    List<IPaySeller>? sellers,
    IPayPaymentMethod? method,
    List<SettingField>? settingFields,
  }) async {
    if (itemTransactions == null || itemTransactions.isEmpty) {
      throw ArgumentError.value(itemTransactions, "Item Transactions", "Must not be empty",);
    }
    if (shippingAddress == null) {
      throw ArgumentError.notNull("Shipping Address",);
    }
    if (sellers == null || sellers.isEmpty) {
      throw ArgumentError.value(itemTransactions, "Sellers", "Must not be empty",);
    }
    if (payment.currency.trim().isEmpty) {
      payment.currency = "IDR";
    }
    if (payment.country.trim().isEmpty) {
      payment.country = "ID";
    }
    await super.checkout(
      payment: payment,
      itemTransactions: itemTransactions,
      shippingAddress: shippingAddress,
      billingAddress: billingAddress ?? shippingAddress,
      sellers: sellers,
      method: method,
      settingFields: settingFields,
    );
    var response = await _apiClient.checkout(
      payment: payment,
      itemTransactions: itemTransactions,
      shippingAddress: shippingAddress,
      billingAddress: billingAddress,
      sellers: sellers,
      method: method,
      settingFields: settingFields,
    );
    switch (response?.code) {
      case "0":
        onPaymentFailed(
          response?.checkoutId,
          payment.refNo,
          payment.amount,
          payment.remark,
          null,
        );
        break;
      case "1":
        onPaymentSucceeded(
          response?.checkoutId,
          response?.refNo,
          payment.amount,
          payment.remark,
          response?.code,
        );
        break;
      default:
        onPaymentCanceled(
          response?.checkoutId,
          payment.refNo,
          payment.amount,
          payment.remark,
          response?.message,
        );
        break;
    }
  }

  @override
  Future<void> requery(IPayRequery requery) async {
    await super.requery(requery,);
    var response = await _apiClient.requery(requery: requery,);
    bool isSuccessful = response == "00";
    onRequeryResult(
      requery.merchantCode, requery.refNo, requery.amount,
      isSuccessful ? response : null,
      isSuccessful ? null : response,
    );
  }

  @override
  @protected
  final MethodChannel channel = const MethodChannel("id.lab.neruno.ipay88/platform",);

  final bool isSandbox;

  final ApiClient _apiClient;
}