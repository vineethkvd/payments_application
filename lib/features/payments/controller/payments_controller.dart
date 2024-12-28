import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/constant/assets_path.dart';

class PaymentsController extends ChangeNotifier {
  PaymentsController() {
    loadingPayments();
  }

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Tab index to switch between Payments and Reports
  int _curIndex = 0;
  int get curIndex => _curIndex;

  // Payment items
  final List<Map<String, dynamic>> _paymentsItems = [
    {
      "logo": AssetsPath.reinitiate,
      "title": "Re-initiate",
      'route': RoutesPath.home,
      "cardColor": AppColor.card1,
      "cardTitle": AppColor.card1Title
    },
    {
      "logo": AssetsPath.request,
      "title": "Re-initiate Successful\nPayment - Request",
      'route': RoutesPath.payments,
      "cardColor": AppColor.card2,
      "cardTitle": AppColor.card2Title
    },
    {
      "logo": AssetsPath.approval,
      "title": "Re-initiate Successful\nPayment - Approval",
      'route': RoutesPath.others,
      "cardColor": AppColor.card3,
      "cardTitle": AppColor.card3Title
    },
    {
      "logo": AssetsPath.debitAdvice,
      "title": "Debit advise block",
      'route': RoutesPath.otp_based,
      "cardColor": AppColor.card4,
      "cardTitle": AppColor.card4Title
    },
    {
      "logo": AssetsPath.succesDebitAdvice,
      "title": "Successful payment\nto debit advise",
      'route': RoutesPath.sbi,
      "cardColor": AppColor.card5,
      "cardTitle": AppColor.card5Title
    },
    {
      "logo": AssetsPath.changeDebitAdvice,
      "title": "Change debit advise branch",
      'route': RoutesPath.sbi,
      "cardColor": AppColor.card6,
      "cardTitle": AppColor.card6Title
    },
    {
      "logo": AssetsPath.bank,
      "title": "Change branch IMPS bank",
      'route': RoutesPath.sbi,
      "cardColor": AppColor.card7,
      "cardTitle": AppColor.card7Title
    },
    {
      "logo": AssetsPath.pending,
      "title": "Bulk reinitiate debit\nadvise pending",
      'route': RoutesPath.sbi,
      "cardColor": AppColor.card8,
      "cardTitle": AppColor.card8Title
    }
  ];

  // Report items
  final List<Map<String, dynamic>> _reportItem = [
    {
      "logo": AssetsPath.reinitiate,
      "title": "Payments report",
      'route': RoutesPath.home,
      "cardColor": AppColor.card1,
      "cardTitle": AppColor.card1Title
    },
    {
      "logo": AssetsPath.request,
      "title": "Payment OGL report",
      'route': RoutesPath.payments,
      "cardColor": AppColor.card2,
      "cardTitle": AppColor.card2Title
    },
    {
      "logo": AssetsPath.approval,
      "title": "Debit advise report",
      'route': RoutesPath.others,
      "cardColor": AppColor.card3,
      "cardTitle": AppColor.card3Title
    },
    {
      "logo": AssetsPath.debitAdvice,
      "title": "Payment status",
      'route': RoutesPath.otp_based,
      "cardColor": AppColor.card4,
      "cardTitle": AppColor.card4Title
    },
    {
      "logo": AssetsPath.succesDebitAdvice,
      "title": "IMPS Inquiry",
      'route': RoutesPath.sbi,
      "cardColor": AppColor.card5,
      "cardTitle": AppColor.card5Title
    },
    {
      "logo": AssetsPath.changeDebitAdvice,
      "title": "Customer NEFT Details",
      'route': RoutesPath.sbi,
      "cardColor": AppColor.card6,
      "cardTitle": AppColor.card6Title
    },
  ];

  List<Map<String, dynamic>> get paymentsItems => _paymentsItems;
  List<Map<String, dynamic>> get reportItem => _reportItem;

  // Filtered items for the current tab
  List<Map<String, dynamic>> _filteredItems = [];
  List<Map<String, dynamic>> get filteredItems => _filteredItems;

  /// Load initial payments data with shimmer effect
  Future<void> loadingPayments() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 5)).then((value) {
      _isLoading = false;
      loadPaymentsItem();
      notifyListeners();
    });
  }

  /// Change tab index and load respective data
  void setTabIndex(int index) {
    _curIndex = index;
    if (_curIndex == 0) {
      loadPaymentsItem();
    } else {
      loadReportItem();
    }
    notifyListeners();
  }

  /// Search items in the current tab
  void searchItems(String query) {
    List<Map<String, dynamic>> sourceList =
        _curIndex == 0 ? paymentsItems : reportItem;

    if (query.isEmpty) {
      _filteredItems = List.from(sourceList);
    } else {
      _filteredItems = sourceList
          .where((item) => item['title']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  /// Load all payment items
  void loadPaymentsItem() {
    _filteredItems = List.from(paymentsItems);
    notifyListeners();
  }

  /// Load all report items
  void loadReportItem() {
    _filteredItems = List.from(reportItem);
    notifyListeners();
  }
}
