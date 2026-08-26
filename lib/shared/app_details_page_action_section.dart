import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_page_shifter.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppDetailsPageActionSection extends StatelessWidget {
  final RxInt selectedIndex;
  final List<String> actions;
  final VoidCallback? onAdd;

  const AppDetailsPageActionSection({
    super.key,
    required this.selectedIndex,
    required this.actions,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: Obx(
        () => Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      children: [
                        for (int index = 0; index < actions.length; index++)
                          AppDetailsPageShifter(
                            text: actions[index],
                            isSelected: selectedIndex.value == index,
                            onTap: () {
                              selectedIndex.value = index;
                            },
                          ),
                      ],
                    ),
                  ),
                ),

                if (onAdd != null)
                  IconButton(
                    onPressed: onAdd,
                    icon: const Icon(PhosphorIconsRegular.plus),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
