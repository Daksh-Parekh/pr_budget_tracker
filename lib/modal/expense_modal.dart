import 'package:flutter/services.dart';

class ExpenseModal {
  int id;
  String name, mode, categoryName, desc;
  num amount;
  Uint8List image;

  ExpenseModal({
    required this.id,
    required this.name,
    required this.amount,
    required this.mode,
    required this.categoryName,
    required this.desc,
    required this.image,
  });

  factory ExpenseModal.fromMap({required Map data}) {
    return ExpenseModal(
      id: data['exp_id'],
      name: data['exp_name'],
      amount: data['exp_amt'],
      mode: data['exp_mode'],
      categoryName: data['exp_category'],
      desc: data['exp_desc'],
      image: data['exp_img'],
    );
  }
}
