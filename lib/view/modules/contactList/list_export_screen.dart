import 'package:contact_scan/view/components/custom_app_bar.dart';
import 'package:contact_scan/view/components/rounded_button.dart';
import 'package:contact_scan/view/components/text_field.dart';
import 'package:contact_scan/view/modules/contactList/list_export_controller.dart';
import 'package:contact_scan/utils/app_constants.dart';
import 'package:contact_scan/utils/app_dimensions.dart';
import 'package:contact_scan/utils/app_fonts.dart';
import 'package:contact_scan/utils/color_constants.dart';
import 'package:contact_scan/utils/ui_utils.dart';
import 'package:contact_scan/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ListExportScreen extends StatelessWidget {
  final ListExportController _listExportController =
      Get.put(ListExportController());

  ListExportScreen({Key? key}) : super(key: key);

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
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: CustomAppBar(),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth,
                        color: AppColors.grayF5,
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            AppConstants.emailList,
                            textAlign: TextAlign.center,
                            style: AppFonts.appNameSplash
                                .copyWith(fontSize: fontSize_22),
                          ),
                        ),
                      ),
                      UiUtils().gapWidget(
                        height: screenHeight / 50,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth / 10,
                            vertical: screenWidth / 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppConstants.sendCsv,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.black53,
                                  fontWeight: FontWeight.bold),
                            ),
                            UiUtils().gapWidget(
                              height: 6,
                            ),
                            Form(
                              key: _listExportController.formKey,
                              child: TextFieldWidget(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                inputType: TextInputType.text,
                                controller:
                                    _listExportController.recipientController,
                                isObscureText: false,
                                hintText: AppConstants.emailAddress,
                                validator: (value) {
                                  if (!GetUtils.isEmail(value!)) {
                                    return AppConstants.validEmail;
                                  }
                                  if (value.isEmpty) {
                                    return AppConstants.emailAddressEmpty;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            UiUtils().gapWidget(
                              height: screenWidth / 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth / 16,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child:  InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: RoundedButton(
                                          color: AppColors.grayBCB,
                                          buttonName: AppConstants.cancelEmail),
                                    ),
                                  ),
                                  UiUtils().gapWidget(
                                    width: 6,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      splashFactory: NoSplash.splashFactory,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        _listExportController.validate();
                                      },
                                      child: RoundedButton(
                                          color: AppColors.green13,
                                          buttonName: AppConstants.sendEmail),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
      _listExportController.isLoading.value
          ? Utility.buildProgressIndicator()
          : Container()
    ]);
  }
}
