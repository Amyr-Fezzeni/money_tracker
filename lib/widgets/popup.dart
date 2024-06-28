import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_tracker/service/context_extention.dart';
import 'package:money_tracker/widgets/custom_text.dart';

Widget settingsPopup(
    {required String title,
    required String selectedValue,
    Function(String)? onTap,
    List<Map<String, dynamic>> lst = const []}) {
  return Builder(builder: (context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Txt(title)),
            PopupMenuButton<String>(
              initialValue: selectedValue,
              surfaceTintColor: context.bgcolor,
              color: context.bgcolor,
              child: Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: context.w * .4),
                    child: Txt(selectedValue,
                        color: context.iconColor, maxLines: 2),
                  ),
                  Icon(Icons.unfold_more_rounded,
                      color: context.iconColor, size: 25.sp)
                ],
              ),
              itemBuilder: (BuildContext context) => lst
                  .map((e) => PopupMenuItem<String>(
                        value: e['name'],
                        padding: const EdgeInsets.all(0),
                        onTap: () {
                          if (onTap != null) {
                            onTap(e['name']);
                          }
                        },
                        child: Container(
                          color: context.appThemeRead.bgColor,
                          child: Container(
                              constraints: BoxConstraints(
                                  minHeight: 50.sp, minWidth: 110.sp),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: e['name'] == selectedValue
                                      ? context.appThemeRead.primaryColor
                                          .withOpacity(.1)
                                      : null),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Text(
                                      txt(e['name']),
                                      style: context.appThemeRead.text.copyWith(
                                          fontSize: 14.sp,
                                          color: e['name'] == selectedValue
                                              ? context
                                                  .appThemeRead.primaryColor
                                              : null),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ],
    );
  });
}

Widget divider({double bottom = 0, double top = 0}) =>
    Builder(builder: (context) {
      return Padding(
        padding: EdgeInsets.only(top: top, bottom: bottom),
        child: Divider(
          height: 5,
          color: context.invertedColor.withOpacity(.1),
        ),
      );
    });
