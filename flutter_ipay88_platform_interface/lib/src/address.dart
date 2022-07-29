import 'dart:convert';

class IPayAddress {

  const IPayAddress({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.phone,
    this.countryCode = "ID",
  });

  final String firstName;
  final String lastName;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String phone;
  final String countryCode;

  Map<String, dynamic> serialize() {
    return {
      "FirstName": firstName,
      "LastName": lastName,
      "Address": address,
      "City": city,
      "State": state,
      "PostalCode": postalCode,
      "Phone": phone,
      "CountryCode": countryCode,
    };
  }

  @override
  String toString() => "$runtimeType(${jsonEncode(serialize(),)})";
}