import 'package:flutter/material.dart';
import 'package:ubenwa/core/core.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.of(context).light(Theme.of(context)),
        darkTheme: AppTheme.of(context).dark(Theme.of(context)),
        home: const Text("data"),
      ),
    );
  }
}
