import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_page_shifter.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppDetailsPageActionSection extends StatelessWidget {
  final RxInt selectedIndex;
  final List<String> actions;
  final LayerLink? addButtonLink;
  final VoidCallback? onAdd;
  final RxBool? isAddMenuOpen;

  const AppDetailsPageActionSection({
    super.key,
    required this.selectedIndex,
    required this.actions,
    this.isAddMenuOpen,
    this.addButtonLink,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: Obx(
        () => Row(
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
              addButtonLink != null
                  ? CompositedTransformTarget(
                      link: addButtonLink!,
                      child: IconButton(
                        onPressed: onAdd,
                        icon: isAddMenuOpen == null
                            ? const Icon(PhosphorIconsRegular.plus)
                            : Obx(
                                () => AnimatedRotation(
                                  turns: isAddMenuOpen!.value ? 0.125 : 0,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                  child: const Icon(PhosphorIconsRegular.plus),
                                ),
                              ),
                      ),
                    )
                  : IconButton(
                      onPressed: onAdd,
                      icon: const Icon(PhosphorIconsRegular.plus),
                    ),
          ],
        ),
      ),
    );
  }
}
