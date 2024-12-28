import 'package:flutter/material.dart';
import 'package:payments_application/features/bread_crumbs/view/bread_crumbs.dart';

import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
class OthersPage extends StatefulWidget {
  const OthersPage({super.key});

  @override
  State<OthersPage> createState() => _OthersPageState();
}

class _OthersPageState extends State<OthersPage> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration:  BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsPath.appBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BreadCrumbs(),
            SizedBox(
              height: 10,
            ),
            Expanded(child:   Container(
              width: size.width,
              height: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                border: Border.all(width: 1,color: AppColor.dividerColor),
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
            ))
          ],
        ),
      ),
    );
  }
}
