import 'package:calculator_flutter/bloc/carousel/carousel_bloc.dart';

abstract class CarouselState {}

class CarouselLoading extends CarouselState {}

class CarouselLoaded extends CarouselState {
  final List<CarouselItem> items;
  CarouselLoaded(this.items);
}

class CarouselError extends CarouselState {
  final String error;
  CarouselError(this.error);
}
