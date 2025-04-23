import 'package:get/get.dart';
import 'package:pr_budget_tracker/modal/category_modal.dart';

class CategoryController extends GetxController {
  RxnString? selectedIncCategory = RxnString();
  RxnString? selectedExpCategory = RxnString();
  // List<CategoryModal> allCategory = [
  //   CategoryModal(
  //     image: 'assets/expenseIcon/bills.png',
  //     name: 'Bills',
  //   ),
  //   CategoryModal(
  //     image: 'assets/expenseIcon/committee.png',
  //     name: 'Committee',
  //   ),
  //   CategoryModal(
  //     image: 'assets/expenseIcon/education.png',
  //     name: 'Education',
  //   ),
  //   CategoryModal(
  //     image: 'assets/expenseIcon/family.png',
  //     name: 'Family',
  //   ),
  //   CategoryModal(
  //     image: 'assets/expenseIcon/food.png',
  //     name: 'Food',
  //   ),
  //   CategoryModal(
  //     image: 'assets/expenseIcon/fuel.png',
  //     name: 'Fuel',
  //   ),
  //   CategoryModal(
  //     image: 'assets/expenseIcon/gifts.png',
  //     name: 'Gifts',
  //   ),
  //   CategoryModal(
  //     image: 'assets/expenseIcon/groceries.png',
  //     name: 'Groceries',
  //   ),
  //   CategoryModal(
  //     image: 'assets/expenseIcon/home.png',
  //     name: 'Home',
  //   ),
  //   CategoryModal(
  //     image: 'assets/expenseIcon/medical.png',
  //     name: 'Medical',
  //   ),
  //   CategoryModal(
  //     image: 'assets/expenseIcon/mobile.png',
  //     name: 'Mobile',
  //   ),
  //   CategoryModal(
  //     image: 'assets/expenseIcon/office.png',
  //     name: 'Office',
  //   ),
  //   CategoryModal(
  //     image: 'assets/expenseIcon/personal.png',
  //     name: 'Personal',
  //   ),
  //   CategoryModal(
  //     image: 'assets/expenseIcon/pocket.png',
  //     name: 'Pocket',
  //   ),
  //   CategoryModal(
  //     image: 'assets/expenseIcon/rent.png',
  //     name: 'Rent',
  //   ),
  //   CategoryModal(
  //     image: 'assets/expenseIcon/transport.png',
  //     name: 'Transportation',
  //   ),
  // ];
  List<CategoryModal> allCategory = [
    CategoryModal(
      image: 'assets/expenseIcon/bills.png',
      name: 'Bills',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/expenseIcon/committee.png',
      name: 'Committee',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/expenseIcon/education.png',
      name: 'Education',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/expenseIcon/family.png',
      name: 'Family',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/expenseIcon/food.png',
      name: 'Food',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/expenseIcon/fuel.png',
      name: 'Fuel',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/expenseIcon/gifts.png',
      name: 'Gifts',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/expenseIcon/groceries.png',
      name: 'Groceries',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/expenseIcon/home.png',
      name: 'Home',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/expenseIcon/medical.png',
      name: 'Medical',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/expenseIcon/mobile.png',
      name: 'Mobile',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/expenseIcon/office.png',
      name: 'Office',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/expenseIcon/personal.png',
      name: 'Personal',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/expenseIcon/pocket.png',
      name: 'Pocket',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/expenseIcon/rent.png',
      name: 'Rent',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/expenseIcon/transport.png',
      name: 'Transportation',
      type: 'expense',
    ),
    CategoryModal(
      image: 'assets/incomeIcon/salary.png',
      name: 'Salary',
      type: 'income',
    ),
    // CategoryModal(
    //   image: 'assets/incomeIcon/freelance.png',
    //   name: 'Freelance',
    //   type: 'income',
    // ),
  ];

  void changeSelectedCategory(String category, String type) {
    // selectedCategory?.value = category;

    type == 'income'
        ? selectedIncCategory!.value = category
        : selectedExpCategory?.value = category;
  }

  void validValueOfCategory(String type) {
    if (!allCategory.where((e) => e.type == type).toList().any(
          (element) => type == 'income'
              ? element.name == selectedIncCategory?.value
              : element.name == selectedExpCategory?.value,
        )) {
      type == 'income'
          ? selectedIncCategory?.value = null
          : selectedExpCategory?.value = null;
    }
    update();
  }
}
