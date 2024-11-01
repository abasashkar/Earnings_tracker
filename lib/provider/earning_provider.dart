import 'package:earning_tracker/widgets/transcript.dart';
import 'package:flutter/material.dart';
import 'package:earning_tracker/models/earnings.dart';
import 'package:earning_tracker/services/apiservices.dart';

class EarningsProvider extends ChangeNotifier {
  final Apiservices _apiServices = Apiservices();
  List<EarningChartModel> _earningsData = [];
  bool _isLoading = false;
  String? _error;

  List<EarningChartModel> get earningsData => _earningsData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchEarningsData(String ticker) async {
    _isLoading = true;
    _error = null;
    notifyListeners(); // Notify the UI to show loading indicator

    try {
      final results = await _apiServices.getEarningChart(ticker);
      _earningsData = results;
    } catch (error) {
      _error = 'Failed to load data';
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify the UI of the updated state
    }
  }

  void navigateToTranscript(BuildContext context, String quarter, int year) {
    if (_earningsData.isNotEmpty) {
      final ticker = _earningsData[0].ticker;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Transcript(
            ticker: ticker,
            year: year,
            quarter: int.parse(quarter),
          ),
        ),
      );
    }
  }
}
