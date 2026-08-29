import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/data/default_data/default_policy_recommendations.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/sections/protection_score_container_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/insurance_under_construction_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/insurance_planner/insurance_planner_content_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/insurance_planner/insurance_planner_empty_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/widgets/protection_gap_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/widgets/recommended_policy_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/views/net_worth_planner_screen/net_worth_planner_empty_view.dart';
import 'package:getx_drift_app/features/widgets/cards/others_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsurancePlannerScreen extends GetView<InsurancePlannerController> {
  const InsurancePlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isUnderConstruction.value) {
        return InsurancePlannerEmptyView();
      }
      return InsurancePlannerContentView();
    });
  }
}
