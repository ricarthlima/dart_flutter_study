import 'package:flutter/material.dart';

bool isHorizontalScreen(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return size.width >= size.height;
}
