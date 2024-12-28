import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/component/widgets/custom_textfield.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../../bread_crumbs/view/bread_crumbs.dart';
import '../controller/payments_controller.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final paymentProvider = Provider.of<PaymentsController>(context);
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
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
            const BreadCrumbs(),
            const SizedBox(height: 10),
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
                    length: 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.50,
                              height: 40,
                              child: CustomTextField(
                                labelTxt: 'Search',
                                hintTxt: 'Enter text',
                                controller: searchController,
                                keyboardType: TextInputType.text,
                                labelTxtStyle: TextStyle(
                                    color: AppColor.txtFieldItemColor),
                                hintTxtStyle: TextStyle(
                                    color: AppColor.txtFieldItemColor),
                                onChanged: (value) {
                                  context
                                      .read<PaymentsController>()
                                      .searchItems(value);
                                },
                                validator: (value) {
                                  return null;
                                },
                                obscureText: false,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
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
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TabBarView(
                              children: [
                                PaymentTabItem(),
                                ReportTabItem(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentTabItem extends StatelessWidget {
  const PaymentTabItem({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final paymentProvider = Provider.of<PaymentsController>(context);
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1024;
    final crossAxisCount = isMobile
        ? 1
        : (isTablet ? 2 : 3);

    return paymentProvider.isLoading
        ? ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) =>
      const ShimmerWidget(height: 40, width: double.infinity),
    )
        : (isMobile
        ? ListView.builder(
      itemCount: paymentProvider.filteredItems.length,
      itemBuilder: (context, index) {
        final item = paymentProvider.filteredItems[index];
        return GestureDetector(
          onTap: () {
            context.go(item['route'] as String);
          },
          child: buildCardItem(item), // Use container-based card
        );
      },
    )
        : GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.5,
      ),
      itemCount: paymentProvider.filteredItems.length,
      itemBuilder: (context, index) {
        final item = paymentProvider.filteredItems[index];
        return GestureDetector(
          onTap: () {
            context.go(item['route'] as String);
          },
          child: buildGridItem(item),
        );
      },
    ));
  }
}

class ReportTabItem extends StatelessWidget {
  const ReportTabItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const PaymentTabItem(); // Reuse the same structure for reports
  }
}

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius? borderRadius;

  const ShimmerWidget({
    required this.height,
    required this.width,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}

Widget buildCardItem(Map<String, dynamic> item) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
    child: Container(
      decoration: BoxDecoration(
        color: item['cardColor'] as Color,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          SvgPicture.asset(
            item['logo'] as String,
            width: 40,
            height: 40,
            color: item['cardTitle'] as Color,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              item['title'] as String,
              style: TextStyle(
                fontFamily: 'poppinsRegular',
                color: item['cardTitle'] as Color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildGridItem(Map<String, dynamic> item) {
  return Container(
    decoration: BoxDecoration(
      color: item['cardColor'] as Color,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        SvgPicture.asset(
          item['logo'] as String,
          width: 40,
          height: 40,
          color: item['cardTitle'] as Color,
        ),
        const SizedBox(height: 8),
        Text(
          item['title'] as String,
          style: TextStyle(
            fontFamily: 'poppinsRegular',
            color: item['cardTitle'] as Color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
