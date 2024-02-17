import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:story/core/constants/app_sizes.dart';

class DropdownFlag extends StatefulWidget {
  const DropdownFlag({required this.changedLanguage, super.key});

  final ValueChanged<String> changedLanguage;

  @override
  State<DropdownFlag> createState() => _DropdownFlagState();
}

class _DropdownFlagState extends State<DropdownFlag> {
  String dropdownValue = '';

  @override
  void didUpdateWidget(covariant DropdownFlag oldWidget) {
    dropdownValue = context.locale.languageCode;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    dropdownValue = context.locale.languageCode;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Row(
          children: [
            Text(dropdownValue),
            Gap.h12,
            SvgPicture.asset(
              'assets/svg/$dropdownValue.svg',
              width: 30,
            ),
          ],
        ),
        buttonStyleData: const ButtonStyleData(
          height: 40,
          width: 140,
        ),
        menuItemStyleData: const MenuItemStyleData(height: 40),
        dropdownStyleData: const DropdownStyleData(width: 100),
        underline: const SizedBox(),
        items: List.generate(
          context.supportedLocales.length,
          (index) => DropdownMenuItem(
            onTap: () => setState(() {
              dropdownValue = context.supportedLocales[index].languageCode;
              widget.changedLanguage(dropdownValue);
            }),
            value: context.supportedLocales[index].languageCode,
            child: Row(
              children: [
                Text(context.supportedLocales[index].languageCode),
                Gap.h12,
                SvgPicture.asset(
                  'assets/svg/${context.supportedLocales[index].languageCode}.svg',
                  width: 30,
                ),
              ],
            ),
          ),
        ),
        onChanged: (value) {},
      ),
    );
  }
}
