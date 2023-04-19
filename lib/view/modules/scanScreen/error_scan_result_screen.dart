import 'package:contact_scan/utils/app_dimensions.dart';
import 'package:contact_scan/utils/color_constants.dart';
import 'package:contact_scan/utils/utility.dart';
import 'package:contact_scan/view/components/custom_app_bar.dart';
import 'package:contact_scan/view/modules/scanScreen/scan_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_fonts.dart';
import '../../../utils/image_paths.dart';
import '../../../utils/ui_utils.dart';
import 'error_scan_result_controller.dart';

class ErrorScanResultScreen extends StatelessWidget {
  final ErrorScanResultController _errorScanResultController =
      Get.put(ErrorScanResultController());

  final ScanScreenController scanScreenController =
      Get.put(ScanScreenController());

  ErrorScanResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white,
        child: SafeArea(
            top: false,
            bottom: false,
            child: GestureDetector(
              onTap: () {
                Utility.hideKeyboard(context);
              },
              child: Scaffold(
                backgroundColor: AppColors.white,
                appBar: CustomAppBar(),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth,
                        color: AppColors.grayF5,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _errorScanResultController
                                        .isEventNotAuthorized.value
                                    ? AppConstants.notActivated.toUpperCase()
                                    : AppConstants.uhOh,
                                textAlign: TextAlign.center,
                                style: _errorScanResultController
                                        .isEventNotAuthorized.value
                                    ? AppFonts.scanResultHeading
                                        .copyWith(color: AppColors.red)
                                    : AppFonts.scanResultHeading,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _errorScanResultController.isForEmail.value,
                        child: Column(
                          children: [
                            SizedBox(height: screenWidth / 8),
                            Text(
                              AppConstants.somethingIsUp,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.black44,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "HelveticaNeueLight",
                                  fontSize: fontSize_24),
                            ),
                            SizedBox(height: screenWidth / 8),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !_errorScanResultController.isForEmail.value,
                        child: SizedBox(
                          height: screenWidth / 5,
                        ),
                      ),
                      SvgPicture.asset(
                        _errorScanResultController.isEventNotAuthorized.value
                            ? ImagePath.unCheckedSvg
                            : ImagePath.questionMark,
                        width: screenWidth / 1.7,
                        height: screenWidth / 1.7,
                      ),
                      SizedBox(
                        height: screenWidth / 12,
                      ),
                      Visibility(
                        visible: _errorScanResultController
                            .isEventNotAuthorized.value,
                        child: Text(
                          AppConstants.hostNotActivated,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.black44,
                              fontFamily: "HelveticaNeueMedium",
                              fontSize: screenWidth / 32),
                        ),
                      ),
                      Visibility(
                        visible:
                            _errorScanResultController.isForWrongScan.value,
                        child: Text(
                          AppConstants.scanError,
                          textAlign: TextAlign.center,
                          style: AppFonts.scanResultHeading.copyWith(
                              color: AppColors.red, fontSize: fontSize_20),
                        ),
                      ),
                      Visibility(
                        visible:
                            _errorScanResultController.isForWrongScan.value ||
                                _errorScanResultController.isForEmail.value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: screenWidth / 16,
                            horizontal: screenWidth / 8,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: AppColors.grayF5,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenWidth / 40,
                                  horizontal: screenWidth / 16),
                              child: Text(
                                _errorScanResultController.isForWrongScan.value
                                    ? AppConstants.inValidQrCodeString
                                    : AppConstants.noInternetForEmail,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: AppColors.black44,
                                    fontFamily: "HelveticaNeueMedium",
                                    fontSize: screenWidth / 32),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _errorScanResultController.isForEmail.value,
                        child: roundedButton(() {
                          Get.back();
                        }, AppConstants.tryAgain, AppColors.black,
                            screenWidth / 3),
                      ),
                      Visibility(
                        visible:
                            _errorScanResultController.isForWrongScan.value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            roundedButton(() {
                              Get.offNamed(Routes.changeEventDialog,
                                  arguments: {'isFromScan': 'true'});
                            }, AppConstants.changeEventCaps, AppColors.redB6,
                                screenWidth / 2.7),
                            UiUtils().gapWidget(width: 18),
                            roundedButton(() {
                              Get.offNamedUntil(Routes.home, (route) => false)
                                  ?.then((value) => {
                                        scanScreenController.isFirstTimeCall =
                                            false,
                                        scanScreenController.controller
                                            ?.pauseCamera(),
                                      });
                            }, AppConstants.tryAgain, AppColors.black,
                                screenWidth / 2.7),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
      _errorScanResultController.isLoading.value
          ? Utility.buildProgressIndicator()
          : Container()
    ]);
  }

  Widget roundedButton(
      Function onPressFunction, String buttonName, Color color, double width) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      onTap: () {
        onPressFunction();
      },
      child: Container(
        width: width,
        height: screenHeight / 18,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(23))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonName,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: fontSize_16,
                  color: AppColors.white),
            )
          ],
        ),
      ),
    );
  }
}
