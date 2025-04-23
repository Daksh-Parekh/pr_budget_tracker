import 'package:flutter/services.dart';

class IncomeModal {
  int id;
  String name, mode, categoryName, desc;
  num amount;
  Uint8List image;

  IncomeModal(
      {required this.id,
      required this.name,
      required this.amount,
      required this.mode,
      required this.categoryName,
      required this.desc,
      required this.image});

  factory IncomeModal.fromMap({required Map data}) {
    return IncomeModal(
      id: data['inc_id'],
      name: data['inc_name'],
      amount: data['inc_amt'],
      mode: data['inc_mode'],
      categoryName: data['inc_category'],
      desc: data['inc_desc'],
      image: data['inc_img'],
    );
  }
}
