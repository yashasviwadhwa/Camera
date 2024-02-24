import 'package:get/get.dart';

import '../modules/Video_camera/bindings/video_camera_binding.dart';
import '../modules/Video_camera/views/video_camera_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.VIDEO_CAMERA;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_CAMERA,
      page: () => VideoCameraView(),
      binding: VideoCameraBinding(),
    ),
  ];
}
