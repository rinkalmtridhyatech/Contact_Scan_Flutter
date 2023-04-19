import 'package:contact_scan/utils/app_constants.dart';
import 'package:contact_scan/utils/app_dimensions.dart';
import 'package:contact_scan/utils/app_fonts.dart';
import 'package:contact_scan/utils/color_constants.dart';
import 'package:contact_scan/utils/ui_utils.dart';
import 'package:contact_scan/utils/utility.dart';
import 'package:contact_scan/view/components/custom_app_bar.dart';
import 'package:contact_scan/view/modules/contactList/notes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/rounded_button.dart';

class NotesScreen extends StatelessWidget {
  final NotesController _notesController = Get.put(NotesController());

  NotesScreen({Key? key}) : super(key: key);

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.grayF2,
                        ),
                        height: screenHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                  AppConstants.notes,
                                  textAlign: TextAlign.center,
                                  style: AppFonts.appNameSplash
                                      .copyWith(fontSize: fontSize_17),
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
                            ),
                            UiUtils().gapWidget(height: screenHeight / 16),
                            Text(
                              _notesController.userName.isNotEmpty &&
                                      _notesController
                                          .userPosition.isNotEmpty &&
                                      _notesController.userCompany.isNotEmpty
                                  ? _notesController.userName +
                                      ", " +
                                      _notesController.userPosition +
                                      " - " +
                                      _notesController.userCompany
                                  : _notesController.userName.isNotEmpty &&
                                          _notesController
                                              .userPosition.isNotEmpty
                                      ? _notesController.userName +
                                          ", " +
                                          _notesController.userPosition
                                      : _notesController.userName.isNotEmpty &&
                                              _notesController
                                                  .userCompany.isNotEmpty
                                          ? _notesController.userName +
                                              " - " +
                                              _notesController.userCompany
                                          : _notesController.userName,
                              textAlign: TextAlign.center,
                              style: AppFonts.appNameSplash
                                  .copyWith(fontSize: fontSize_15),
                            ),
                            Flexible(
                              child: TextField(
                                controller:
                                    _notesController.notesTextEditingController,
                                cursorColor: AppColors.black,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: AppColors.grayA3, width: 1.5)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: AppColors.grayA3, width: 1.5)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: AppColors.grayA3, width: 1.5)),
                                ),
                                // expands: true,
                                scrollPhysics: ScrollPhysics(),
                                minLines: 16,
                                maxLines: 16,
                              ).paddingSymmetric(vertical: 20, horizontal: 28),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth / 3.2,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Utility.hideKeyboard(context);
                                  _notesController.updateNotes(
                                      _notesController
                                          .notesTextEditingController.text
                                          .toString(),
                                      _notesController.data.userGUID
                                          .toString());
                                  Utility().snackBar(
                                      AppConstants.notesSaved, context);
                                  Future.delayed(
                                      const Duration(
                                          seconds: 1, milliseconds: 45), () {
                                    Get.back();
                                  });
                                },
                                child: RoundedButton(
                                    color: AppColors.green13,
                                    buttonName: AppConstants.save),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
      _notesController.isLoading.value
          ? Utility.buildProgressIndicator()
          : Container()
    ]);
  }
}
