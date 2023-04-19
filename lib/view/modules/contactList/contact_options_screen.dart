import 'package:contact_scan/view/components/custom_app_bar.dart';
import 'package:contact_scan/view/modules/contactList/contact_options_controller.dart';
import 'package:contact_scan/utils/app_constants.dart';
import 'package:contact_scan/utils/app_dimensions.dart';
import 'package:contact_scan/utils/app_fonts.dart';
import 'package:contact_scan/utils/call_messages_service.dart';
import 'package:contact_scan/utils/color_constants.dart';
import 'package:contact_scan/utils/image_paths.dart';
import 'package:contact_scan/utils/ui_utils.dart';
import 'package:contact_scan/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ContactOptionsScreen extends StatelessWidget {
  final ContactOptionsController _contactOptionsController =
      Get.put(ContactOptionsController());

  ContactOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white,
        child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar: CustomAppBar(),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.grayF2,
                      ),
                      child: Column(
                        children: [
                          UiUtils().gapWidget(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.close_rounded,
                                color: AppColors.grayF2,
                                size: screenHeight / 20,
                              ),
                              Text(
                                AppConstants.contacts,
                                textAlign: TextAlign.center,
                                style: AppFonts.appNameSplash
                                    .copyWith(fontSize: fontSize_18),
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.close_rounded,
                                  color: AppColors.gray85,
                                  size: screenHeight / 20,
                                ).paddingOnly(right: 16),
                              ),
                            ],
                          ).paddingOnly(bottom: 10),
                          Container(
                            height: screenWidth / 5,
                            child: Center(
                              child: Text(
                                AppConstants.contactOptions,
                                textAlign: TextAlign.center,
                                style: AppFonts.headLineHome.copyWith(color: AppColors.gray85),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              border: Border.all(
                                color: AppColors.grayA3,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ).paddingSymmetric(horizontal: screenWidth / 6),
                          UiUtils().gapWidget(height: screenHeight / 20),
                          Text(
                            _contactOptionsController.userName.isNotEmpty
                                ? _contactOptionsController.userName
                                : "",
                            textAlign: TextAlign.center,
                            style: AppFonts.appNameSplash
                                .copyWith(fontSize: fontSize_20),
                          ).paddingOnly(bottom: 6),
                          Visibility(
                              visible: _contactOptionsController
                                      .userPosition.isEmpty &&
                                  _contactOptionsController.userCompany.isEmpty,
                              child: UiUtils().gapWidget(height: 18)),
                          Visibility(
                            visible: _contactOptionsController
                                    .userPosition.isNotEmpty ||
                                _contactOptionsController
                                    .userCompany.isNotEmpty,
                            child: Text(
                              _contactOptionsController
                                          .userPosition.isNotEmpty &&
                                      _contactOptionsController
                                          .userCompany.isNotEmpty
                                  ? _contactOptionsController.userPosition +
                                      " - " +
                                      _contactOptionsController.userCompany
                                  : _contactOptionsController
                                          .userPosition.isNotEmpty
                                      ? _contactOptionsController.userPosition
                                      : _contactOptionsController
                                              .userCompany.isNotEmpty
                                          ? _contactOptionsController
                                              .userCompany
                                          : _contactOptionsController.userName,
                              textAlign: TextAlign.center,
                              style: AppFonts.appNameSplash
                                  .copyWith(fontSize: fontSize_20),
                            ).paddingOnly(bottom: screenWidth / 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: _contactOptionsController
                                    .mobileNumber.isNotEmpty,
                                child: Row(
                                  children: [
                                    option(() {
                                      CallsAndMessagesService().sendSMS(
                                          _contactOptionsController
                                              .mobileNumber);
                                    }, ImagePath.chat, "SMS"),
                                    UiUtils()
                                        .gapWidget(width: screenWidth / 16),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: _contactOptionsController
                                    .mobileNumber.isNotEmpty,
                                child: Row(
                                  children: [
                                    option(() {
                                      CallsAndMessagesService().makePhoneCall(
                                          _contactOptionsController
                                              .mobileNumber);
                                    }, ImagePath.mobile, "Call"),
                                    UiUtils()
                                        .gapWidget(width: screenWidth / 16),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: _contactOptionsController
                                    .emailId.isNotEmpty,
                                child: option(() {
                                  CallsAndMessagesService().sendEmail(
                                      _contactOptionsController.emailId);
                                }, ImagePath.email, "Email"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
      _contactOptionsController.isLoading.value
          ? Utility.buildProgressIndicator()
          : Container()
    ]);
  }

  Widget option(
    Function onPressFunction,
    String imagePath,
    String name,
  ) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      onTap: () {
        onPressFunction != null ? onPressFunction() : null;
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: screenWidth / 10,
            backgroundColor: AppColors.blue,
            child: SvgPicture.asset(
              imagePath,
              color: Colors.white,
              height: screenWidth / 10,
              width: screenWidth / 10,
            ),
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: AppFonts.appNameSplash.copyWith(fontSize: fontSize_16),
          ).paddingOnly(top: 8),
        ],
      ),
    );
  }
}
