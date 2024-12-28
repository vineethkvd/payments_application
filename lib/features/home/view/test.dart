// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:payments_application/core/utils/shared/constant/assets_path.dart';
// import 'package:provider/provider.dart';
// import '../../../core/utils/config/styles/colors.dart';
// import '../../../core/utils/shared/component/widgets/custom_textfield.dart';
// import '../controller/home_controller.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     final isTablet = size.width >= 600;
//     final isDesktop = size.width >= 1200;
//
//     return Container(
//       width: size.width,
//       height: size.height,
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(AssetsPath.appBackground),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             // Search Bar
//             Row(
//               children: [
//                 SizedBox(
//                   width: isTablet ? size.width * 0.5 : size.width * 0.8,
//                   height: 40,
//                   child: CustomTextField(
//                     labelTxt: 'Search',
//                     hintTxt: 'Enter text',
//                     controller: TextEditingController(),
//                     labelTxtStyle:
//                     TextStyle(color: AppColor.txtFieldItemColor),
//                     hintTxtStyle:
//                     TextStyle(color: AppColor.txtFieldItemColor),
//                     onChanged: (value) {
//                       context.read<HomeController>().searchItems(value);
//                     },
//                     validator: (value) => null,
//                     obscureText: false,
//                     suffixIcon: IconButton(
//                       icon: const Icon(Icons.search),
//                       onPressed: () {
//                         // Trigger search if needed
//                       },
//                     ), keyboardType: TextInputType.text,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//
//             // Main Content Area
//             Expanded(
//               child: Consumer<HomeController>(
//                 builder: (context, homeProvider, child) {
//                   final filteredItems = homeProvider.filteredItems;
//
//                   if (filteredItems.isEmpty) {
//                     return const Center(
//                       child: Text(
//                         "No items found",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontFamily: 'poppinsRegular',
//                         ),
//                       ),
//                     );
//                   }
//
//                   if (isDesktop || isTablet) {
//                     return GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: isDesktop ? 5 : 3,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                         childAspectRatio: 2.5,
//                       ),
//                       itemCount: filteredItems.length,
//                       itemBuilder: (context, index) {
//                         final item = filteredItems[index];
//                         return buildCard(item, context);
//                       },
//                     );
//                   }
//
//                   // Mobile View
//                   return ListView.builder(
//                     itemCount: filteredItems.length,
//                     itemBuilder: (context, index) {
//                       final item = filteredItems[index];
//                       return buildCard(item, context);
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildCard(Map<String, dynamic> item, BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         context.go(item['route'] as String);
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 5.0),
//         decoration: BoxDecoration(
//           color: item['cardColor'] as Color,
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             SvgPicture.asset(
//               item['logo'] as String,
//               width: 40,
//               height: 40,
//               color: item['cardTitle'] as Color,
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Text(
//                 item['title'] as String,
//                 style: TextStyle(
//                   fontFamily: 'poppinsRegular',
//                   color: item['cardTitle'] as Color,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 13,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
