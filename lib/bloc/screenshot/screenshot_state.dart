import 'dart:ui' as ui;

abstract class ScreenshotState {}

class ScreenshotInitial extends ScreenshotState {}

class ScreenshotCaptured extends ScreenshotState {
  final ui.Image image;
  ScreenshotCaptured(this.image);
}

class ScreenshotDisplayed extends ScreenshotState {
  final ui.Image image;
  ScreenshotDisplayed(this.image);
}

class MaskVisibleState extends ScreenshotState {}
