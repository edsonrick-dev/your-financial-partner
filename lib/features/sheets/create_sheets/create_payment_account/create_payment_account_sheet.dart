// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
// import 'package:getx_drift_app/app/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';
// import 'package:getx_drift_app/app/widgets/fields/dropdown_field.dart';
// import 'package:getx_drift_app/app/widgets/miscellaneous/app_toolbar.dart';
// import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

// class CreatePaymentAccountSheet extends GetView<CreateAccountController> {
//   const CreatePaymentAccountSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,

//           borderRadius: BorderRadius.all(Radius.circular(32)),
//         ),

//         child: SafeArea(
//           child: Column(
//             spacing: 12,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               AppToolbar(title: 'Create Payment Account'),

//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   spacing: 12,
//                   children: [
//                     Obx(
//                       () => AppDropdownField(
//                         label: 'Payment Account Type',
//                         value: controller.selectedAccountType.value?.label,
//                         hint: 'Select account type',
//                         onTap: () async {
//                           final selected = await AppSheets.selection
//                               .selectPaymentAccountType(
//                                 accountTypes: controller.availableAccountTypes,
//                               );

//                           if (selected == null) return;

//                           controller.selectAccountType(selected);
//                         },
//                       ),
//                     ),

//                     Row(
//                       spacing: 8,
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 8,
//                           ),
//                           // width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: context.colors.border),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     'Icon',
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       height: 20 / 15,
//                                       color: Colors.black54,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Icon(Icons.error_outline, size: 20),
//                               // TextField(
//                               //   controller: nameController,
//                               //   decoration: const InputDecoration(labelText: 'Category Name', border: OutlineInputBorder()),
//                               // ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             height: 60,
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 8,
//                             ),
//                             // width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(color: context.colors.border),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               // spacing: -2,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Name',
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     height: 20 / 15,
//                                     color: Colors.black54,
//                                   ),
//                                 ),
//                                 Text(
//                                   'Here is a sample text',
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     height: 20 / 17,
//                                     // color: Colors.black54,
//                                   ),
//                                   maxLines: 1,
//                                 ),
//                                 // TextField(
//                                 //   controller: nameController,
//                                 //   decoration: const InputDecoration(labelText: 'Category Name', border: OutlineInputBorder()),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 12.0,
//                   right: 12.0,
//                   bottom: 12.0,
//                 ),
//                 child: Row(
//                   spacing: 8,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 24,
//                         vertical: 12,
//                       ),
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(999),
//                         border: Border.all(color: context.colors.border),
//                       ),
//                       // height: 40,
//                       child: Text(
//                         'Cancel',
//                         style: TextStyle(fontSize: 15, height: 20 / 15),
//                       ),
//                     ),
//                     Flexible(
//                       child: GestureDetector(
//                         onTap: () {
//                           controller.saveAccount();
//                           Get.back();
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 24,
//                             vertical: 12,
//                           ),
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(999),
//                             // border: Border.all(color: context.colors.border),
//                             color: context.colors.border.withAlpha(60),
//                           ),

//                           child: Text(
//                             'Save Payment Account',
//                             style: TextStyle(fontSize: 15, height: 20 / 15),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
