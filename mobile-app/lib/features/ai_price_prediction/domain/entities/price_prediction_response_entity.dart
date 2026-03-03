/// Entity representing the AI prediction response.
class PricePredictionResponseEntity {
  final double predictedPrice;
  final String message;

  const PricePredictionResponseEntity({
    required this.predictedPrice,
    required this.message,
  });

  /// Convert price to different currencies.
  /// The AI model returns price in YER (Yemeni Rial).
  double getPriceInCurrency(String currency) {
    switch (currency.toUpperCase()) {
      case 'USD':
        return predictedPrice / 550;
      case 'SAR':
        return predictedPrice / 140;
      case 'YER':
      default:
        return predictedPrice;
    }
  }

  /// Get formatted price string with currency symbol
  String getFormattedPrice(String currency) {
    final price = getPriceInCurrency(currency);
    final formattedPrice = _formatNumber(price);
    return '$formattedPrice $currency';
  }

  String _formatNumber(double number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }
}
