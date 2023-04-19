import 'package:contact_scan/view/components/app_bar_controller.dart';
import 'package:contact_scan/utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarSimple extends StatelessWidget implements PreferredSizeWidget {
  AppBarSimple({Key? key}) : super(key: key);

  final AppBarController _appBarController = Get.put(AppBarController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: getAppBarUI(context));
  }

  Widget getAppBarUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 2, end: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () async {
              Get.back();
            },
            child: const Icon(
              CupertinoIcons.clear,
              color: AppColors.grayB5,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
