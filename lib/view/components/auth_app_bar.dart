import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_dimensions.dart';
import '../../utils/image_paths.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {

  AuthAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: getAppBarUI(context));
  }

  Widget getAppBarUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImagePath.eventSquidLogoNoTag,
                  width: screenWidth / 2.5,
                ).paddingOnly(top: 12),
              ],
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
