import 'dart:developer';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pr_budget_tracker/controller/category_controller.dart';
import 'package:pr_budget_tracker/controller/expense_controller.dart';
import 'package:pr_budget_tracker/controller/transaction_controller.dart';
import 'package:pr_budget_tracker/modal/category_modal.dart';
import 'package:pr_budget_tracker/modal/expense_modal.dart';
import 'package:pr_budget_tracker/utils/extensions/sizedbox_extension.dart';
import 'package:pr_budget_tracker/utils/extensions/titlecase_extension.dart';

TextEditingController expNameController = TextEditingController();
TextEditingController expAmtController = TextEditingController();
TextEditingController expDescController = TextEditingController();
GlobalKey<FormState> expEditKey = GlobalKey<FormState>();

class ExpenseComponent extends StatelessWidget {
  const ExpenseComponent({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    CategoryController cateController = Get.put(
      // tag: 'categoryController1',
      CategoryController(),
    );
    TransactionController transactionController =
        Get.put(TransactionController());

    ExpenseController expController = Get.put(ExpenseController());

    expController.fetchExpRecord();
    expController.fetchTotalExpRecord();
    expController.fetchPiDataCatExp();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            height: size.height * 0.065,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.only(left: 20),
            child: TextFormField(
              // controller: searchExpController,
              autocorrect: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search...",
              ),
              onChanged: (value) {
                expController.SearchExpenseRec(expName: value);
              },
            ),
          ),
          12.h,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.34,
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GetBuilder<ExpenseController>(
                      builder: (context) {
                        var data = expController.fetchPiDataExp ?? [];
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: size.height * 0.32,
                              child: PieChart(
                                PieChartData(
                                  sections: List.generate(data.length, (index) {
                                    return PieChartSectionData(
                                      // showTitle: false,
                                      value: double.parse(
                                        data[index]['TOTAL'].toString(),
                                      ),
                                      title: data[index]['exp_category']
                                          .toString(),
                                      color: Colors.primaries[index % 18],

                                      titleStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            // Text("Total Income \n ${transactionController.totalIcome}"),
                            Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text: "Total Expense\n",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "\u{20B9}${expController.totalExpenses}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // : Center(),
                  14.h,
                  Text(
                    "Transactions",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  10.h,

                  GetBuilder<ExpenseController>(
                    builder: (context) {
                      return FutureBuilder(
                        future: expController.allExp,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            Center(child: Text("ERROR${snapshot.error}"));
                          } else if (snapshot.hasData) {
                            List<ExpenseModal> allExpData = snapshot.data ?? [];
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: allExpData.length,
                              itemBuilder: (context, index) {
                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          expNameController.text =
                                              allExpData[index].name;
                                          expAmtController.text =
                                              allExpData[index]
                                                  .amount
                                                  .toString();
                                          expDescController.text =
                                              allExpData[index].desc;
                                          transactionController.mode.value =
                                              allExpData[index].mode;
                                          cateController
                                                  .selectedIncCategory?.value =
                                              allExpData[index].categoryName;

                                          Get.bottomSheet(
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(22),
                                                  topLeft: Radius.circular(22),
                                                ),
                                              ),
                                              child: Form(
                                                key: expEditKey,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      //Name
                                                      TextFormField(
                                                        controller:
                                                            expNameController,
                                                        validator: (value) =>
                                                            value!.isEmpty
                                                                ? "Name is required..."
                                                                : null,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Transaction Name',
                                                          labelStyle: TextStyle(
                                                            color: Color(
                                                              0xff1937FE,
                                                            ).withOpacity(0.7),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                0xff1937FE,
                                                              ).withOpacity(
                                                                0.4,
                                                              ),
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                0xff9795E5,
                                                              ),
                                                            ),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      10.h,
                                                      //Amount
                                                      TextFormField(
                                                        controller:
                                                            expAmtController,
                                                        validator: (value) =>
                                                            value!.isEmpty
                                                                ? "Amount is required..."
                                                                : null,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Transaction Amount',
                                                          labelStyle: TextStyle(
                                                            color: Color(
                                                              0xff1937FE,
                                                            ).withOpacity(0.7),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                0xff1937FE,
                                                              ).withOpacity(
                                                                0.4,
                                                              ),
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                0xff9795E5,
                                                              ),
                                                            ),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors.red,
                                                            ),
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
                                                                color: Color(
                                                                  0xff1937FE,
                                                                ).withOpacity(
                                                                  0.7,
                                                                ),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            15.w,
                                                            DropdownButton(
                                                              value:
                                                                  transactionController
                                                                      .mode
                                                                      .value,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10,
                                                              ),
                                                              iconEnabledColor:
                                                                  Color(
                                                                0xff1937FE,
                                                              ).withOpacity(
                                                                0.7,
                                                              ),
                                                              hint: Text(
                                                                "Select Mode",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                    0xff1937FE,
                                                                  ).withOpacity(
                                                                    0.7,
                                                                  ),
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              items: [
                                                                DropdownMenuItem(
                                                                  value: 'cash',
                                                                  child: Text(
                                                                    "Cash",
                                                                  ),
                                                                ),
                                                                DropdownMenuItem(
                                                                  value: 'card',
                                                                  child: Text(
                                                                    "Card",
                                                                  ),
                                                                ),
                                                                DropdownMenuItem(
                                                                  value:
                                                                      'digital',
                                                                  child: Text(
                                                                    "Digital",
                                                                  ),
                                                                ),
                                                              ],
                                                              onChanged: (
                                                                value,
                                                              ) {
                                                                transactionController
                                                                    .changeMode(
                                                                  value
                                                                      .toString(),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      10.h,
                                                      //Cat
                                                      Obx(
                                                        () => Row(
                                                          children: [
                                                            Text(
                                                              "Category: ",
                                                              style: TextStyle(
                                                                color: Color(
                                                                  0xff1937FE,
                                                                ).withOpacity(
                                                                  0.7,
                                                                ),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            15.w,
                                                            DropdownButton(
                                                              alignment:
                                                                  Alignment(
                                                                0,
                                                                0,
                                                              ),
                                                              iconEnabledColor:
                                                                  Color(
                                                                0xff1937FE,
                                                              ).withOpacity(
                                                                0.7,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10,
                                                              ),
                                                              value: cateController
                                                                  .selectedIncCategory
                                                                  ?.value,
                                                              items:
                                                                  cateController
                                                                      .allCategory
                                                                      .map((
                                                                CategoryModal e,
                                                              ) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  value: e.name,
                                                                  child: Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        radius:
                                                                            13,
                                                                        backgroundImage:
                                                                            AssetImage(
                                                                          e.image!,
                                                                        ),
                                                                      ),
                                                                      8.w,
                                                                      Text(
                                                                        e.name,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }).toList(),
                                                              onChanged: (
                                                                value,
                                                              ) {
                                                                cateController
                                                                    .changeSelectedCategory(
                                                                  value
                                                                      .toString(),
                                                                  'income',
                                                                );
                                                                log('$value');
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      10.h,
                                                      //Description
                                                      TextFormField(
                                                        controller:
                                                            expDescController,
                                                        // validator: (value) => value!
                                                        //         .isEmpty
                                                        //     ? "Description is required..."
                                                        //     : null,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Transaction Description',
                                                          labelStyle: TextStyle(
                                                            color: Color(
                                                              0xff1937FE,
                                                            ).withOpacity(0.7),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                0xff1937FE,
                                                              ).withOpacity(
                                                                0.4,
                                                              ),
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                0xff9795E5,
                                                              ),
                                                            ),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      15.h,
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          if (expEditKey
                                                                  .currentState!
                                                                  .validate() &&
                                                              cateController
                                                                      .selectedIncCategory !=
                                                                  null &&
                                                              transactionController
                                                                      .mode
                                                                      .value !=
                                                                  null) {
                                                            var inx =
                                                                cateController
                                                                    .allCategory
                                                                    .indexWhere(
                                                              (element) =>
                                                                  element
                                                                      .name ==
                                                                  cateController
                                                                      .selectedIncCategory!
                                                                      .value,
                                                            );
                                                            log(
                                                              "Image index: $inx",
                                                            );

                                                            String path =
                                                                cateController
                                                                    .allCategory[
                                                                        inx]
                                                                    .image!;
                                                            log(
                                                              'Image path: $path',
                                                            );
                                                            ByteData byteData =
                                                                await rootBundle
                                                                    .load(path);
                                                            Uint8List image =
                                                                byteData.buffer
                                                                    .asUint8List();
                                                            expController
                                                                .updateExpRecord(
                                                              modal:
                                                                  ExpenseModal(
                                                                id: allExpData[
                                                                        index]
                                                                    .id,
                                                                name:
                                                                    expNameController
                                                                        .text,
                                                                amount:
                                                                    num.parse(
                                                                  expAmtController
                                                                      .text,
                                                                ),
                                                                mode:
                                                                    transactionController
                                                                        .mode
                                                                        .value!,
                                                                categoryName:
                                                                    cateController
                                                                        .selectedIncCategory!
                                                                        .value!,
                                                                desc:
                                                                    expDescController
                                                                        .text,
                                                                image: image,
                                                              ),
                                                            );

                                                            Get.back();

                                                            expAmtController
                                                                .clear();
                                                            expNameController
                                                                .clear();
                                                            expDescController
                                                                .clear();
                                                            // transNameController.clear();
                                                            transactionController
                                                                .mode
                                                                .value = null;
                                                            cateController
                                                                .selectedIncCategory
                                                                ?.value = null;
                                                          } else {
                                                            Get.snackbar(
                                                              'Error',
                                                              'Please enter all details',
                                                              backgroundColor:
                                                                  Colors.red,
                                                            );
                                                          }
                                                        },
                                                        child: Text("SAVE"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        backgroundColor: Colors.green,
                                        padding: EdgeInsets.all(16),
                                        borderRadius: BorderRadius.circular(12),
                                        label: "Edit",
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          print('${allExpData[index].id}');
                                          expController.deleteExpRecord(
                                            id: allExpData[index].id,
                                          );
                                        },
                                        backgroundColor: Colors.red,
                                        padding: EdgeInsets.all(16),
                                        borderRadius: BorderRadius.circular(12),
                                        label: "Delete",
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: MemoryImage(
                                          allExpData[index].image,
                                        ),
                                      ),
                                      title: Text(
                                        "${allExpData[index].name.tcase}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "\u{20B9} ${allExpData[index].amount}",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      trailing: ActionChip(
                                        color: WidgetStatePropertyAll(
                                            Colors.blue.shade400),
                                        onPressed: () {},
                                        label: Text(
                                          allExpData[index].mode.tcase,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }

                          return Text("No");
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
