import 'package:flutter_test/flutter_test.dart';
import 'package:clinic_flutter_p1/counter.dart';

void main() {
  testWidgets('Counter value should be incremented',
      (WidgetTester tester) async {
    final counter = Counter();

    counter.increment();

    expect(counter.value, 1);
  });
}
