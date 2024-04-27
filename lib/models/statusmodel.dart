import 'package:flutter/material.dart';

class StatusModel {
  final Color mycolor;
  final String imgUrl;
  final String description;
  final String title;
  const StatusModel({
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.mycolor,
  });
}
