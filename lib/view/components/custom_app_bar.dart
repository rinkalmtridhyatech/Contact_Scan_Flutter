import 'package:contact_scan/utils/color_constants.dart';
import 'package:contact_scan/view/modules/contactList/contact_options_controller.dart';
import 'package:contact_scan/view/modules/contactList/list_export_controller.dart';
import 'package:contact_scan/view/modules/scanScreen/scan_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/image_paths.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key}) : super(key: key);
  final ScanScreenController scanScreenController =
      Get.put(ScanScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: getAppBarUI(context));
  }

  Widget getAppBarUI(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  color: AppColors.black,
                  iconSize: 30,
                  onPressed: () {
                    Get.toNamed(Routes.auth,
                        parameters: {"isFromDrawer": "true"});
                  },
                ),
              ],
            ),
            Image.asset(
              ImagePath.eventSquidLogoNoTag,
              width: screenWidth / 2.5,
            ),
            Row(
              children: [
                Visibility(
                  visible: Get.currentRoute != Routes.home,
                  child: GestureDetector(
                    onTap: () {
                      Get.delete<ListExportController>();
                      Get.delete<ContactOptionsController>();
                      Get.offNamedUntil(Routes.home, (route) => false)
                          ?.then((value) => {
                                scanScreenController.isFirstTimeCall = false,
                                scanScreenController.controller?.pauseCamera(),
                              });
                    },
                    child: SvgPicture.asset(
                      ImagePath.toolbarQR,
                      height: 25,
                    ),
                  ),
                ),
                Visibility(
                  visible: Get.currentRoute != Routes.contactList,
                  child: SizedBox(
                    width: screenWidth / 16,
                  ),
                ),
                Visibility(
                  visible: Get.currentRoute != Routes.contactList,
                  child: GestureDetector(
                    onTap: () {
                      Get.offNamed(Routes.contactList);
                    },
                    child: SvgPicture.asset(
                      ImagePath.contactList,
                      height: 25,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
