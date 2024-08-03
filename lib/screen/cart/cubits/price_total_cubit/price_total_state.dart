part of 'price_total_cubit.dart';

sealed class PriceTotalState extends Equatable {
  const PriceTotalState();

  @override
  List<Object> get props => [];
}

final class CountPriceTotal extends PriceTotalState {
  final double priceTotal;
  const CountPriceTotal(this.priceTotal);

  @override
  List<Object> get props => [priceTotal];
}
