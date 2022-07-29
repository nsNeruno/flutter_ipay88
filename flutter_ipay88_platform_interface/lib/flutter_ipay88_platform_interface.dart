library flutter_ipay88_platform_interface;

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ipay88_platform_interface/src/delegate.dart';
import 'package:flutter_ipay88_platform_interface/src/payment.dart';
import 'package:flutter_ipay88_platform_interface/src/requery.dart';
import 'package:permission_handler/permission_handler.dart';

import 'src/address.dart';
import 'src/item_transaction.dart';
import 'src/seller.dart';
import 'src/setting_field.dart';

export 'src/address.dart';
export 'src/delegate.dart';
export 'src/item_transaction.dart';
export 'src/payment.dart';
export 'src/requery.dart';
export 'src/responses.dart';
export 'src/seller.dart';
export 'src/setting_field.dart';

abstract class IPay {

  IPay() {
    channel.setMethodCallHandler(
      (call) async {
        String method = call.method;
        var arguments = call.arguments;
        String? transId, refNo, amount, remark, authCode, errDesc, merchantCode, result;
        if (arguments is Map<String, dynamic>) {
          transId = arguments['transId']?.toString();
          refNo = arguments['refNo']?.toString();
          amount = arguments['amount']?.toString();
          remark = arguments['remark']?.toString();
          authCode = arguments['authCode']?.toString();
          errDesc = arguments['errDesc']?.toString();
          merchantCode = arguments['merchantCode']?.toString();
          result = arguments['result']?.toString();
        }
        switch (method) {
          case "onPaymentSucceeded":
            onPaymentSucceeded(transId, refNo, amount, remark, authCode,);
            break;
          case "onPaymentFailed":
            onPaymentFailed(transId, refNo, amount, remark, errDesc,);
            break;
          case "onPaymentCanceled":
            onPaymentCanceled(transId, refNo, amount, remark, errDesc,);
            break;
          case "onRequeryResult":
            onRequeryResult(merchantCode, refNo, amount, result, errDesc,);
            break;
        }
      },
    );
  }

  Future<void> _permissionsCheck() async {
    if (Platform.isAndroid) {
      if (!await Permission.phone.request().isGranted) {
        throw StateError("Phone permission is required for Android",);
      }
    }
  }

  @mustCallSuper
  Future<void> checkout({
    required IPayPayment payment,
    List<ItemTransaction>? itemTransactions,
    IPayAddress? shippingAddress,
    IPayAddress? billingAddress,
    List<IPaySeller>? sellers,
    IPayPaymentMethod? method,
    List<SettingField>? settingFields,
  }) async {
    await _permissionsCheck();
  }

  @mustCallSuper
  Future<void> requery(IPayRequery requery,) async {
    await _permissionsCheck();
  }

  void addDelegate(IPayResultDelegate delegate,) {
    if (!delegates.contains(delegate,)) {
      delegates.add(
        delegate,
      );
    }
  }

  void removeDelegate(IPayResultDelegate delegate,) {
    delegates.remove(delegate,);
  }

  @protected
  void onPaymentSucceeded(String? transId, String? refNo, String? amount, String? remark, String? authCode,) {
    for (var d in delegates) {
      d.onPaymentSucceeded(
        transId, refNo, amount, remark, authCode,
      );
    }
  }

  @protected
  void onPaymentFailed(String? transId, String? refNo, String? amount, String? remark, String? errDesc,) {
    for (var d in delegates) {
      d.onPaymentFailed(
        transId, refNo, amount, remark, errDesc,
      );
    }
  }

  @protected
  void onPaymentCanceled(String? transId, String? refNo, String? amount, String? remark, String? errDesc,) {
    for (var d in delegates) {
      d.onPaymentCanceled(transId, refNo, amount, remark, errDesc,);
    }
  }

  @protected
  void onRequeryResult(String? merchantCode, String? refNo, String? amount, String? result, String? errDesc,) {
    for (var d in delegates) {
      d.onRequeryResult(merchantCode, refNo, amount, result, errDesc,);
    }
  }

  @protected
  final List<IPayResultDelegate> delegates = [];

  @protected
  @visibleForTesting
  abstract final MethodChannel channel;
}