abstract class ScreenshotEvent {}

class CaptureScreenshot extends ScreenshotEvent {}

class ShowScreenshot extends ScreenshotEvent {}

class HideScreenshot extends ScreenshotEvent {}

class ShowMask extends ScreenshotEvent {}

class HideMask extends ScreenshotEvent {}
