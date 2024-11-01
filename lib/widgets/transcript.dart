import 'package:flutter/material.dart';
import 'package:earning_tracker/models/earningstranscriptmodel.dart';
import 'package:earning_tracker/services/apiservices.dart';

class Transcript extends StatelessWidget {
  final String ticker;
  final int year;
  final int quarter;

  const Transcript({
    super.key,
    required this.ticker,
    required this.year,
    required this.quarter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$ticker Earnings Transcript'),
      ),
      body: FutureBuilder<List<EarningsTranscriptModel>>(
        future: Apiservices().getEarningTranscript(ticker, year, quarter),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading data: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No transcripts available for $ticker in Q$quarter, $year',
                textAlign: TextAlign.center,
              ),
            );
          }

          final transcripts = snapshot.data!;

          return ListView.builder(
            itemCount: transcripts.length,
            itemBuilder: (context, index) {
              final transcript = transcripts[index];
              return ListTile(
                title: const Text('Transcript'), // You can set this as needed
                subtitle:
                    Text(transcript.transcript), // Display the transcript text
              );
            },
          );
        },
      ),
    );
  }
}
