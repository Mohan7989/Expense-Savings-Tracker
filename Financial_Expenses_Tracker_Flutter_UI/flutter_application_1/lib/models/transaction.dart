import 'package:flutter/material.dart';

class Transaction {
  final String title;
  final String subtitle;
  final double amount;
  final String icon;
  final Color iconColor;
  final Color bgColor;

  Transaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });
}
