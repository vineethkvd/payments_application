import 'package:flutter/material.dart';
import 'package:payments_application/features/bread_crumbs/view/bread_crumbs.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../../payments/controller/payments_controller.dart';

class OthersPage extends StatefulWidget {
  const OthersPage({super.key});

  @override
  State<OthersPage> createState() => _OthersPageState();
}

class _OthersPageState extends State<OthersPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
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
            Expanded(
                child: Container(
              width: size.width,
              height: double.infinity,
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
                padding: const EdgeInsets.all(8.0),
                child: DefaultTabController(
                  length: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          border: Border.all(
                              width: 0.8, color: AppColor.tabBarColor),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        height: 50,
                        padding: const EdgeInsets.all(5),
                        child: TabBar(
                          onTap: (index) {
                            context
                                .read<PaymentsController>()
                                .setTabIndex(index);
                          },
                          indicator: BoxDecoration(
                              color: AppColor.drawerColor,
                              borderRadius: BorderRadius.circular(12)),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: Colors.black,
                          labelStyle: TextStyle(
                            fontFamily: 'poppinsRegular',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontFamily: 'poppinsRegular',
                            color: AppColor.txtColorTab,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          dividerColor: Colors.transparent,
                          tabs: const [
                            Tab(text: "Payments"),
                            Tab(text: "Reports"),
                            Tab(text: "Payments"),
                            Tab(text: "Reports"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TabBarView(
                            children: [
                            Center(child: Text("data 1"),),
                              Center(child: Text("data 2"),),
                              Center(child: Text("data 3"),),
                              Center(child: Text("data 4"),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
