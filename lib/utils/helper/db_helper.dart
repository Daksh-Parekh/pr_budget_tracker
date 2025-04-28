import 'dart:developer';

import 'package:pr_budget_tracker/modal/expense_modal.dart';
import 'package:pr_budget_tracker/modal/income_modal.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();

  Database? db;

  String tableName = "income";
  String incomeId = "inc_id";
  String incomeName = "inc_name";
  String incomeAmount = "inc_amt";
  String incomeMode = "inc_mode";
  String incomeCategory = "inc_category";
  String incomeDesc = "inc_desc";
  String incomeImg = "inc_img";

  String expTableName = "expense";
  String expenseId = "exp_id";
  String expenseName = "exp_name";
  String expenseAmount = "exp_amt";
  String expenseMode = "exp_mode";
  String expenseCategory = "exp_category";
  String expenseDesc = "exp_desc";
  String expenseImg = "exp_img";

  //TODO: create table
  Future<void> initDB() async {
    String dbPath = await getDatabasesPath();
    String path = "${dbPath}budget.db";

    //open Database
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        //create income table
        String query = '''CREATE TABLE $tableName(
        $incomeId INTEGER PRIMARY KEY AUTOINCREMENT,
        $incomeName TEXT NOT NULL,
        $incomeAmount NUMERIC NOT NULL,
        $incomeMode TEXT NOT NULL,
        $incomeCategory TEXT NOT NULL,
        $incomeDesc TEXT,
        $incomeImg BLOB NOT NULL
        );''';

        await db.execute(query);

        //Create expense Table
        String expQuery = '''CREATE TABLE $expTableName(
        $expenseId INTEGER PRIMARY KEY AUTOINCREMENT,
        $expenseName TEXT NOT NULL,
        $expenseAmount NUMERIC NOT NULL,
        $expenseMode TEXT NOT NULL,
        $expenseCategory TEXT NOT NULL,
        $expenseDesc TEXT,
        $expenseImg BLOB NOT NULL
        );''';

        await db.execute(expQuery);
      },
    );
  }

  //TODO: insert inc Record
  Future<int?> insertRecord({required IncomeModal model}) async {
    await initDB();

    String query =
        "INSERT INTO $tableName($incomeName,$incomeAmount,$incomeMode,$incomeCategory,$incomeDesc,$incomeImg) VALUES(?,?,?,?,?,?);";
    List args = [
      model.name,
      model.amount,
      model.mode,
      model.categoryName,
      model.desc,
      model.image,
    ];

    int? res = await db?.rawInsert(query, args);
    log('Record no: $res');
    return res;
  }

  //TODO: fetch inc Record
  Future<List<IncomeModal>> fetchIncomeRecords() async {
    await initDB();

    String query = "SELECT * FROM $tableName;";
    List<Map<String, dynamic>> fetchIncomes = await db?.rawQuery(query) ?? [];
    return fetchIncomes.map((e) => IncomeModal.fromMap(data: e)).toList();
  }

  //TODO: update inc Record
  Future<int?> updateIncomeRecords({required IncomeModal model}) async {
    await initDB();
    String query =
        "UPDATE $tableName SET $incomeName=?,$incomeAmount=?,$incomeMode=?,$incomeCategory=?,$incomeDesc=?,$incomeImg=? WHERE $incomeId=${model.id}";
    return await db?.rawUpdate(query, [
      model.name,
      model.amount,
      model.mode,
      model.categoryName,
      model.desc,
      model.image,
    ]);
  }

  //TODO: delete inc Record
  Future<int?> deleteIncomeRecords({required int id}) async {
    await initDB();

    String query = "DELETE FROM $tableName WHERE $incomeId=$id";

    return await db?.rawDelete(query);
  }

  Future<List<IncomeModal>> liveSearchIncomeRec(
      {required String searchIncName}) async {
    await initDB();

    String query =
        "SELECT * FROM $tableName WHERE $incomeName LIKE '%$searchIncName%';";
    List<Map<String, dynamic>> searchIncomeRec =
        await db?.rawQuery(query) ?? [];

    return searchIncomeRec.map((e) => IncomeModal.fromMap(data: e)).toList();
    // log('********$re----------------------------------');
  }

  Future<num> fetchTotalIncome() async {
    await initDB();
    String query = "SELECT SUM($incomeAmount) AS total FROM $tableName;";
    var res = await db?.rawQuery(query);
    log("$res");
    if (res?.first['total'] != null) {
      return num.parse(res!.first['total'].toString());
    } else {
      return 0;
    }
  }

  Future<List<Map<String, Object?>>?> fetchIncomeByCategory() async {
    await initDB();

    String query =
        "SELECT $incomeCategory,SUM($incomeAmount) AS TOTAL FROM $tableName GROUP BY $incomeCategory";

    return await db?.rawQuery(query) ?? [];
  }

  //insert expense record
  Future<int?> insertExpenseRecord({required ExpenseModal modal}) async {
    await initDB();
    String query =
        "INSERT INTO $expTableName($expenseName,$expenseAmount,$expenseMode,$expenseCategory,$expenseDesc,$expenseImg) VALUES(?,?,?,?,?,?);";
    List args = [
      modal.name,
      modal.amount,
      modal.mode,
      modal.categoryName,
      modal.desc,
      modal.image,
    ];
    return await db?.rawInsert(query, args);
  }

  //fetch  Record
  Future<List<ExpenseModal>> fetchExpenseRecords() async {
    await initDB();

    String query = "SELECT * FROM $expTableName;";
    List<Map<String, dynamic>> fetchExp = await db?.rawQuery(query) ?? [];
    return fetchExp.map((e) => ExpenseModal.fromMap(data: e)).toList();
  }

  //update Record
  Future<int?> updateExpenseRecords({required ExpenseModal model}) async {
    await initDB();
    String query =
        "UPDATE $expTableName SET $expenseName=?,$expenseAmount=?,$expenseMode=?,$expenseCategory=?,$expenseDesc=?,$expenseImg=? WHERE $expenseId=${model.id}";
    return await db?.rawUpdate(query, [
      model.name,
      model.amount,
      model.mode,
      model.categoryName,
      model.desc,
      model.image,
    ]);
  }

  //delete Record
  Future<int?> deleteExpenseRecords({required int id}) async {
    await initDB();

    String query = "DELETE FROM $expTableName WHERE $expenseId=$id";

    return await db?.rawDelete(query);
  }

  Future<List<ExpenseModal>> liveSearchExpRec(
      {required String searchExp}) async {
    await initDB();

    String query =
        "SELECT * FROM $expTableName WHERE $expenseName LIKE '%$searchExp%';";
    List<Map<String, dynamic>> searchExpRec = await db?.rawQuery(query) ?? [];

    var res = searchExpRec.map((e) => ExpenseModal.fromMap(data: e)).toList();
    log('$res');
    return res;
  }

  Future<num> fetchTotalExpense() async {
    await initDB();
    String query = "SELECT SUM($expenseAmount) AS total FROM $expTableName;";
    var res = await db?.rawQuery(query);
    log("*******$res");

    if (res?.first['total'] != null) {
      return num.parse(res!.first['total'].toString());
    } else {
      return 0;
    }
  }

  Future<List<Map<String, Object?>>?> fetchExpByCategory() async {
    await initDB();

    String query =
        "SELECT $expenseCategory,SUM($expenseAmount) AS TOTAL FROM $expTableName GROUP BY $expenseCategory";

    return await db?.rawQuery(query);
  }
}
