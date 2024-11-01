import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeons/ffi_trw.g.dart',
  dartTestOut: 'test/pigeons/ffi_trw.g_test.dart',
  kotlinOut:
      'android/app/src/main/kotlin/com/example/ffi_right_way/FFIPigeon.g.kt',
  kotlinOptions: KotlinOptions(errorClassName: 'FfiTrwError'),
  swiftOut: 'ios/Runner/FFIPigeon.swift',
  swiftOptions: SwiftOptions(errorClassName: 'FfiTrwError'),
))
@HostApi(dartHostTestHandler: 'TestFfiTRWHostApi')
abstract class FfiTRWHostApi {
  double add(double a, double b);

  void startTimer();

  void stopTimer();
}

@FlutterApi()
abstract class FfiTRWFlutterApi {
  void onReceiveTimerResult(int result);
}
