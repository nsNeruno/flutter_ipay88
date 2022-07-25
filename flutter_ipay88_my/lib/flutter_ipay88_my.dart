library flutter_ipay88_my;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ipay88_platform_interface/flutter_ipay88_platform_interface.dart';

class IPay88Malaysia extends IPay {

  @override
  Future<void> checkout(IPayPayment payment) {
    if (payment.currency.trim().isEmpty) {
      payment.currency = "MYR";
    }
    payment.country = "MY";
    return super.checkout(payment);
  }

  @override
  @protected
  final MethodChannel channel = const MethodChannel("my.lab.neruno.ipay88/platform",);
}