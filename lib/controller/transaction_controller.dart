import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pr_budget_tracker/modal/income_modal.dart';
import 'package:pr_budget_tracker/utils/helper/db_helper.dart';

class TransactionController extends GetxController {
  // RxString mode = "".obs;
  RxnString mode = RxnString();
  RxInt tabIndex = 0.obs;

  void changeMode(String transMode) {
    mode.value = transMode;
    // update();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
    // update();
  }

  Future<void> insertIncomeRecord({required IncomeModal model}) async {
    int? res = await DBHelper.dbHelper.insertRecord(model: model);

    if (res != null) {
      fetchPiDataByCat();
      Get.snackbar(
        'SUCCESS',
        'income inserted successfully',
        backgroundColor: Colors.green,
      );
    } else {
      Get.snackbar(
        'FAILED',
        'income not inserted successfully',
        backgroundColor: Colors.red,
      );
    }
  }

  Future<List<IncomeModal>>? allincome;
  Future<void> fetchIncomeRecord() async {
    allincome = DBHelper.dbHelper.fetchIncomeRecords();
    log("$allincome");
    // update();
  }

  void SearchIncRec({required String incName}) {
    allincome = DBHelper.dbHelper.liveSearchIncomeRec(searchIncName: incName);

    update();
  }

  Future<void> deleteIncomeRecord({required int id}) async {
    int? res = await DBHelper.dbHelper.deleteIncomeRecords(id: id);
    if (res != null) {
      fetchIncomeRecord();
      fetchTotalIncomeRecord();
      fetchPiDataByCat();
      Get.snackbar(
        'DELETE',
        'Deletion successfull',
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    } else {
      Get.snackbar(
        'DELETION FAILED',
        'Deletion failed',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    update();
  }

  Future<void> updateIncomeRecord({required IncomeModal modal}) async {
    int? res = await DBHelper.dbHelper.updateIncomeRecords(model: modal);
    if (res != null) {
      fetchIncomeRecord();
      fetchTotalIncomeRecord();
      fetchPiDataByCat();

      Get.snackbar(
        'UPDATED',
        'Income record successfully updated...',
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    } else {
      Get.snackbar(
        'FAILED',
        'Income record not updated successfully...',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    update();
  }

  num? totalIcome = 0;
  Future<void> fetchTotalIncomeRecord() async {
    totalIcome = await DBHelper.dbHelper.fetchTotalIncome();
    log('$totalIcome');
    update();
  }

  List? fetchPiData;
  Future<void> fetchPiDataByCat() async {
    fetchPiData = await DBHelper.dbHelper.fetchIncomeByCategory() ?? [];
    log("$fetchPiData-----------");
    update();
  }
}
