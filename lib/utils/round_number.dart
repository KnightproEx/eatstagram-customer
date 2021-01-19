import 'dart:math';

String roundCurrency(double value, int places) {
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod).toStringAsFixed(places);
}
