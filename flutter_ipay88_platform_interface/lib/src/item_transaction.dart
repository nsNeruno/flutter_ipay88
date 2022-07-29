import 'dart:convert';

import 'package:flutter/foundation.dart';

enum ItemTransactionParent {
  seller,
  item,
}

extension ItemTransactionParentType on ItemTransactionParent {

  String get value => describeEnum(this,).toUpperCase();
}

class ItemTransaction implements Comparable<ItemTransaction> {

  const ItemTransaction({
    required this.id,
    required this.name,
    required this.quantity,
    required this.amount,
    this.type,
    this.url,
    this.imageUrl,
    this.tenor,
    this.codePlan,
    this.merchantId,
    required this.parentType,
    required this.parentId,
  });

  final String id;
  final String name;
  final int quantity;
  final num amount;
  final String? type;
  final String? url;
  final String? imageUrl;

  /// For BCA KlikPay
  final String? tenor;
  final String? codePlan;
  final String? merchantId;

  final ItemTransactionParent parentType;
  final String parentId;

  @override
  int compareTo(ItemTransaction other) => id.compareTo(other.id,);

  Map<String, dynamic> serialize() {
    return {
      "Id": id,
      "Name": name,
      "Quantity": quantity,
      "Amount": amount,
      if (type != null)
        "Type": type,
      "Url": url,
      "ImageUrl": imageUrl,
      if (tenor != null)
        "Tenor": tenor,
      if (codePlan != null)
        "CodePlan": codePlan,
      if (merchantId != null)
        "MerchantId": merchantId,
      "ParentType": parentType.value,
      "ParentId": parentId,
    };
  }

  @override
  String toString() => "$runtimeType(${jsonEncode(serialize(),)})";
}