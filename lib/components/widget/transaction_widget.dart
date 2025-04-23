import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pr_budget_tracker/controller/category_controller.dart';
import 'package:pr_budget_tracker/controller/expense_controller.dart';
import 'package:pr_budget_tracker/controller/transaction_controller.dart';
import 'package:pr_budget_tracker/modal/category_modal.dart';
import 'package:pr_budget_tracker/modal/expense_modal.dart';
import 'package:pr_budget_tracker/modal/income_modal.dart';
import 'package:pr_budget_tracker/utils/extensions/sizedbox_extension.dart';

TextEditingController transNameController = TextEditingController();
TextEditingController transAmtController = TextEditingController();
// TextEditingController transCategoryController = TextEditingController();
TextEditingController transDescController = TextEditingController();

// TransactionController controller = Get.put(TransactionController());
// final CategoryController categoryController = Get.put(CategoryController());

Widget TransactionTile({
  required TransactionController controller,
  required CategoryController categoryController,
  required ExpenseController expController,
  required int onPressedIndex,
  required Size size,
  required String type,
  required BuildContext ctx,
}) {
  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.all(14),
        child: GetBuilder<TransactionController>(
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  4.h,
                  //Transaction name
                  TextFormField(
                    controller: transNameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: Colors.white),
                      labelText: 'Transaction Name',
                      labelStyle: TextStyle(color: Colors.white70),
                      hintText: 'Enter Transaction Name...',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff9795E5)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  14.h,
                  //Amount
                  TextFormField(
                    controller: transAmtController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: Colors.white),
                      labelText: 'Transaction Amount',
                      labelStyle: TextStyle(color: Colors.white70),
                      hintText: 'Enter Transaction amount...',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff9795E5)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  10.h,
                  //Mode
                  Obx(
                    () => Row(
                      children: [
                        Text(
                          "Mode: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        15.w,
                        DropdownButton(
                          value: controller.mode.value,
                          borderRadius: BorderRadius.circular(10),
                          selectedItemBuilder: (context) {
                            return ['Cash', 'Card', 'Digital']
                                .map(
                                  (e) => Center(
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                                .toList();
                          },
                          iconEnabledColor: Colors.white,
                          hint: Text(
                            "Select Mode",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'cash',
                              child: Text("Cash"),
                            ),
                            DropdownMenuItem(
                              value: 'card',
                              child: Text("Card"),
                            ),
                            DropdownMenuItem(
                              value: 'digital',
                              child: Text("Digital"),
                            ),
                          ],
                          onChanged: (value) {
                            controller.changeMode(value.toString());
                          },
                        ),
                      ],
                    ),
                  ),
                  10.h,

                  //Select category
                  Obx(() {
                    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    // categoryController.validValueOfCategory(type);
                    // });
                    return Row(
                      children: [
                        Text(
                          "Category: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        15.w,
                        DropdownButton(
                          alignment: Alignment(0, 0),
                          hint: Text(
                            "Select Category",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          iconEnabledColor: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          value: type == 'income'
                              ? categoryController.selectedIncCategory?.value
                              : categoryController.selectedExpCategory?.value,
                          selectedItemBuilder: (context) {
                            return categoryController.allCategory
                                .where((element) => element.type == type)
                                .toList()
                                .map((CategoryModal e) {
                              return Row(
                                children: [
                                  CircleAvatar(
                                    radius: 13,
                                    backgroundImage: AssetImage(e.image!),
                                  ),
                                  8.w,
                                  Text(
                                    e.name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              );
                            }).toList();
                          },
                          items: categoryController.allCategory
                              .where((element) => element.type == type)
                              .toList()
                              // .any(
                              //   (element) =>
                              //       element.name ==
                              //       categoryController
                              //           .selectedIncCategory
                              //           ?.value,
                              // ).toString(),
                              .map((CategoryModal e) {
                            return DropdownMenuItem<String>(
                              value: e.name,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 13,
                                    backgroundImage: AssetImage(
                                      e.image!,
                                    ),
                                  ),
                                  8.w,
                                  Text(e.name),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            categoryController.changeSelectedCategory(
                              value.toString(),
                              type,
                            );
                            log('$value');
                          },
                        ),
                      ],
                    );
                  }),
                  14.h,
                  //Description
                  TextFormField(
                    controller: transDescController,
                    maxLines: 2,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: Colors.white),
                      labelText: 'Description(optional)',
                      labelStyle: TextStyle(color: Colors.white70),
                      hintText: 'Enter Transaction Description...',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff9795E5)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      Positioned(
        bottom: 10,
        right: 10,
        child: FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(255, 147, 203, 249),
          onPressed: () async {
            if ((type == 'income'
                        ? categoryController.selectedIncCategory
                        : categoryController.selectedExpCategory) !=
                    null &&
                controller.mode.value != null) {
              var inx = categoryController.allCategory.indexWhere(
                (element) => type == 'income'
                    ? element.name ==
                        categoryController.selectedIncCategory!.value
                    : element.name ==
                        categoryController.selectedExpCategory!.value,
              );
              log("Image index: $inx");

              String path = categoryController.allCategory[inx].image!;
              log('Image path: $path');
              ByteData byteData = await rootBundle.load(path);
              Uint8List image = byteData.buffer.asUint8List();
              if (onPressedIndex == 1) {
                await controller.insertIncomeRecord(
                  model: IncomeModal(
                    id: 0,
                    name: transNameController.text,
                    amount: num.parse(transAmtController.text),
                    mode: controller.mode.value!,
                    categoryName: type == 'income'
                        ? categoryController.selectedIncCategory!.value!
                        : categoryController.selectedExpCategory!.value!,
                    desc: transDescController.text,
                    image: image,
                  ),
                );
                transAmtController.clear();
                transDescController.clear();
                transNameController.clear();
                controller.mode.value = null;
                type == 'income'
                    ? categoryController.selectedIncCategory?.value = null
                    : categoryController.selectedExpCategory?.value = null;
              } else if (onPressedIndex == 2) {
                await expController.insertExpRecord(
                  modal: ExpenseModal(
                    id: 0,
                    name: transNameController.text,
                    amount: num.parse(transAmtController.text),
                    mode: controller.mode.value!,
                    categoryName: type == 'income'
                        ? categoryController.selectedIncCategory!.value!
                        : categoryController.selectedExpCategory!.value!,
                    desc: transDescController.text,
                    image: image,
                  ),
                );

                transAmtController.clear();
                transDescController.clear();
                transNameController.clear();
                controller.mode.value = null;
                type == 'income'
                    ? categoryController.selectedIncCategory?.value = null
                    : categoryController.selectedExpCategory?.value = null;
              }

              log('records inserted');
            } else {
              Get.snackbar(
                'Error',
                'Please enter all details',
                backgroundColor: Colors.red,
              );
            }
          },
          icon: Icon(Icons.save, color: Colors.black),
          label: Text(
            "SAVE",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    ],
  );
}
