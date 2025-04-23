import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pr_budget_tracker/components/expense_component.dart';
import 'package:pr_budget_tracker/components/income_component.dart';
import 'package:pr_budget_tracker/components/transaction_component.dart';
import 'package:pr_budget_tracker/controller/category_controller.dart';
import 'package:pr_budget_tracker/controller/navigation_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NavigationController controllers = Get.put(NavigationController());
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text("Home page")),
      body: PageView(
        controller: controllers.pageController,
        onPageChanged: (value) {
          controllers.changeNavIndex(value);
        },
        children: [
          // Column(
          //   children: [
          //     Text("sadd"),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text("sadd"),

          //         Obx(
          //           () => SizedBox(
          //             height: 62,
          //             child: DropdownButton(
          //               alignment: Alignment(0, 0),
          //               hint: Text("Select Category"),
          //               value: categoryController.selectedCategory?.value,
          //               items: categoryController.allCategory.map(
          //                 (CategoryModal e) {
          //                   return DropdownMenuItem<String>(
          //                     value: e.name,
          //                     child: Row(
          //                       children: [
          //                         CircleAvatar(
          //                           backgroundImage: AssetImage(e.image!),
          //                         ),
          //                         SizedBox(
          //                           width: 8,
          //                         ),
          //                         Text(e.name),
          //                       ],
          //                     ),
          //                   );
          //                 },
          //               ).toList(),
          //               onChanged: (value) {
          //                 categoryController
          //                     .changeSelectedCategory(value.toString());
          //               },
          //             ),
          //           ),
          //         ),
          //         // DropdownButton(
          //         //   value: categoryController.selectedCategory,
          //         //   borderRadius: BorderRadius.circular(10),
          //         //   hint: Text("Select Mode"),
          //         //   items: categoryController.allCategory
          //         //       .map(
          //         //         (CategoryModal element) => DropdownMenuItem(
          //         //           child: Text("hello${element}"),
          //         //         ),
          //         //       )
          //         //       .toList(),
          //         //   onChanged: (value) {},
          //         // ),
          //       ],
          //     ),
          //   ],
          // ),
          IncomeComponent(),
          TransactionComponent(),
          // Text("3"),
          ExpenseComponent(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controllers.navIndex.value,
          onDestinationSelected: (value) {
            controllers.changeNavIndex(value);
            controllers.changePageIndex(value);
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.account_balance),
              label: 'Income',
            ),
            NavigationDestination(icon: Icon(Icons.add), label: 'Transactions'),
            NavigationDestination(icon: Icon(Icons.wallet), label: 'Expense'),
          ],
        ),
      ),
    );
  }
}
