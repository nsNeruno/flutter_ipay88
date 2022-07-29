library flutter_ipay88_my;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ipay88_platform_interface/flutter_ipay88_platform_interface.dart';

export 'src/payment_methods.dart';

@immutable
class IPay88 extends IPay {

  IPay88._();

  static late final IPay88 _instance = IPay88._();

  factory IPay88() => _instance;

  @override
  Future<void> checkout(IPayPayment payment) {
    if (payment.currency.trim().isEmpty) {
      payment.currency = "MYR";
    }
    if (payment.country.trim().isEmpty) {
      payment.country = "MY";
    }
    channel.invokeMethod(
      "checkout",
      payment.toArguments(),
    );
    return super.checkout(payment);
  }

  @override
  @protected
  final MethodChannel channel = const MethodChannel("my.lab.neruno.ipay88/platform",);
}