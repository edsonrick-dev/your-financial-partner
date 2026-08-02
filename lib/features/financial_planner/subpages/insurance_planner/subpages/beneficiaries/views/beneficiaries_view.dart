import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';

class BeneficiariesView extends StatelessWidget {
  const BeneficiariesView({super.key});

  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.colors;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Beneficiaries', style: AppTextStyle.headlineL),
      ),
      body: SingleChildScrollView(child: Column(children: [          ],
        )),
    );
  }
}
