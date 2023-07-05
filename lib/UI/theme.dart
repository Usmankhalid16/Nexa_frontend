
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const Color whitish = Color(0xFFFFFFFF);
const Color pinkpurp = Color(0xFFC3AED9);
const Color lightbl = Color(0xFF84A6D3);
const Color pink = Color(0xFFC35E9E);
const Color indigo = Color(0xFF362360);
const Color greyish = Colors.grey;
const primaryclr = whitish;
const primaryblk = greyish;

// const Color blue = Color(0x);
class Themes{
  static final light= ThemeData(
    useMaterial3: true,
  // scaffoldBackgroundColor: ,
  brightness: Brightness.light
  );
  static final dark= ThemeData(
      useMaterial3: true,
  brightness: Brightness.dark
  );
}