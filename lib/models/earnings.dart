class EarningChartModel {
  final DateTime pricedate;
  final String ticker;
  final double actualEps;
  final double estimatedEps;
  final int actualRevenue;
  final int estimatedRevenue;

  EarningChartModel({
    required this.pricedate,
    required this.ticker,
    required this.actualEps,
    required this.estimatedEps,
    required this.actualRevenue,
    required this.estimatedRevenue,
  });

  factory EarningChartModel.fromJson(Map<String, dynamic> json) {
    return EarningChartModel(
      pricedate: json['pricedate'] != null
          ? DateTime.parse(json['pricedate'])
          : DateTime.now(),
      ticker: json['ticker'] ?? 'Unknown',
      actualEps:
          json['actual_eps'] != null ? json['actual_eps'].toDouble() : 0.0,
      estimatedEps: json['estimated_eps'] != null
          ? json['estimated_eps'].toDouble()
          : 0.0,
      actualRevenue: json['actual_revenue'] ?? 0,
      estimatedRevenue: json['estimated_revenue'] ?? 0,
    );
  }
}
