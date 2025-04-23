import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pr_budget_tracker/modal/expense_modal.dart';
import 'package:pr_budget_tracker/utils/helper/db_helper.dart';

class ExpenseController extends GetxController {
  Future<void> insertExpRecord({required ExpenseModal modal}) async {
    int? res = await DBHelper.dbHelper.insertExpenseRecord(modal: modal);

    if (res != null) {
      fetchPiDataCatExp();

      Get.snackbar(
        'SUCCESS',
        'Expense inserted successfully',
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

  Future<List<ExpenseModal>>? allExp;
  Future<void> fetchExpRecord() async {
    allExp = DBHelper.dbHelper.fetchExpenseRecords();
    log("$allExp");
    // update();
  }

  Future<void> deleteExpRecord({required int id}) async {
    int? res = await DBHelper.dbHelper.deleteExpenseRecords(id: id);
    if (res != null) {
      fetchExpRecord();
      fetchTotalExpRecord();
      fetchPiDataCatExp();

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

  Future<void> updateExpRecord({required ExpenseModal modal}) async {
    int? res = await DBHelper.dbHelper.updateExpenseRecords(model: modal);
    if (res != null) {
      fetchExpRecord();
      fetchTotalExpRecord();
      fetchPiDataCatExp();

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

  void SearchExpenseRec({required String expName}) {
    allExp = DBHelper.dbHelper.liveSearchExpRec(searchExp: expName);
    log('*************$allExp');
    update();
  }

  num? totalExpenses = 0;
  Future<void> fetchTotalExpRecord() async {
    totalExpenses = await DBHelper.dbHelper.fetchTotalExpense();
    log('$totalExpenses');
    update();
  }

  List? fetchPiDataExp;
  Future<void> fetchPiDataCatExp() async {
    fetchPiDataExp = await DBHelper.dbHelper.fetchExpByCategory() ?? [];
    log("$fetchPiDataExp-----------");
    update();
  }
}
