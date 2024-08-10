import 'package:flutter/material.dart';
import 'package:money_tracker/service/context_extention.dart';
import 'package:money_tracker/widgets/custom_text.dart';

primaryButton({String text = '', Color? color, Function? function}) =>
    Builder(builder: (context) {
      return ElevatedButton(
        onPressed: () {
          if (function != null) function();
        },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: color ?? context.iconColor))),
        child: Txt(text, color: color ?? context.primaryColor, bold: true),
      );
    });
