import 'package:get/get.dart';
import 'package:pr_budget_tracker/modal/category_modal.dart';

class CategoryController extends GetxController {
  RxnString? selectedIncCategory = RxnString();
  RxnString? selectedExpCategory = RxnString();

  List<CategoryModal> allCategory = [
    // Expense

    CategoryModal(
        name: 'Food & Drink',
        image: 'assets/expenseIcon/food.png',
        type: 'expense'),
    CategoryModal(
        name: 'Groceries',
        image: 'assets/expenseIcon/groceries.png',
        type: 'expense'),
    CategoryModal(
        name: 'Personal',
        image: 'assets/expenseIcon/personal.png',
        type: 'expense'),
    CategoryModal(
        name: 'Medical',
        image: 'assets/expenseIcon/medical.png',
        type: 'expense'),
    CategoryModal(
        name: 'Fuel & Maintenace',
        image: 'assets/expenseIcon/fuel.png',
        type: 'expense'),
    CategoryModal(
        name: 'Transport',
        image: 'assets/expenseIcon/transport.png',
        type: 'expense'),
    CategoryModal(
        name: 'Bills & Utilities',
        image: 'assets/expenseIcon/bills.png',
        type: 'expense'),
    CategoryModal(
        name: 'Travel',
        image: 'assets/expenseIcon/travel.png',
        type: 'expense'),
    CategoryModal(
        name: 'Mobile Expenses',
        image: 'assets/expenseIcon/mobile.png',
        type: 'expense'),
    CategoryModal(
        name: 'Health & Fitness',
        image: 'assets/expenseIcon/health.png',
        type: 'expense'),
    CategoryModal(
        name: 'Donations',
        image: 'assets/expenseIcon/donations.png',
        type: 'expense'),
    CategoryModal(
        name: 'Committee',
        image: 'assets/expenseIcon/committee.png',
        type: 'expense'),
    CategoryModal(
        name: 'Wedding',
        image: 'assets/expenseIcon/wedding.png',
        type: 'expense'),
    CategoryModal(
        name: 'Office Expenses',
        image: 'assets/expenseIcon/office.png',
        type: 'expense'),
    CategoryModal(
        name: 'Home Expenses',
        image: 'assets/expenseIcon/home.png',
        type: 'expense'),
    CategoryModal(
        name: 'Family Expenses',
        image: 'assets/expenseIcon/family.png',
        type: 'expense'),
    CategoryModal(
        name: 'Shopping',
        image: 'assets/expenseIcon/shopping.png',
        type: 'expense'),
    CategoryModal(
        name: 'Education',
        image: 'assets/expenseIcon/education.png',
        type: 'expense'),
    CategoryModal(
        name: 'Entertainment',
        image: 'assets/expenseIcon/entertainment.png',
        type: 'expense'),
    CategoryModal(
      name: 'Gifts',
      image: 'assets/expenseIcon/gifts.png',
      type: 'expense',
    ),
    CategoryModal(
        name: 'Rent Paid',
        image: 'assets/expenseIcon/rent.png',
        type: 'expense'),
    CategoryModal(
        name: 'Loan Paid',
        image: 'assets/expenseIcon/loan.png',
        type: 'expense'),
    CategoryModal(
        name: 'Installments',
        image: 'assets/expenseIcon/installments.png',
        type: 'expense'),
    CategoryModal(
        name: 'Savings',
        image: 'assets/expenseIcon/savings.png',
        type: 'expense'),
    CategoryModal(
        name: 'Other Expenses',
        image: 'assets/expenseIcon/otherExpense.png',
        type: 'expense'),
    CategoryModal(
        name: 'Insurance',
        image: 'assets/expenseIcon/insurance.png',
        type: 'expense'),
    CategoryModal(
        name: 'Vehicle',
        image: 'assets/expenseIcon/vehicle.png',
        type: 'expense'),
    CategoryModal(
        name: 'Emergency Fund',
        image: 'assets/expenseIcon/emergency.png',
        type: 'expense'),
    CategoryModal(
        name: 'Electronics',
        image: 'assets/expenseIcon/electronics.png',
        type: 'expense'),
    CategoryModal(
        name: 'Home Appliances',
        image: 'assets/expenseIcon/appliances.png',
        type: 'expense'),
    CategoryModal(
        name: 'Picnic/Party',
        image: 'assets/expenseIcon/party.png',
        type: 'expense'),

    //Inocme
    CategoryModal(
        name: 'Salary Income',
        image: 'assets/incomeIcon/salary.png',
        type: 'income'),
    CategoryModal(
        name: 'ATM Withdrawal',
        image: 'assets/incomeIcon/atm.png',
        type: 'income'),
    CategoryModal(
        name: 'Transfer Money',
        image: 'assets/incomeIcon/transfer.png',
        type: 'income'),
    CategoryModal(
        name: 'Comission',
        image: 'assets/incomeIcon/comission.png',
        type: 'income'),
    CategoryModal(
        name: 'Pension',
        image: 'assets/incomeIcon/pension.png',
        type: 'income'),
    CategoryModal(
        name: 'Investment',
        image: 'assets/incomeIcon/investment.png',
        type: 'income'),
    CategoryModal(
        name: 'Allowance',
        image: 'assets/incomeIcon/allowance.png',
        type: 'income'),
    CategoryModal(
      name: 'Bonus',
      image: 'assets/incomeIcon/bonus.png',
      type: 'income',
    ),
    CategoryModal(
      name: 'Profit',
      image: 'assets/incomeIcon/profit.png',
      type: 'income',
    ),
    CategoryModal(
        name: 'Gifts Received',
        image: 'assets/incomeIcon/gifts.png',
        type: 'income'),
    CategoryModal(
        name: 'Savings',
        image: 'assets/incomeIcon/savings.png',
        type: 'income'),
    CategoryModal(
        name: 'Tutoring Income',
        image: 'assets/incomeIcon/tutoring.png',
        type: 'income'),
    CategoryModal(
        name: 'Freelance Income',
        image: 'assets/incomeIcon/freelance.png',
        type: 'income'),
    CategoryModal(
        name: 'Other Income',
        image: 'assets/incomeIcon/otherIncome.png',
        type: 'income'),
    CategoryModal(
        name: 'Rent Received',
        image: 'assets/incomeIcon/rentReceived.png',
        type: 'income'),
    CategoryModal(
        name: 'Loan Received',
        image: 'assets/incomeIcon/loanReceived.png',
        type: 'income'),
    CategoryModal(
        name: 'Wedding',
        image: 'assets/incomeIcon/wedding.png',
        type: 'income'),
    CategoryModal(
        name: 'Education',
        image: 'assets/incomeIcon/education.png',
        type: 'income'),
    CategoryModal(
        name: 'Travel', image: 'assets/incomeIcon/travel.png', type: 'income'),
    CategoryModal(
        name: 'Home', image: 'assets/incomeIcon/home.png', type: 'income'),
    CategoryModal(
        name: 'Business',
        image: 'assets/incomeIcon/business.png',
        type: 'income'),
  ];

  void changeSelectedCategory(String category, String type) {
    type == 'income'
        ? selectedIncCategory!.value = category
        : selectedExpCategory?.value = category;
  }
}
