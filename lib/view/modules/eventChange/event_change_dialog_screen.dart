import 'package:contact_scan/utils/app_constants.dart';
import 'package:contact_scan/utils/app_dimensions.dart';
import 'package:contact_scan/utils/color_constants.dart';
import 'package:contact_scan/utils/utility.dart';
import 'package:contact_scan/view/components/rounded_button.dart';
import 'package:contact_scan/view/modules/eventChange/event_change_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/ui_utils.dart';

class EventChangeDialogScreen extends StatelessWidget {
  final EventChangeController _eventChangeController =
      Get.put(EventChangeController());

  EventChangeDialogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenWidth / 6,
          ),
          Container(
            width: screenWidth,
            height: screenHeight / 15,
            color: Colors.grey.withOpacity(0.1),
            child: Center(
              child: Text(
                AppConstants.areYouSure,
                style: TextStyle(
                    color: AppColors.red,
                    fontSize: screenHeight / 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight / 25,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth / 6.5,
            ),
            child: Text(
              AppConstants.eventChangeConfirmation,
              style: TextStyle(
                  color: AppColors.black1617,
                  fontSize: screenHeight / 45,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: screenHeight / 5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth / 10),
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              onTap: () {
                _eventChangeController.clearAllPreference();
                Get.offNamedUntil(Routes.auth, (route) => false);
              },
              child: RoundedButton(
                  color: AppColors.green,
                  buttonName: AppConstants.changeEvent),
            ),
          ),
          UiUtils().gapWidget(height:16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth / 10),
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              onTap: () {
                _eventChangeController.isFromScan.isNotEmpty
                    ? Get.offNamedUntil(Routes.home, (route) => false)
                    : Get.back();
              },
              child: RoundedButton(
                  color: AppColors.red, buttonName: AppConstants.cancel),
            ),
          ),
        ],
      ),
    );
  }
}
