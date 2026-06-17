import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParticipantModel {
  final int entityId;

  final String name;

  final String? iconKey;

  final RxBool isActive;

  final RxDouble amount;

  final RxDouble percentage;

  final FocusNode focusNode;

  final TextEditingController textController;

  ParticipantModel({
    required this.entityId,
    required this.name,
    this.iconKey,
    bool isActive = false,
    double amount = 0,
    double percentage = 0,
  }) : amount = amount.obs,
       percentage = percentage.obs,
       isActive = isActive.obs,
       focusNode = FocusNode(),
       textController = TextEditingController();
}
