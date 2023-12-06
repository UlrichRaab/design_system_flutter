import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name, bool v1, bool? v2, bool v3) {
    testGoldens(name, (WidgetTester tester) async {
      final builder =
          GoldenBuilder.column(wrap: (w) => TestApp.expanded(child: w))
            ..addScenario(
              'checkbox tests',
              CheckboxTest(value1: v1, value2: v2, value3: v3),
            );

      await tester.pumpWidgetBuilder(builder.build());
      await multiScreenGolden(tester, '${name}_initial',
          devices: TestApp.native_devices);
    });
  }

  generateTest('checkbox_test_1', false, false, false);
  generateTest('checkbox_test_2', true, true, true);
  generateTest('checkbox_test_3', false, null, false);
}

class CheckboxTest extends StatelessWidget {
  const CheckboxTest(
      {Key? key, required this.value1, this.value2, required this.value3})
      : super(key: key);

  final bool value1;
  final bool? value2;
  final bool value3;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SBBListHeader('Checkbox'),
          SBBGroup(
            padding: const EdgeInsets.all(sbbDefaultSpacing / 2),
            child: Row(
              children: [
                SBBCheckbox(
                  onChanged: (bool? value) {},
                  value: value1,
                ),
                SBBCheckbox(
                  onChanged: null,
                  value: value1,
                ),
                SBBCheckbox(
                  onChanged: (bool? value) {},
                  value: value2,
                  tristate: true,
                ),
                SBBCheckbox(
                  onChanged: null,
                  value: value2,
                  tristate: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('CheckboxListItem'),
          SBBGroup(
            child: Column(
              children: [
                SBBCheckboxListItem(
                  value: value1,
                  label: 'Default',
                  onChanged: (value) {},
                ),
                SBBCheckboxListItem(
                  value: value2,
                  label: 'Tristate',
                  tristate: true,
                  onChanged: (value) {},
                ),
                SBBCheckboxListItem(
                  value: false,
                  label: 'Call to Action',
                  onChanged: (value) {},
                  trailingIcon: SBBIconsSmall.circle_information_small_small,
                ),
                SBBCheckboxListItem(
                  value: false,
                  label: 'Icon',
                  onChanged: (value) {},
                  leadingIcon: SBBIconsSmall.alarm_clock_small,
                ),
                SBBCheckboxListItem(
                  value: value3,
                  label: 'Icon, Call to Action',
                  onChanged: (value) {},
                  leadingIcon: SBBIconsSmall.alarm_clock_small,
                  trailingIcon: SBBIconsSmall.circle_information_small_small,
                ),
                SBBCheckboxListItem(
                  value: value3,
                  label: 'Disabled, Icon, Call to Action',
                  onChanged: null,
                  leadingIcon: SBBIconsSmall.alarm_clock_small,
                  trailingIcon: SBBIconsSmall.circle_information_small_small,
                ),
                SBBCheckboxListItem.custom(
                  value: false,
                  label: 'Custom trailing Widget',
                  isLastElement: true,
                  onChanged: (value) {},
                  trailingWidget: const Padding(
                    padding: const EdgeInsets.only(right: sbbDefaultSpacing),
                    child: Text('CHF 0.99'),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
