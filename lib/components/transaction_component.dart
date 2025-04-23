import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pr_budget_tracker/components/widget/transaction_widget.dart';
import 'package:pr_budget_tracker/controller/category_controller.dart';
import 'package:pr_budget_tracker/controller/expense_controller.dart';
import 'package:pr_budget_tracker/controller/transaction_controller.dart';

TextEditingController transNameController = TextEditingController();
TextEditingController transAmtController = TextEditingController();
TextEditingController transCategoryController = TextEditingController();
TextEditingController transDescController = TextEditingController();

class TransactionComponent extends StatelessWidget {
  const TransactionComponent({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    // CategoryController catController = Get.put(CategoryController());
    TransactionController transController = Get.put(TransactionController());
    ExpenseController expController = Get.put(ExpenseController());
    final CategoryController categoryController = Get.put(CategoryController());
    return DefaultTabController(
      length: 2,
      animationDuration: Duration(seconds: 2),
      initialIndex: transController.tabIndex.value,
      child: Column(
        children: [
          Obx(
            () => TabBar(
              onTap: (value) => transController.changeTabIndex(value),
              automaticIndicatorColorAdjustment: true,
              indicatorColor: Colors.white,
              labelColor:
                  transController.tabIndex == 0 ? Colors.green : Colors.red,
              // con
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(
                  icon: Icon(Icons.monetization_on_rounded),
                  text: "Add Income",
                ),
                Tab(
                  icon: Icon(Icons.account_balance_wallet_rounded),
                  text: "Add Expense",
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                TransactionTile(
                  controller: transController,
                  categoryController: categoryController,
                  expController: expController,
                  onPressedIndex: 1,
                  size: size,
                  ctx: context,
                  type: "income",
                ),
                TransactionTile(
                  controller: transController,
                  categoryController: categoryController,
                  expController: expController,
                  onPressedIndex: 2,
                  size: size,
                  ctx: context,
                  type: "expense",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
