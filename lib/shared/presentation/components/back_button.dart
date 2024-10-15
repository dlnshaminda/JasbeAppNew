import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackButtonArrow extends StatelessWidget {
  const BackButtonArrow({
    super.key,
    
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(
        Icons.chevron_left_rounded,
        size: 40,
      ),
    );
  }
}
