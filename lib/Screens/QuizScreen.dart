import 'dart:async';

import 'package:flutter/material.dart';

class CountdownScreen extends StatelessWidget {
  final Stream<int> _countdownStream = (() async* {
    for (var i = 15; i >= 0; i--) {
      yield i;
      await Future.delayed(Duration(seconds: 1));
    }
  })();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countdown Timer'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: _countdownStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                  ));
            } else {
              return Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: snapshot.data! /
                        15, // Adjust value to match your maximum countdown value
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  Text(
                    '${snapshot.data}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
