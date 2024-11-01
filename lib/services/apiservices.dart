import 'dart:convert';
import 'dart:developer';
import 'package:earning_tracker/models/earnings.dart';
import 'package:earning_tracker/models/earningstranscriptmodel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

const baseurl = "https://api.api-ninjas.com/v1/";
var key = "?api_key=${dotenv.env['apikey']}";

class Apiservices {
  Future<List<EarningChartModel>> getEarningChart(String ticker) async {
    final endpoints = "earningscalendar?ticker=$ticker";
    final url = "$baseurl$endpoints";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        log('Success');
        final jsonList = json.decode(response.body) as List<dynamic>;
        return jsonList
            .map((item) => EarningChartModel.fromJson(item))
            .toList();
      } else {
        log('Failed to load earnings data: ${response.statusCode}');
        throw Exception('Failed to load earnings data');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<EarningsTranscriptModel>> getEarningTranscript(
      String ticker, int year, int quarter) async {
    final endpoints =
        "earningstranscript?ticker=$ticker&year=$year&quarter=$quarter&api_key=$key";
    final url = "$baseurl$endpoints";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        log('Success');
        final jsonResponse = json.decode(response.body);

        // Check if the response is a List or a Map
        if (jsonResponse is List) {
          return jsonResponse
              .map((item) => EarningsTranscriptModel.fromJson(item))
              .toList();
        } else if (jsonResponse is Map<String, dynamic>) {
          // Handle the case where a single object is returned
          return [EarningsTranscriptModel.fromJson(jsonResponse)];
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        log('Failed to load earnings data: ${response.statusCode}');
        throw Exception('Failed to load earnings data');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Failed to fetch data');
    }
  }
}
