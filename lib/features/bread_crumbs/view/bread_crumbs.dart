import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../controller/breadcrumbs_controller.dart';

class BreadCrumbs extends StatefulWidget {
  const BreadCrumbs({super.key});

  @override
  State<BreadCrumbs> createState() => _BreadCrumbsState();
}
class _BreadCrumbsState extends State<BreadCrumbs> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final route = GoRouterState.of(context).matchedLocation;
    final Uri uri = Uri.parse(route);
    final List<String> segments = uri.pathSegments.where((e) => e.isNotEmpty).toList();
    final breadCrumbProvider = Provider.of<BreadCrumbsController>(context);
    final String curTitle = segments.last.replaceAll('_', ' ').toUpperCase();
    return Container(
      width: size.width,
      height: 45,
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        border: Border.all(width: 1, color: AppColor.dividerColor),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                "$curTitle PAGE",
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'poppinsSemiBold',
                  color: AppColor.hdTxtColor,
                ),
              ),
            ),
            Row(
              children: [
                Icon(Icons.home_filled, color: AppColor.hdTxtColor, size: 20),
                ...segments.asMap().entries.map((entry) {
                  final int idx = entry.key;
                  final String segment = entry.value;

                  // Check if the segment is "dashboard" and replace it with "Home"
                  String displayText = segment.toLowerCase() == 'dashboard'
                      ? 'Home'
                      : segment.replaceAll('_', ' ').toUpperCase();

                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          AssetsPath.arrowBack,
                          width: 20,
                          height: 15,
                          color: AppColor.hdTxtColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final path = '/' + segments.sublist(0, idx + 1).join('/');
                          context.go(path);
                          breadCrumbProvider.setSelectedItem(displayText);
                        },
                        child: Text(
                          displayText,
                          style: const TextStyle(
                            fontFamily: 'poppinsMedium',
                            fontSize: 14,
                            color: AppColor.hdTxtColor,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}