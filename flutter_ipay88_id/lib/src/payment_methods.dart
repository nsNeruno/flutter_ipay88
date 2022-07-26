import 'package:flutter/foundation.dart';
import 'package:flutter_ipay88_platform_interface/flutter_ipay88_platform_interface.dart';

@immutable
class IndonesianIPaymentMethod extends IPayPaymentMethod {

  const IndonesianIPaymentMethod._({
    required int id,
    required String name,
    String? remark,
  }) : super(id: id, name: name, currency: "IDR", remark: remark,);

  static const List<IPayPaymentMethod> creditDebitCards = [
    IndonesianIPaymentMethod._(id: 52, name: "Credit Card (BCA)",),
    IndonesianIPaymentMethod._(id: 35, name: "Credit Card (BRI)",),
    IndonesianIPaymentMethod._(
      id: 48, name: "Credit Card (BRI 2D)", remark: "2D Payment",
    ),
    IndonesianIPaymentMethod._(id: 42, name: "Credit Card (CIMB)",),
    IndonesianIPaymentMethod._(
      id: 56,
      name: "Credit Card (CIMB Authorization)",
      remark: "PreAuth Payment",
    ),
    IndonesianIPaymentMethod._(id: 34, name: "Credit Card (CIMB IPG)",),
    IndonesianIPaymentMethod._(id: 44, name: "Credit Card (CIMB IPG 2D)",),
    IndonesianIPaymentMethod._(id: 45, name: "Credit Card (Danamon)",),
    IndonesianIPaymentMethod._(id: 49, name: "Debit Card (GPN)",),
    IndonesianIPaymentMethod._(id: 53, name: "Credit Card (Mandiri)",),
    IndonesianIPaymentMethod._(id: 43, name: "Credit Card (Maybank)",),
    IndonesianIPaymentMethod._(id: 54, name: "Credit Card (UnionPay)",),
    IndonesianIPaymentMethod._(id: 46, name: "Credit Card (UOB)",),
  ];

  static const List<IPayPaymentMethod> onlineBanking = [
    IndonesianIPaymentMethod._(id: 8, name: "BCA KlikPay",),
    IndonesianIPaymentMethod._(id: 11, name: "CIMB Clicks",),
    IndonesianIPaymentMethod._(id: 14, name: "Muamalat IB",),
    IndonesianIPaymentMethod._(id: 23, name: "Danamon Online Banking",),
  ];
  
  static const List<IPayPaymentMethod> virtualAccounts = [
    IndonesianIPaymentMethod._(id: 9, name: "Maybank VA",),
    IndonesianIPaymentMethod._(id: 31, name: "Permata VA",),
    IndonesianIPaymentMethod._(id: 17, name: "Mandiri VA",),
    IndonesianIPaymentMethod._(id: 25, name: "BCA VA",),
    IndonesianIPaymentMethod._(id: 61, name: "BRI VA",),
    IndonesianIPaymentMethod._(id: 26, name: "BNI VA",),
    IndonesianIPaymentMethod._(id: 86, name: "CIMB VA",),
  ];

  static const List<IPayPaymentMethod> eWallets = [
    IndonesianIPaymentMethod._(id: 63, name: "OVO",),
    IndonesianIPaymentMethod._(id: 77, name: "DANA",),
    IndonesianIPaymentMethod._(id: 13, name: "LinkAja",),
    IndonesianIPaymentMethod._(id: 76, name: "ShopeePay JumpApp",),
  ];

  static const List<IPayPaymentMethod> qris = [
    IndonesianIPaymentMethod._(id: 75, name: "ShopeePay QR",),
    IndonesianIPaymentMethod._(id: 78, name: "Nobu Bank QRIS",),
  ];

  static const List<IPayPaymentMethod> otc = [
    IndonesianIPaymentMethod._(id: 60, name: "Alfamart",),
    IndonesianIPaymentMethod._(id: 65, name: "Indomaret",),
  ];

  static const List<IPayPaymentMethod> onlineCredit = [
    IndonesianIPaymentMethod._(id: 71, name: "Akulaku",),
    IndonesianIPaymentMethod._(id: 70, name: "Indodana",),
    IndonesianIPaymentMethod._(id: 55, name: "Kredivo",),
  ];

  static const IPayPaymentMethod paypal = IPayPaymentMethod(
    id: 6,
    name: "Paypal",
    currency: "USD",
  );
}