import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:story/core/constants/app_sizes.dart';

class DropdownFlag extends StatefulWidget {
  const DropdownFlag({super.key});

  @override
  State<DropdownFlag> createState() => _DropdownFlagState();
}

class _DropdownFlagState extends State<DropdownFlag> {
  late String dropdownValue;

  @override
  void didChangeDependencies() {
    dropdownValue = context.locale.languageCode;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: SvgPicture.asset(
          'assets/svg/$dropdownValue.svg',
          width: Sizes.p32.w,
        ),
        menuItemStyleData: MenuItemStyleData(height: Sizes.p40.h),
        dropdownStyleData: DropdownStyleData(width: Sizes.p100.w, elevation: 0),
        items: List.generate(
          context.supportedLocales.length,
          (index) => DropdownMenuItem(
            onTap: () => setState(() {
              dropdownValue = context.supportedLocales[index].languageCode;
              context.setLocale(Locale(dropdownValue));
            }),
            value: context.supportedLocales[index].languageCode,
            child: Wrap(
              spacing: Sizes.p12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(context.supportedLocales[index].languageCode),
                SvgPicture.asset(
                  'assets/svg/${context.supportedLocales[index].languageCode}.svg',
                  width: Sizes.p32.w,
                ),
              ],
            ),
          ),
        ),
        onChanged: (_) {},
      ),
    );
  }
}
