import 'package:flutter/material.dart';
import 'package:money_tracker/service/context_extention.dart';
import 'package:money_tracker/widgets/custom_text.dart';

primaryButton({String text = '', Color? color, Function? function}) =>
    Builder(builder: (context) {
      return ElevatedButton(
        onPressed: () {
          if (function != null) function();
        },
        child: Txt(text, color: color ?? context.primaryColor, bold: true),
      );
    });
