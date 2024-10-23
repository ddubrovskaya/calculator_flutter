import 'package:flutter_bloc/flutter_bloc.dart';
import 'carousel_event.dart';
import 'carousel_state.dart';

class CarouselItem {
  final String title;
  final String iconPath;
  final String heading;
  final String subheading;
  final double price;
  final double percentage;

  CarouselItem({
    required this.title,
    required this.iconPath,
    required this.heading,
    required this.subheading,
    required this.price,
    required this.percentage,
  });
}

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  CarouselBloc() : super(CarouselLoading()) {
    on<LoadCarouselItems>(_onLoadCarouselItems);
  }

  Future<void> _onLoadCarouselItems(
      LoadCarouselItems event, Emitter<CarouselState> emit) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final items = [
        CarouselItem(
          title: 'Top Gainer',
          iconPath: 'assets/icons/bitcoin.png',
          heading: 'Bitcoin',
          subheading: 'BTC',
          price: 39943.00,
          percentage: 2.83,
        ),
        CarouselItem(
          title: 'Top Gainer',
          iconPath: 'assets/icons/bitcoin.png',
          heading: 'Bitcoin',
          subheading: 'BTC',
          price: 2500.00,
          percentage: -3.3,
        ),
        CarouselItem(
          title: 'Top Gainer',
          iconPath: 'assets/icons/bitcoin.png',
          heading: 'Bitcoin',
          subheading: 'BTC',
          price: 45652.00,
          percentage: 1.45,
        ),
        CarouselItem(
          title: 'Top Gainer',
          iconPath: 'assets/icons/bitcoin.png',
          heading: 'Bitcoin',
          subheading: 'BTC',
          price: 76547.00,
          percentage: -0.45,
        ),
        CarouselItem(
          title: 'Top Gainer',
          iconPath: 'assets/icons/bitcoin.png',
          heading: 'Bitcoin',
          subheading: 'BTC',
          price: 234567.00,
          percentage: 7.3,
        ),
        CarouselItem(
          title: 'Top Gainer',
          iconPath: 'assets/icons/bitcoin.png',
          heading: 'Bitcoin',
          subheading: 'BTC',
          price: 3480.00,
          percentage: -7.89,
        ),
      ];
      emit(CarouselLoaded(items));
    } catch (e) {
      emit(CarouselError(e.toString()));
    }
  }
}
