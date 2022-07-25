library flutter_ipay88_id;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ipay88_platform_interface/flutter_ipay88_platform_interface.dart';

class IPay88Indonesia extends IPay {

  @override
  Future<void> checkout(IPayPayment payment) {
    if (payment.currency.trim().isEmpty) {
      payment.currency = "IDR";
    }
    payment.country = "ID";
    return super.checkout(payment);
  }

  @override
  @protected
  final MethodChannel channel = const MethodChannel("id.lab.neruno.ipay88/platform",);
}