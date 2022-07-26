import 'package:flutter/foundation.dart';
import 'package:flutter_ipay88_platform_interface/flutter_ipay88_platform_interface.dart';

@immutable
class MalaysianPaymentMethod extends IPayPaymentMethod {
  
  const MalaysianPaymentMethod._({
    required int id, required String name,
  }) : super(id: id, name: name, currency: "MYR",);
  
  static const List<IPayPaymentMethod> eWallets = [
    MalaysianPaymentMethod._(id: 4210, name: "Boost Wallet Online",),
    MalaysianPaymentMethod._(id: 4244, name: "MCash",),
    MalaysianPaymentMethod._(id: 4523, name: "GrabPay",),
    MalaysianPaymentMethod._(id: 4801, name: "ShopeePay",),
    MalaysianPaymentMethod._(id: 4538, name: "Touch n Go eWallet",),
  ];

  static const List<IPayPaymentMethod> onlineBankingFpx = [
    MalaysianPaymentMethod._(id: 4006, name: "FPX Maybank",),
    MalaysianPaymentMethod._(id: 4008, name: "FPX Alliance Bank",),
    MalaysianPaymentMethod._(id: 4010, name: "FPX Ambank",),
    MalaysianPaymentMethod._(id: 4014, name: "FPX RHB Bank",),
    MalaysianPaymentMethod._(id: 4015, name: "FPX Hong Leong Bank",),
    MalaysianPaymentMethod._(id: 4020, name: "FPX CIMB",),
    MalaysianPaymentMethod._(id: 4031, name: "FPX Public Bank",),
    MalaysianPaymentMethod._(id: 4102, name: "FPX Bank Rakyat",),
    MalaysianPaymentMethod._(id: 4103, name: "FPX Affin Bank",),
    MalaysianPaymentMethod._(id: 4124, name: "FPX Bank Simpanan Nasional",),
    MalaysianPaymentMethod._(id: 4134, name: "FPX Bank Islam",),
    MalaysianPaymentMethod._(id: 4152, name: "FPX UOB",),
    MalaysianPaymentMethod._(id: 4166, name: "FPX Bank Muamalat",),
    MalaysianPaymentMethod._(id: 4167, name: "FPX OCBC",),
    MalaysianPaymentMethod._(id: 4168, name: "FPX Standard Chartered Bank",),
    MalaysianPaymentMethod._(id: 4178, name: "FPX M2E",),
    MalaysianPaymentMethod._(id: 4198, name: "FPX HSBC",),
    MalaysianPaymentMethod._(id: 4199, name: "FPX KFH",),
    MalaysianPaymentMethod._(id: 4405, name: "FPX Agro",),
    MalaysianPaymentMethod._(id: 4006, name: "FPX Maybank",),
  ];

  static const List<IPayPaymentMethod> onlineBankingFpxCrossborder = [
    MalaysianPaymentMethod._(id: 4500, name: "FPX Crossborder Affin Bank",),
    MalaysianPaymentMethod._(id: 4501, name: "FPX Crossborder Alliance Bank",),
    MalaysianPaymentMethod._(id: 4502, name: "FPX Crossborder Ambank",),
    MalaysianPaymentMethod._(id: 4503, name: "FPX Crossborder Bank Islam",),
    MalaysianPaymentMethod._(id: 4504, name: "FPX Crossborder Bank Rakyat",),
    MalaysianPaymentMethod._(id: 4505, name: "FPX Crossborder Bank Simpanan Nasional",),
    MalaysianPaymentMethod._(id: 4506, name: "FPX Crossborder CIMB",),
    MalaysianPaymentMethod._(id: 4507, name: "FPX Crossborder Hong Leong Bank",),
    MalaysianPaymentMethod._(id: 4508, name: "FPX Crossborder HSBC",),
    MalaysianPaymentMethod._(id: 4509, name: "FPX Crossborder KFH",),
    MalaysianPaymentMethod._(id: 4510, name: "FPX Crossborder Maybank",),
    MalaysianPaymentMethod._(id: 4511, name: "FPX Crossborder Bank Muamalat",),
    MalaysianPaymentMethod._(id: 4512, name: "FPX Crossborder OCBC",),
    MalaysianPaymentMethod._(id: 4513, name: "FPX Crossborder Public Bank",),
    MalaysianPaymentMethod._(id: 4514, name: "FPX Crossborder RHB Bank",),
    MalaysianPaymentMethod._(id: 4515, name: "FPX Crossborder Standard Chartered Bank",),
    MalaysianPaymentMethod._(id: 4516, name: "FPX Crossborder UOB",),
  ];
}

@immutable
class CambodianPaymentMethod extends IPayPaymentMethod {

  const CambodianPaymentMethod._({
    required int id,
    required String name,
  }) : super(id: id, name: name, currency: "USD",);

  static const IPayPaymentMethod unionPay = CambodianPaymentMethod._(
    id: 2015,
    name: "UnionPay",
  );

  static const List<IPayPaymentMethod> onlineBanking = [
    CambodianPaymentMethod._(id: 2003, name: "Acieda Xpay",),
    CambodianPaymentMethod._(id: 2238, name: "Chip Mong Bank",),
    CambodianPaymentMethod._(id: 2246, name: "AMK Online Card",),
    CambodianPaymentMethod._(id: 2242, name: "Campu Direct Debit",),
  ];

  static const List<IPayPaymentMethod> eWallets = [
    CambodianPaymentMethod._(id: 2235, name: "E-Wings Online Web",),
    CambodianPaymentMethod._(id: 2011, name: "Pi Pay",),
    CambodianPaymentMethod._(id: 2009, name: "Metfone eMoney",),
  ];

  static const List<IPayPaymentMethod> qr = [
    CambodianPaymentMethod._(id: 2248, name: "Bakong KHQR",),
    CambodianPaymentMethod._(id: 2233, name: "Alipay QR",),
    CambodianPaymentMethod._(id: 2240, name: "WeChat QR",),
  ];
}