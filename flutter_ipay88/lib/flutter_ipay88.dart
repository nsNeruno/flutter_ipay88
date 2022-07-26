library flutter_ipay88;

import 'package:flutter_ipay88/src/platform.dart';

export 'package:flutter_ipay88_platform_interface/flutter_ipay88_platform_interface.dart';

class FlutterIPay88 extends IPay88Platform {

  FlutterIPay88._();

  static late final FlutterIPay88 _instance = FlutterIPay88._();

  factory FlutterIPay88() => _instance;
}
