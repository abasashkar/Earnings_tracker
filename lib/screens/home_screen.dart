// lib/screens/home_screen.dart
import 'package:earning_tracker/provider/earning_provider.dart';
import 'package:earning_tracker/widgets/earnings_garph.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController tickerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final earningsProvider = Provider.of<EarningsProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Center(
            child: Text(
              'Earnings Tracker',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 35, 22, 0),
          child: Column(
            children: [
              TextField(
                controller: tickerController,
                decoration: InputDecoration(
                  labelText: 'Enter Company name',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => earningsProvider
                        .fetchEarningsData(tickerController.text),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (earningsProvider.isLoading)
                const CircularProgressIndicator()
              else if (earningsProvider.error != null)
                Text(
                  earningsProvider.error!,
                  style: const TextStyle(color: Colors.red),
                )
              else if (earningsProvider.earningsData.isNotEmpty)
                Expanded(
                  child: EarningsGraph(
                    earningData: earningsProvider.earningsData,
                    onPointClicked: (quarter, year) {
                      earningsProvider.navigateToTranscript(
                          context, quarter, year);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
