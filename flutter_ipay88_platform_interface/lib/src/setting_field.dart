import 'dart:convert';

class SettingField {

  SettingField({
    required this.name,
    required dynamic value,
  }): value = value.toString();

  final String name;
  final String value;

  Map<String, dynamic> serialize() {
    return {
      "Name": name,
      "Value": value,
    };
  }

  @override
  String toString() => "$runtimeType(${jsonEncode(serialize(),)})";
}