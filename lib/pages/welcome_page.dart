import 'package:flutter/material.dart';
import 'package:weather_app/pages/main_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            child: Text('witom'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const MainPage();
                  },
                ),
              );
            }),
      ),
    );
  }
}
