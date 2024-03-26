import 'dart:convert';

import 'package:flutter/material.dart';

class AmountData {

  String id;

  int amount;

  AmountType type;

  DateTime date;

  int categoryIndex;

  String text;

  AmountData({
    required this.id,
    required this.amount,
    required this.type,
    required this.date,
    required this.categoryIndex,
    required this.text,
  });

  factory AmountData.fromJson(Map<String, dynamic> jsonData) {
    return AmountData(
      id: jsonData['id'],
      amount: jsonData['amount'],
      type: AmountType.values.elementAt(jsonData['type']),
      date: DateTime.parse(jsonData['date'].toString()),
      categoryIndex: jsonData['categoryIndex'],
      text: jsonData['text'],
    );
  }

  static Map<String, dynamic> toMap(AmountData amountData) => {
    'id': amountData.id,
    'amount': amountData.amount,
    'type': amountData.type.index,
    'date': amountData.date.toString(),
    'categoryIndex': amountData.categoryIndex,
    'text': amountData.text,
  };

  static String encode(List<AmountData> amountDatas) => json.encode(
    amountDatas
    .map<Map<String, dynamic>>((amountData) => AmountData.toMap(amountData))
        .toList(),
  );

  static List<AmountData> decode(String amountDatas) =>
      (json.decode(amountDatas) as List<dynamic>)
          .map<AmountData>((item) => AmountData.fromJson(item))
          .toList();

}

enum AmountType {

  /// 支出
  Expenditure,

  /// 收入
  Income,

  /// 合计
  Total
}


class AmountCategory {
  IconData iconData;
  String categoryName;

  AmountCategory({
    required this.iconData,
    required this.categoryName,
  });

}
