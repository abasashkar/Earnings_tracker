# Earnings Tracker

## Description
Earnings Tracker is a simple application that allows users to track a company's estimated versus actual earnings. By entering a company's ticker symbol (e.g., MSFT for Microsoft), users can view a graphical comparison of the company's estimated earnings and actual earnings for different quarters. The app also provides access to earnings call transcripts for further insights.

## Features
- Prompt user for a company ticker symbol.
- Fetch earnings data using the Earnings Calendar API.
- Display an interactive graph comparing estimated and actual earnings.
- Clickable data points to retrieve earnings call transcripts for specific quarters.
- Clean and user-friendly interface.

## Requirements
- Flutter SDK
- Dart
- Internet connection to fetch data from APIs.

## APIs Used
- [Earnings Calendar API](https://api-ninjas.com/api/earningscalendar)
- [Earnings Call Transcript API](https://api-ninjas.com/api/earningscalltranscript)

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/<USERNAME>/earning_tracker.git
2. Navigate to the project directory:
   cd earning_tracker
3.Install the dependencies:
  flutter pub get
4.Set Up Environment Variables:
  Create a .env file in the root directory of the project.
  Add your API key in the following format:
  API_KEY=your_api_key_here
  Replace your_api_key_here with the actual API key you received from API Ninjas.
5.Security Note: Ensure that your .env file is included in your .gitignore file to prevent it from being pushed to version control.

Usage;
1.Run the application:
flutter run
2.Enter the company ticker symbol in the input field (e.g., MSFT).
3.View the estimated vs. actual earnings graph.
4.Click on any data point to view the corresponding earnings transcript

Code Quality and Standards
The code is structured to follow industry standards for readability and maintainability. Key aspects include:

Thoughtful architecture for scalability.
Effective state management for smooth user interactions.
Robust network operations for seamless API integration.










