import 'package:ffi_right_way/pigeons/ffi_trw.g.dart';
import 'package:flutter_test/flutter_test.dart';

import 'pigeons/ffi_trw.g_test.dart';

class _TestHostApi implements TestFfiTRWHostApi {
  @override
  double add(double a, double b) {
    return a + b;
  }

  @override
  void startTimer() {}

  @override
  void stopTimer() {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FfiTRWHostApi test suite', () {
    final hostApi = FfiTRWHostApi();
    late _TestHostApi testApi;

    setUp(() {
      testApi = _TestHostApi();
      TestFfiTRWHostApi.setUp(testApi);
    });

    test('add', () async {
      final result = await hostApi.add(5, 10);
      expect(result, 15);
    });
  });
}
