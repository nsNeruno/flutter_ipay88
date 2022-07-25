library flutter_ipay88_platform_interface;

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ipay88_platform_interface/src/delegate.dart';
import 'package:flutter_ipay88_platform_interface/src/payment.dart';
import 'package:flutter_ipay88_platform_interface/src/requery.dart';
import 'package:permission_handler/permission_handler.dart';

export 'src/delegate.dart';
export 'src/payment.dart';
export 'src/requery.dart';

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
            for (var d in delegates) {
              d.onPaymentSucceeded(
                transId, refNo, amount, remark, authCode,
              );
            }
            break;
          case "onPaymentFailed":
            for (var d in delegates) {
              d.onPaymentFailed(transId, refNo, amount, remark, errDesc,);
            }
            break;
          case "onPaymentCanceled":
            for (var d in delegates) {
              d.onPaymentCanceled(transId, refNo, amount, remark, errDesc,);
            }
            break;
          case "onRequeryResult":
            for (var d in delegates) {
              d.onRequeryResult(merchantCode, refNo, amount, result,);
            }
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

  Future<void> checkout(IPayPayment payment,) async {
    await _permissionsCheck();
    channel.invokeMethod(
      "checkout",
      payment.toArguments(),
    );
  }

  Future<void> requery(IPayRequery requery,) async {
    await _permissionsCheck();
    channel.invokeMethod(
      "requery",
      requery.toArguments(),
    );
  }

  void addDelegate(IPayResultDelegate delegate,) {
    delegates.add(delegate,);
  }

  void removeDelegate(IPayResultDelegate delegate,) {
    delegates.remove(delegate,);
  }

  @protected
  final List<IPayResultDelegate> delegates = [];

  @protected
  @visibleForTesting
  abstract final MethodChannel channel;
}