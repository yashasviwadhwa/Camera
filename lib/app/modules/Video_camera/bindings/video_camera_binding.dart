import 'package:get/get.dart';

import '../controllers/video_camera_controller.dart';

class VideoCameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoCameraController>(
      () => VideoCameraController(),
    );
  }
}
