library flutter_ipay88_id;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ipay88_platform_interface/flutter_ipay88_platform_interface.dart';

export 'src/payment_methods.dart';

@immutable
class IPay88Indonesia extends IPay {

  IPay88Indonesia._();

  static late final IPay88Indonesia _instance = IPay88Indonesia._();

  factory IPay88Indonesia() => _instance;

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