import 'package:contact_scan/utils/app_constants.dart';
import 'package:contact_scan/utils/app_dimensions.dart';
import 'package:contact_scan/utils/app_fonts.dart';
import 'package:contact_scan/utils/color_constants.dart';
import 'package:contact_scan/utils/ui_utils.dart';
import 'package:contact_scan/utils/utility.dart';
import 'package:contact_scan/view/components/custom_app_bar.dart';
import 'package:contact_scan/view/modules/scanScreen/scan_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../utils/image_paths.dart';

class ScanScreen extends StatelessWidget {
  ScanScreen({Key? key}) : super(key: key);

  final ScanScreenController scanScreenController =
      Get.put(ScanScreenController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    return Obx(
      () => Stack(children: [
        Container(
          color: Colors.white,
          child: SafeArea(
              top: false,
              bottom: false,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: CustomAppBar(),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: scanScreenController.eventName.isNotEmpty,
                            child: Container(
                              width: screenWidth,
                              color: AppColors.grayF5,
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  scanScreenController.eventName.value,
                                  textAlign: TextAlign.center,
                                  style: AppFonts.headLineHome,
                                ),
                              ),
                            ),
                          ),
                          UiUtils().gapWidget(height: screenWidth / 4),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenWidth / 18,
                                horizontal: screenWidth / 12),
                            child: Center(
                              child: Text(
                                AppConstants.scanAttendeesBadge,
                                style: AppFonts.headLineHome
                                    .copyWith(color: AppColors.gray949599),
                              ),
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              SizedBox(
                                  height: screenHeight / 2.5,
                                  child: _buildQrView()),
                              Center(
                                child: Container(
                                  height: screenHeight / 2.5,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset(
                                        ImagePath.scanLeft,
                                        height: screenHeight / 3,
                                      ),
                                      Visibility(
                                        visible: scanScreenController
                                            .isScannedData.value,
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: AppColors.blue,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    AppColors.white),
                                          ),
                                        ),
                                      ),
                                      Image.asset(
                                        ImagePath.scanRight,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: screenHeight / 50,
                      ),
                    ],
                  ),
                ),
              )),
        ),
        scanScreenController.isLoading.value
            ? Utility.buildProgressIndicator()
            : Container()
      ]),
    );
  }

  Widget _buildQrView() {
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: scanScreenController.qrKey,
      onQRViewCreated: scanScreenController.onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.transparent, cutOutSize: screenHeight / 2),
      onPermissionSet: (ctrl, p) =>
          scanScreenController.onPermissionSet(ctrl, p),
    );
  }
}
