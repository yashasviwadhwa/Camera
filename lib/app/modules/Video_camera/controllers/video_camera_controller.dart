import 'dart:io';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class VideoCameraController extends GetxController {
  RxBool isCapturing = false.obs;
  RxDouble selectedCameraIndex = 0.0.obs;
  RxBool isFrontCamera = false.obs;
  RxBool isFlashOn = false.obs;
  Rx<Offset?> focusPoint = const Offset(0, 0).obs;
  RxDouble currentZoom = 1.0.obs;
  RxDouble maxZoom = 1.0.obs;
  Rx<File?> capturedImage = File('').obs;
  RxDouble x = 1.5.obs;
  RxDouble y = 1.5.obs;
  
  late CameraController camController;
  bool isCamControllerInitialized = false;

  @override
  void onInit() {
    try {
      super.onInit();
      initializeCamera();
    } catch (e) {
      debugPrint("$e Expcetion occurred");
    }
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      await camController.initialize();
      isCamControllerInitialized = true;
      camController = CameraController(
        cameras[selectedCameraIndex.value.toInt()],
        ResolutionPreset.max,
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> toggleFlashLight() async {
    if (isCamControllerInitialized) {
      isFlashOn.value = !isFlashOn.value;
      setFlashMode(isFlashOn.value ? FlashMode.torch : FlashMode.off);
    }
  }

  void setFlashMode(FlashMode mode) {
    camController.setFlashMode(mode);
    refresh();
  }

  @override
  void onClose() {
    disposeCameraController();
    super.onClose();
  }

  void disposeCameraController() {
    camController.dispose();
    isCamControllerInitialized = false;
  }

  Future<void> switchCamera() async {
    final cameras = await availableCameras();
    selectedCameraIndex.value =
        (selectedCameraIndex.value + 1) % cameras.length;
    await _initCamera(selectedCameraIndex.value.toInt());
    refresh();
  }

  Future<void> _initCamera(int cameraIndex) async {
    try {
      final cameras = await availableCameras();
      disposeCameraController();
      camController = CameraController(
        cameras[cameraIndex],
        ResolutionPreset.max,
      );
      await camController.initialize();
      isCamControllerInitialized = true;
      isFrontCamera.value = (cameraIndex == 0);
      debugPrint("Switch Camera ");
      refresh();
    } catch (e) {
      debugPrint('Error initializing camera: $e');
      disposeCameraController();
    }
    isFrontCamera.refresh();
    isFlashOn.refresh();
    refresh();
  }

  Future<void> capturePhoto() async {
    if (!camController.value.isInitialized ||
        camController.value.isTakingPicture) {
      return;
    }

    try {
      isCapturing.value = true;

      final XFile capturedImageFile = await camController!.takePicture();
      final String imagePath = capturedImageFile.path;

      GallerySaver.saveImage(imagePath, albumName: "YourAlbumName");

      debugPrint('Photo captured and saved to the gallery');
      capturedImage.value = File(imagePath);
    } catch (error) {
      debugPrint('Error capturing photo: $error');
    } finally {
      isCapturing.value = false;
    }
  }

  Future<void> zoomCamera(double value) async {
    if (!(camController.value.isInitialized)) {
      debugPrint(
          'Error: Zoom requested while camera is not initialized or unavailable.');
      return;
    }

    try {
      final maxZoom = await camController!.getMaxZoomLevel();
      value = value.clamp(1.0, maxZoom);
      await camController!.setZoomLevel(value);
      currentZoom.value = value;
    } catch (error) {
      debugPrint('Error setting zoom level: $error');
    }
  }

  Future<void> setFocusPoint(TapDownDetails details) async {
    await camController.initialize();

    if (!camController.value.isInitialized) {
      debugPrint('Error: Setting focus point while camera is not initialized.');
      return;
    }

    final Offset tapPosition = details.localPosition;
    final double clampedX = tapPosition.dx.clamp(0.3, 1.0);
    final double clampedY = tapPosition.dy.clamp(0.0, 1.0);

    try {
      await camController.setFocusPoint(Offset(clampedX, clampedY));
      await camController.setFocusMode(FocusMode.auto);
      focusPoint.value = Offset(clampedX, clampedY);
    } catch (error) {
      debugPrint('Error setting focus point and mode: $error');
    } finally {
      Future.delayed(const Duration(seconds: 2), () {
        focusPoint.value = null;
      });
    }
  }
}
