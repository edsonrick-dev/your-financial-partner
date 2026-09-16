import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum LearnStatus {
  available,
  watched,
  locked;

  IconData get icon {
    return switch (this) {
      LearnStatus.available => PhosphorIconsFill.book,
      LearnStatus.watched => PhosphorIconsRegular.check,
      LearnStatus.locked => PhosphorIconsRegular.lock,
    };
  }
}
