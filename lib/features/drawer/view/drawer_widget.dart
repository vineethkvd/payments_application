import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:payments_application/core/utils/config/styles/colors.dart';
import 'package:payments_application/core/utils/shared/constant/assets_path.dart';
import 'package:payments_application/features/drawer/controller/drawer_controller.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<SliderController>(context);
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return Container(
      color: AppColor.drawerColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drawer Header
          Container(
            decoration: const BoxDecoration(
              color: AppColor.drawerImgTileColor,
              border: Border(
                bottom: BorderSide(
                  color: AppColor.dividerColor,
                  width: 1.0,
                ),
              ),
            ),
            height: size.height * 0.073,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/app_logo.png"),
          ),
          // Drawer Items
          Expanded(
            child: ListView.builder(
              itemCount: drawerProvider.items.length,
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                final item = drawerProvider.items[index];
                final isSelected = drawerProvider.selectedItem == item['title'];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: buildDrawerOption(
                    icon: item['logo'].toString(),
                    text: item['title'].toString(),
                    isSelected: isSelected,
                    onTap: () {
                      drawerProvider.setSelectedItem(item['title']!);
                      context.go(item['route']!);

                      if (!isTablet) {
                        Navigator.of(context).pop(); // Close drawer on mobile
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerOption({
    required String icon,
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(6.0),
        ),
        height: 50,
        child: Row(
          children: [
            const SizedBox(width: 12),
            SvgPicture.asset(
              icon,
              width: 22,
              height: 22,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontFamily: 'poppinsRegular',
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            SvgPicture.asset(
              AssetsPath.arrowBack,
              width: 16,
              height: 16,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
