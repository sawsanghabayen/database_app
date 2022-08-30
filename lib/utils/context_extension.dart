import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// هنا معناه بنعمل build على ال context
//   وبنعمل اضافات على عناصر موجودة مسبقا
extension ContextHelper on BuildContext{
  void showSnackBar(
      {required String message, bool error = false}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: GoogleFonts.nunito(),
      ),
      backgroundColor: error ? Colors.red.shade700: Colors.green.shade300,
      duration: const Duration(seconds: 3),
      dismissDirection: DismissDirection.horizontal,
    ));
  }








}