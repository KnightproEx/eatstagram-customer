import 'package:flutter/material.dart';

import 'screens/Cart/cart.dart';
import 'screens/Payment/payment.dart';
import 'screens/intro/intro.dart';
import 'screens/meal_option/meal_option.dart';
import 'screens/menu/menu.dart';
import 'screens/order_status/order_status.dart';
import 'screens/restaurant/restaurant.dart';
import 'screens/scanner/scanner.dart';
import 'screens/thank_you/thank_you.dart';

Map<String, WidgetBuilder> routes = {
  '/': (_) => Intro(),
  '/Scanner': (_) => Scanner(),
  '/MealOption': (_) => MealOption(),
  '/Menu': (_) => Menu(),
  '/Payment': (_) => Payment(),
  '/Cart': (_) => Cart(),
  '/OrderStatus': (_) => OrderStatus(),
  '/ThankYou': (_) => ThankYou(),
  '/Restaurant': (_) => Restaurant(),
};
