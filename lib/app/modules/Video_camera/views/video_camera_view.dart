import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../controllers/video_camera_controller.dart';

class VideoCameraView extends GetView<VideoCameraController> {
  const VideoCameraView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Obx(
              () => Icon(
                controller.isFlashOn.value ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              controller.toggleFlashLight();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: const Icon(Icons.cameraswitch_sharp),
                color: Colors.white,
                onPressed: () {
                  controller.switchCamera();
                },
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: controller.initializeCamera(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return buildCameraUI();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildCameraUI() {
    return Stack(
      children: [
        Positioned.fill(
          child: AspectRatio(
            aspectRatio: controller.camController?.value.aspectRatio ?? 1.0,
            child: GestureDetector(
              onTapDown: (TapDownDetails details) {
                controller.setFocusPoint(details);
              },
              child: CameraPreview(controller.camController!),
            ),
          ),
        ),
        if (controller.focusPoint.value != null)
          Positioned.fill(
            top: 50,
            child: Align(
              alignment: Alignment(
                controller.x.value * 2,
                controller.y.value * 2,
              ),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          top: 50,
          right: 10,
          child: Obx(
            () => SfSlider.vertical(
              min: 1.0,
              value: controller.currentZoom.value,
              max: 5.0,
              activeColor: Colors.black,
              onChanged: (value) {
                controller.zoomCamera(value);
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: controller.isFrontCamera.value
                  ? Colors.black45
                  : Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Video",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Photos",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.capturePhoto();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 5.w,
                              color: Colors.white,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
