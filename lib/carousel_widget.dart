import 'package:calculator_flutter/bloc/carousel/carousel_bloc.dart';
import 'package:calculator_flutter/bloc/carousel/carousel_event.dart';
import 'package:calculator_flutter/bloc/carousel/carousel_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarouselBloc()..add(LoadCarouselItems()),
      child: BlocBuilder<CarouselBloc, CarouselState>(
        builder: (context, state) {
          if (state is CarouselLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CarouselError) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is CarouselLoaded) {
            return SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  final formattedPrice =
                      NumberFormat('#,##0.00').format(item.price);
                  return Container(
                    width: 145,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Image.asset(item.iconPath, width: 40, height: 40),
                            const SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.heading,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  item.subheading,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          '\$$formattedPrice', // Используем отформатированную цену
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          '${item.percentage >= 0 ? '+' : ''}${item.percentage.toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: item.percentage >= 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Buy Crypto',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
