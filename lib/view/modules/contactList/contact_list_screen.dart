import 'package:contact_scan/routes/app_pages.dart';
import 'package:contact_scan/view/components/custom_app_bar.dart';
import 'package:contact_scan/view/modules/contactList/contact_list_controller.dart';
import 'package:contact_scan/utils/app_dimensions.dart';
import 'package:contact_scan/utils/app_fonts.dart';
import 'package:contact_scan/utils/color_constants.dart';
import 'package:contact_scan/utils/image_paths.dart';
import 'package:contact_scan/utils/ui_utils.dart';
import 'package:contact_scan/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/app_constants.dart';
import '../scanScreen/scan_screen_controller.dart';

class ContactListScreen extends StatelessWidget {
  final ContactListController _contactListController =
      Get.find<ContactListController>();

  final ScanScreenController _scanScreenController =
      Get.find<ScanScreenController>();

  ValueSetter<String>? onReset;

  ContactListScreen({Key? key, this.onReset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Obx(
        () => GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(children: [
            SafeArea(
                top: false,
                bottom: false,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.white,
                  appBar: CustomAppBar(),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth,
                        color: _contactListController
                                .filteredContact.value.isNotEmpty
                            ? AppColors.blue13
                            : AppColors.grayBCB,
                        child: GestureDetector(
                          onTap: () {
                            _contactListController
                                    .filteredContact.value.isNotEmpty
                                ? Get.toNamed(Routes.listExport, arguments: {
                                    'contactList': _contactListController
                                        .contactList.value,
                                    'eventName':
                                        _contactListController.eventName,
                                  })
                                : debugPrint("No contact found");
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  ImagePath.fileExport,
                                  color: Colors.white,
                                  height: screenWidth / 20,
                                ),
                                UiUtils().gapWidget(
                                  width: 8,
                                ),
                                Text(
                                  AppConstants.exportList,
                                  textAlign: TextAlign.center,
                                  style: AppFonts.appNameSplash.copyWith(
                                      color: Colors.white,
                                      fontSize: fontSize_20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      _contactListController.filteredContact.value.isNotEmpty ||
                              _contactListController.onTextChange.value
                          ? SingleChildScrollView(
                              child: ScrollConfiguration(
                                behavior: MyBehavior(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    UiUtils()
                                        .gapWidget(height: screenWidth / 20),
                                    searchView(context),
                                    UiUtils()
                                        .gapWidget(height: screenWidth / 22),
                                    Visibility(
                                      visible: _contactListController
                                          .filteredContact.value.isNotEmpty,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppConstants.swipeLeft,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.gray6C,
                                                  fontFamily:
                                                      "helveticaNeueBold"),
                                            ),
                                            Text(
                                              _contactListController
                                                      .filteredContact
                                                      .value
                                                      .length
                                                      .toString() +
                                                  " Contacts",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    UiUtils().gapWidget(height: 8),
                                    contactListView(context),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(
                              height: screenHeight / 1.5,
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    bottom: 8.0, left: 8.0, right: 8.0),
                                child: Center(
                                  child: Text("No Contacts Found",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.black44,
                                          fontSize: 18)),
                                ),
                              ),
                            ),
                    ],
                  ),
                )),
            _contactListController.isLoading.value
                ? Utility.buildProgressIndicator()
                : Container()
          ]),
        ),
      ),
    );
  }

  Widget contactListView(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Slidable(
              key: const ValueKey(1),
              endActionPane: ActionPane(
                dragDismissible: false,
                extentRatio: 0.2,
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(onDismissed: () {}),
                children: [
                  SlidableAction(
                    autoClose: true,
                    backgroundColor: AppColors.deleteRed,
                    foregroundColor: Colors.white,
                    label: 'Delete',
                    onPressed: (context) {
                      _contactListController.deleteContact(
                          _contactListController
                              .filteredContact.value[index].userGUID!);
                    },
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: index == 0
                        ? BorderSide(
                            width: 1,
                            color: AppColors.grayE6,
                          )
                        : BorderSide(color: Colors.transparent),
                    bottom: BorderSide(
                      width: 1,
                      color: AppColors.grayE6,
                    ),
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: _contactListController.filteredContact
                                    .value[index].userFirst!.isNotEmpty ||
                                _contactListController.filteredContact
                                    .value[index].userLast!.isNotEmpty,
                            child: Column(
                              children: [
                                Text(
                                  _contactListController.filteredContact
                                          .value[index].userFirst
                                          .toString() +
                                      " " +
                                      _contactListController
                                          .filteredContact.value[index].userLast
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.black0F,
                                      fontWeight: FontWeight.bold),
                                ),
                                UiUtils().gapWidget(height: 4),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _contactListController.filteredContact
                                .value[index].userPosition!.isNotEmpty,
                            child: Column(
                              children: [
                                Text(
                                  _contactListController
                                      .filteredContact.value[index].userPosition
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.black0F,
                                      fontWeight: FontWeight.bold),
                                ),
                                UiUtils().gapWidget(height: 4),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _contactListController.filteredContact
                                .value[index].userCompany!.isNotEmpty,
                            child: Text(
                              _contactListController
                                  .filteredContact.value[index].userCompany
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.black53,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 8.0, horizontal: 12.0),
                      Padding(
                        padding: _contactListController.filteredContact
                                    .value[index].userPosition!.isEmpty ||
                                _contactListController.filteredContact
                                    .value[index].userCompany!.isEmpty
                            ? const EdgeInsets.all(14)
                            : const EdgeInsets.only(right: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            UiUtils().gapWidget(width: 8),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.contactOptions, arguments: {
                                  'contactData': _contactListController
                                      .filteredContact.value[index]
                                });
                              },
                              splashFactory: NoSplash.splashFactory,
                              highlightColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 21,
                                backgroundColor: AppColors.blue13,
                                child: SvgPicture.asset(
                                  ImagePath.chat,
                                  color: Colors.white,
                                  height: 21,
                                  width: 21,
                                ),
                              ),
                            ),
                            UiUtils().gapWidget(width: 12),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.notes, arguments: {
                                  'contactData': _contactListController
                                      .filteredContact.value[index]
                                })!
                                    .then((value) => {
                                          _contactListController.contactList
                                              .clear(),
                                          _contactListController
                                              .filteredContact.value
                                              .clear(),
                                          _contactListController.getData(),
                                        });
                              },
                              splashFactory: NoSplash.splashFactory,
                              highlightColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 21,
                                backgroundColor: AppColors.green,
                                child: SvgPicture.asset(
                                  ImagePath.pencil,
                                  color: Colors.white,
                                  height: 21,
                                  width: 21,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              ));
        },
        itemCount: _contactListController.filteredContact.value.length,
      ),
    );
  }

  Widget searchView(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UiUtils().gapWidget(width: 12),
        Expanded(
          flex: 7,
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                height: padding_38,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.grayB4, width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    floatingLabelStyle: TextStyle(),
                    contentPadding:
                        EdgeInsets.only(bottom: padding_18, left: padding_12),
                    hintText: AppConstants.searchHint,
                    hintStyle: TextStyle(
                        color: AppColors.grayB4,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (newValue) {
                    Utility.hideKeyboard(context);
                    _contactListController.filterContact(newValue);
                  },
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      _contactListController.onTextChange.value = true;
                    } else {
                      _contactListController.onTextChange.value = false;
                    }
                    _contactListController.filterContact(value);
                  },
                  controller:
                      _contactListController.searchTextEditingController,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: screenHeight / 50,
                      color: AppColors.black,
                      fontWeight: FontWeight.w300),
                  cursorColor: AppColors.black,
                  textInputAction: TextInputAction.search,
                ),
              )),
        ),
        UiUtils().gapWidget(width: 12),
        Expanded(
          flex: 2,
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            onTap: () {
              _contactListController.onTextChange.value = false;
              _contactListController.searchTextEditingController.clear();
              _contactListController.filterContact(
                  _contactListController.searchTextEditingController.text);
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              width: screenWidth / 20,
              height: padding_38,
              decoration: BoxDecoration(
                  color: _contactListController.onTextChange.value
                      ? AppColors.blue
                      : AppColors.grayBCB,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Center(
                  child: Text(
                "Reset",
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ),
        UiUtils().gapWidget(width: 12),
      ],
    );
  }

  _onWillPop() {
    _scanScreenController.isFirstTimeCall = false;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
