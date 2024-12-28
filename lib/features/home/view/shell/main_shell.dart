import 'package:flutter/material.dart';
import 'package:payments_application/features/drawer/view/drawer_widget.dart';
import '../../../../core/utils/config/styles/colors.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
   MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final isTablet = size.width >= 600;
    final drawerWidth = isTablet ? size.width * 0.2 : size.width * 0.5;
    final appBarHeight = size.height * 0.073;

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        width: drawerWidth,
        child: const DrawerWidget(),
      ),
      body: Row(
        children: [
          // Drawer for tablet (always visible as a side panel)
          if (isTablet)
            SizedBox(
              width: drawerWidth,
              child: const DrawerWidget(),
            ),
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // AppBar with Menu Icon
                Container(
                  decoration: const BoxDecoration(
                    color: AppColor.appbarColor,
                    border: Border(
                      bottom: BorderSide(
                        color: AppColor.dividerColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  height: appBarHeight,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      !isTablet
                          ? IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          scaffoldKey.currentState?.openDrawer(); // Open the drawer
                        },
                      )
                          : SizedBox.shrink(),
                      const SizedBox(width: 8),
                      const Text(
                        "Payments Application",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'poppinsSemiBold',
                          color: AppColor.appBarColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // Main Content
                Expanded(
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
