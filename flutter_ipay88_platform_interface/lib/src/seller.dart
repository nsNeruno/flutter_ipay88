import 'dart:convert';

import 'package:flutter_ipay88_platform_interface/src/address.dart';

class IPaySeller {

  const IPaySeller({
    required this.id,
    required this.name,
    required this.sellerIdNumber,
    required this.email,
    required this.address,
  });

  final String id;
  final String name;
  final String sellerIdNumber;
  final String email;
  final IPayAddress address;

  Map<String, dynamic> serialize() {
    return {
      "Id": id,
      "Name": name,
      "SellerIdNumber": sellerIdNumber,
      "Email": email,
      "Address": address.serialize(),
    };
  }

  @override
  String toString() => "$runtimeType(${jsonEncode(serialize(),)})";
}