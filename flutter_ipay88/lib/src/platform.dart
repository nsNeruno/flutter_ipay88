import 'package:flutter_ipay88_id/flutter_ipay88_id.dart';
import 'package:flutter_ipay88_my/flutter_ipay88_my.dart';
import 'package:flutter_ipay88_platform_interface/flutter_ipay88_platform_interface.dart';

abstract class IPay88Platform {

  late final IPay sdk = IPay88();

  late final IPay sdkID = IPay88Indonesia();
}