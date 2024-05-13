
import 'package:birikimapp/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
            body: ListView(
          children: value.vals
              .map((v) => ListTile(
                    title: Text(v.code),
            subtitle: Text('${v.v}'),
                  ))
              .toList(),
        ));
      },
    );
  }
}
