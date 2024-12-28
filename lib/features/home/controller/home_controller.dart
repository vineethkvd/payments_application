import 'package:flutter/material.dart';
import 'package:payments_application/core/utils/config/styles/colors.dart';

import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/shared/constant/assets_path.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    _filteredItems = List.from(_homeItems);
  }
  final List<Map<String, dynamic>> _homeItems = [
    {
      "logo": AssetsPath.home,
      "title": "Home",
      'route': RoutesPath.home,
      "cardColor": AppColor.card1,
      "cardTitle": AppColor.card1Title
    },
    {
      "logo": AssetsPath.creditCard,
      "title": "Payments",
      'route': RoutesPath.payments,
      "cardColor": AppColor.card2,
      "cardTitle": AppColor.card2Title
    },
    {
      "logo": AssetsPath.user,
      "title": "Others",
      'route': RoutesPath.others,
      "cardColor": AppColor.card3,
      "cardTitle": AppColor.card3Title
    },
    {
      "logo": AssetsPath.money,
      "title": "OTP Based Cash Withdrawal",
      'route': RoutesPath.otp_based,
      "cardColor": AppColor.card4,
      "cardTitle": AppColor.card4Title
    },
    {
      "logo": AssetsPath.bank,
      "title": "SBI",
      'route': RoutesPath.sbi,
      "cardColor": AppColor.card5,
      "cardTitle": AppColor.card5Title
    }
  ];

  List<Map<String, dynamic>> get homeItems => _homeItems;


  List<Map<String, dynamic>> _filteredItems = [];
  List<Map<String, dynamic>> get filteredItems => _filteredItems;

  // Search functionality
  void searchItems(String query) {
    if (query.isEmpty) {
      _filteredItems = List.from(homeItems); // Reset to all items
    } else {
      _filteredItems = homeItems.where((item) {
        return item["title"].toLowerCase().contains(query.toLowerCase());
      }).toList();
      print(_filteredItems);
    }
    notifyListeners();
  }
}
