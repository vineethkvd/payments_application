import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:payments_application/features/bread_crumbs/view/bread_crumbs.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/component/widgets/custom_textfield.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../controller/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BreadCrumbs(),
              const SizedBox(height: 15),
              Expanded(
                child: Container(
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
                        // Search Bar
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
                        // Content
                        Expanded(
                          child: Consumer<HomeController>(
                            builder: (context, homeController, child) {
                              if (homeController.isLoading) {
                                return LayoutBuilder(
                                  builder: (context, constraints) {
                                    if (constraints.maxWidth < 600) {
                                      // Mobile Layout - Shimmer ListView
                                      return ListView.builder(
                                        itemCount: 6,
                                        itemBuilder: (context, index) {
                                          return shimmerWidget(
                                            height: 120,
                                            width: double.infinity,
                                          );
                                        },
                                      );
                                    } else if (constraints.maxWidth < 1024) {
                                      // Tablet Layout - Shimmer GridView
                                      return GridView.builder(
                                        gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 2.5,
                                        ),
                                        itemCount: 6,
                                        itemBuilder: (context, index) {
                                          return shimmerWidget(
                                            height: 100,
                                            width: double.infinity,
                                          );
                                        },
                                      );
                                    } else {
                                      // Desktop Layout - Shimmer GridView
                                      return GridView.builder(
                                        gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 2.5,
                                        ),
                                        itemCount: 6,
                                        itemBuilder: (context, index) {
                                          return shimmerWidget(
                                            height: 100,
                                            width: double.infinity,
                                          );
                                        },
                                      );
                                    }
                                  },
                                );
                              }

                              if (homeController.filteredItems.isEmpty) {
                                return const Center(
                                  child: Text(
                                    "No items found",
                                    style: TextStyle(
                                      color: AppColor.drawerColor,
                                      fontSize: 16,
                                      fontFamily:     'poppinsRegular',
                                    ),
                                  ),
                                );
                              }

                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  if (constraints.maxWidth < 600) {
                                    // Mobile Layout - ListView
                                    return ListView.builder(
                                      itemCount: homeController.filteredItems.length,
                                      itemBuilder: (context, index) {
                                        final item =
                                        homeController.filteredItems[index];
                                        return GestureDetector(
                                          onTap: () {
                                            context.go(item['route'] as String);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 8.0),
                                            padding: const EdgeInsets.all(16.0),
                                            decoration: BoxDecoration(
                                              color: item['cardColor'] as Color,
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                            ),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  item['logo'] as String,
                                                  width: 25,
                                                  height: 25,
                                                  color: item['cardTitle'] as Color,
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: Text(
                                                    item['title'] as String,
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'poppinsRegular',
                                                      color: item['cardTitle']
                                                      as Color,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else if (constraints.maxWidth < 1024) {
                                    // Tablet Layout - GridView with 2 columns
                                    return GridView.builder(
                                      gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 2.5,
                                      ),
                                      itemCount:
                                      homeController.filteredItems.length,
                                      itemBuilder: (context, index) {
                                        final item =
                                        homeController.filteredItems[index];
                                        return GestureDetector(
                                          onTap: () {
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
                                                  color: item['cardTitle']
                                                  as Color,
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
                                  } else {
                                    // Desktop Layout - GridView with 3 columns
                                    return GridView.builder(
                                      gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 2.5,
                                      ),
                                      itemCount:
                                      homeController.filteredItems.length,
                                      itemBuilder: (context, index) {
                                        final item =
                                        homeController.filteredItems[index];
                                        return GestureDetector(
                                          onTap: () {
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
                                                  color: item['cardTitle']
                                                  as Color,
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
                                  }
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
      ),
    );
  }

  Widget shimmerWidget({required double height, required double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
