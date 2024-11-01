import 'dart:convert';

class EarningsTranscriptModel {
  String transcript;

  EarningsTranscriptModel({
    required this.transcript,
  });

  EarningsTranscriptModel copyWith({
    String? transcript,
  }) =>
      EarningsTranscriptModel(
        transcript: transcript ?? this.transcript,
      );

  factory EarningsTranscriptModel.fromRawJson(String str) =>
      EarningsTranscriptModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EarningsTranscriptModel.fromJson(Map<String, dynamic> json) =>
      EarningsTranscriptModel(
        transcript: json["transcript"],
      );

  Map<String, dynamic> toJson() => {
        "transcript": transcript,
      };
}
