import 'package:contact_scan/utils/app_constants.dart';
import 'package:contact_scan/utils/app_dimensions.dart';
import 'package:contact_scan/utils/color_constants.dart';
import 'package:contact_scan/utils/utility.dart';
import 'package:contact_scan/view/components/app_bar_simple.dart';
import 'package:contact_scan/view/components/auth_app_bar.dart';
import 'package:contact_scan/view/components/text_field.dart';
import 'package:contact_scan/view/modules/auth/event_auth_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../components/rounded_button.dart';

class EventAuth extends StatelessWidget {
  EventAuth({Key? key}) : super(key: key);

  final EventAuthController _eventAuthController =
      Get.put(EventAuthController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    return Obx(
      () {
        return Stack(
          children: [
            Container(
              color: Colors.white,
              child: SafeArea(
                bottom: false,
                child: GestureDetector(
                  onTap: () {
                    Utility.hideKeyboard(context);
                  },
                  child: Scaffold(
                    appBar: AuthAppBar(),
                    backgroundColor: Colors.white,
                    body: SingleChildScrollView(
                      child: Form(
                        key: _eventAuthController.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _eventAuthController.isFromDrawer == "true"
                                ? AppBarSimple()
                                : SizedBox(
                                    height: 2,
                                  ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 14),
                              child: Text(
                                AppConstants.selectEventHost,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.black53,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: _eventAuthController.isFromDrawer == "true"
                                  ? Container(
                                      width: screenWidth,
                                      height: screenHeight / 20,
                                      decoration: const BoxDecoration(
                                          color: AppColors.gray949599,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0, right: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _eventAuthController
                                                  .dropDownValue.value,
                                              style: TextStyle(
                                                  fontSize: screenHeight / 50,
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Icon(
                                              Icons.arrow_drop_down,
                                              color: AppColors.white,
                                              size: screenHeight / 25,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : _eventAuthController.hostNameList.length !=
                                          0
                                      ? Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: AppColors.gray949599,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: Listener(
                                            onPointerDown: (_) =>
                                                FocusScope.of(context)
                                                    .unfocus(),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2<String>(
                                                isExpanded: true,
                                                icon: Icon(
                                                  Icons.arrow_drop_down,
                                                  color: AppColors.white,
                                                  size: screenHeight / 18,
                                                ),
                                                value: _eventAuthController
                                                            .dropDownValue
                                                            .value !=
                                                        ""
                                                    ? _eventAuthController
                                                        .dropDownValue.value
                                                    : _eventAuthController
                                                        .hostNameList[0],
                                                selectedItemBuilder:
                                                    (BuildContext context) {
                                                  return _eventAuthController
                                                      .hostNameList
                                                      .map((value) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .centerStart,
                                                        child: Text(
                                                          _eventAuthController
                                                              .dropDownValue
                                                              .value,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList();
                                                },
                                                items: _eventAuthController
                                                    .hostNameList
                                                    .map<
                                                        DropdownMenuItem<
                                                            String>>((value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16.0,
                                                              right: 6),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            value,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    screenHeight /
                                                                        50,
                                                                color: AppColors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                 onChanged: _eventAuthController
                                                            .isFromDrawer ==
                                                        "true"
                                                    ? null
                                                    : (value) {
                                                        _eventAuthController
                                                                .dropDownValue
                                                                .value =
                                                            value.toString();
                                                      },
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 28, right: 28, top: 28, bottom: 8),
                              child: Text(
                                AppConstants.accessScanner,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.black53,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 4),
                              child: Column(
                                children: [
                                  Text(
                                    AppConstants.eventIdDesc,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.gray949599,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: screenWidth / 22,
                                  ),
                                  TextFieldWidget(
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(10),
                                    ],
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enabled:
                                        _eventAuthController.isFromDrawer ==
                                                "true"
                                            ? false
                                            : true,
                                    inputType: TextInputType.visiblePassword,
                                    controller:
                                        _eventAuthController.eventIdController,
                                    isObscureText: false,
                                    hintText: AppConstants.eventIdHint,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return AppConstants.emptyValueEventId;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  TextFieldWidget(
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(10),
                                    ],
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enabled:
                                        _eventAuthController.isFromDrawer ==
                                                "true"
                                            ? false
                                            : true,
                                    inputType: TextInputType.visiblePassword,
                                    controller:
                                        _eventAuthController.authCodeController,
                                    isObscureText: true,
                                    hintText: AppConstants.eventCodeHint,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return AppConstants
                                            .emptyValueAuthorizationCode;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  InkWell(
                                    splashFactory: NoSplash.splashFactory,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Utility.hideKeyboard(context);
                                      _eventAuthController.isFromDrawer ==
                                              "true"
                                          ? Get.offNamed(
                                              Routes.changeEventDialog,
                                              arguments: {'isFromScan': ''})
                                          : _eventAuthController.validate();
                                    },
                                    child: _eventAuthController.isFromDrawer ==
                                            "true"
                                        ? RoundedButton(
                                            color: AppColors.red,
                                            buttonName:
                                                AppConstants.changeEvent)
                                        : RoundedButton(
                                            color: AppColors.black44,
                                            buttonName: AppConstants.authorize),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _eventAuthController.isLoading.value
                ? Utility.buildProgressIndicator()
                : Container()
          ],
        );
      },
    );
  }
}
