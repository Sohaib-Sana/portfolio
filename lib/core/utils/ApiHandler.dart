import 'package:flutter/material.dart';

enum ApiState { loading, success, error }

extension ApiStateExtension on ApiState {
  String get message => switch (this) {
        ApiState.loading => "Fetching data...",
        ApiState.success => "Data loaded successfully!",
        ApiState.error => "Something went wrong!",
      };

  IconData get icon => switch (this) {
        ApiState.loading => Icons.refresh,
        ApiState.success => Icons.check_circle_outline,
        ApiState.error => Icons.error_outline,
      };

  Color get color => switch (this) {
        ApiState.loading => Colors.blue,
        ApiState.success => Colors.green,
        ApiState.error => Colors.red,
      };
}

class ApiStatusWidget extends StatelessWidget {
  final ApiState status;
  const ApiStatusWidget({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(status.icon, color: status.color, size: 50),
          Text(status.message,
              style: TextStyle(color: status.color, fontSize: 18)),
        ],
      ),
    );
  }
}

void main() => runApp(const MaterialApp(
    home: Scaffold(body: ApiStatusWidget(status: ApiState.loading))));
