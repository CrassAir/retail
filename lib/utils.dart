import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

const notificationDuration = Duration(seconds: 3);
late Timer timer;

AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

void loadingSnack() {
  if (Get.isSnackbarOpen) {
    return;
  }
  Future.delayed(Duration.zero, () {
    Get.snackbar('', '',
        titleText: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Loading...',
              style: TextStyle(fontSize: 28),
            ),
            CircularProgressIndicator()
          ],
        ),
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(minutes: 1));
  });
}

void messageSnack({required String title, bool isSuccess = true, String? sub}) {
  Get.snackbar(
    title,
    sub ?? '',
    animationDuration: const Duration(milliseconds: 500),
    backgroundColor: isSuccess ? Colors.green : Colors.red,
    dismissDirection: DismissDirection.startToEnd,
    duration: notificationDuration,
  );
}

extension Extension on Object? {
  bool get hasData => !['', null, false, {}].contains(this);
}

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      padding: const EdgeInsets.all(2.0),
      child: const CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 3,
      ),
    );
  }
}
