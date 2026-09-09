import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/entity_type_enum.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class SelectInstitutionSheet extends StatelessWidget {
  const SelectInstitutionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      adaptiveHeight: true,
      title: 'Select Financial Institution',
      child: StreamBuilder<List<EntitiesTableData>>(
        stream: database.entitiesDao.watchEntitiesByType(
          EntityType.organization.name,
        ),
        builder: (context, snapshot) {
          final institutions = snapshot.data ?? [];

          return ListView.separated(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: context.bottomPaddingSub,
            ),
            shrinkWrap: true,
            itemCount: institutions.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final institution = institutions[index];

              return AppCard(
                child: Row(
                  children: [Text(institution.displayName ?? institution.name)],
                ),
                onTap: () {
                  Get.back(result: institution);
                },
              );
            },
          );
        },
      ),
    );
  }
}
