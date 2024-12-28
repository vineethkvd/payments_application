import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:payments_application/core/utils/shared/constant/assets_path.dart';
import 'package:payments_application/features/bread_crumbs/view/bread_crumbs.dart';
import 'package:payments_application/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/component/widgets/custom_textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
            const SizedBox(height: 15),
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
                  padding: const EdgeInsets.all(16.0),
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
                              labelTxtStyle:
                                  TextStyle(color: AppColor.txtFieldItemColor),
                              hintTxtStyle:
                                  TextStyle(color: AppColor.txtFieldItemColor),
                              onChanged: (value) {
                                context
                                    .read<HomeController>()
                                    .searchItems(value);
                              },
                              validator: (value) {
                                // Validation logic
                                return null; // or return an error message
                              },
                              obscureText: false,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  // Handle search action
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: _isLoading
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 2.5,
                                ),
                                itemCount: 6, // Show 6 shimmer items
                                itemBuilder: (context, index) {
                                  return shimmerWidget(
                                    height: 100, // Adjust height as needed
                                    width: double.infinity,
                                    borderRadius: BorderRadius.circular(8.0),
                                  );
                                },
                              )
                            : Consumer<HomeController>(
                                builder: (context, homeProvider, child) {
                                  return GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 2.5,
                                    ),
                                    itemCount:
                                        homeProvider.filteredItems.length,
                                    itemBuilder: (context, index) {
                                      final item =
                                          homeProvider.filteredItems[index];
                                      return GestureDetector(
                                        onTap: () {
                                          // Navigate to the corresponding route
                                          context.go(item['route'] as String);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: item['cardColor'] as Color,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                item['logo'] as String,
                                                width: 40,
                                                height: 40,
                                                color:
                                                    item['cardTitle'] as Color,
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                item['title'] as String,
                                                style: TextStyle(
                                                  fontFamily: 'poppinsRegular',
                                                  color: item['cardTitle']
                                                      as Color,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shimmerWidget({
    required double height,
    required double width,
    BorderRadius? borderRadius,
  }) {
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
