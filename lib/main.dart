import 'package:flutter/material.dart';
import 'package:payments_application/features/payments/controller/payments_controller.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'package:url_strategy/url_strategy.dart';
import 'features/bread_crumbs/controller/breadcrumbs_controller.dart';
import 'features/drawer/controller/drawer_controller.dart';
import 'features/home/controller/home_controller.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => SliderController()),
        ChangeNotifierProvider(create: (_) => BreadCrumbsController()),
        ChangeNotifierProvider(create: (_) => PaymentsController()),
      ],
      child: const MyApp(),
    ),
  );
}

