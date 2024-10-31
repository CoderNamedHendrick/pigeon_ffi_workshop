import 'package:flutter/services.dart';

const _methodChannel = MethodChannel('ffi_the_right_way');

Future<double> add(double a, double b) async {
  try {
    final result =
        await _methodChannel.invokeMethod('add', {'input1': a, 'input2': b});

    return result as double;
  } catch (_) {
    rethrow;
  }
}
