import 'package:calculator_flutter/bloc/screenshot/screenshot_event.dart';
import 'package:calculator_flutter/bloc/screenshot/screenshot_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;
import 'package:logger/logger.dart';

class ScreenshotBloc extends Bloc<ScreenshotEvent, ScreenshotState> {
  final GlobalKey boundaryKey;
  final logger = Logger();

  ScreenshotBloc(this.boundaryKey) : super(ScreenshotInitial()) {
    on<CaptureScreenshot>(_onCaptureScreenshot);
    on<ShowScreenshot>(_onShowScreenshot);
    on<HideScreenshot>(_onHideScreenshot);
    on<ShowMask>(_onShowMask);
    on<HideMask>(_onHideMask);
  }

  Future<void> _onCaptureScreenshot(
      CaptureScreenshot event, Emitter<ScreenshotState> emit) async {
    try {
      RenderRepaintBoundary boundary = boundaryKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      emit(ScreenshotCaptured(image));
    } catch (e) {
      logger.e("Error capturing image: $e");
    }
  }

  void _onShowScreenshot(ShowScreenshot event, Emitter<ScreenshotState> emit) {
    if (state is ScreenshotCaptured) {
      emit(ScreenshotDisplayed((state as ScreenshotCaptured).image));
    }
  }

  void _onHideScreenshot(HideScreenshot event, Emitter<ScreenshotState> emit) {
    emit(ScreenshotInitial());
  }

  void _onShowMask(ShowMask event, Emitter<ScreenshotState> emit) {
    emit(MaskVisibleState());
  }

  void _onHideMask(HideMask event, Emitter<ScreenshotState> emit) {
    emit(ScreenshotInitial());
  }
}
