import 'package:flutter/material.dart';

class UnderDevelopment extends StatefulWidget {
  const UnderDevelopment({super.key});

  @override
  State<UnderDevelopment> createState() => _UnderDevelopmentState();
}

class _UnderDevelopmentState extends State<UnderDevelopment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sorry!\nThis part is still under development\nPlease go back",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
