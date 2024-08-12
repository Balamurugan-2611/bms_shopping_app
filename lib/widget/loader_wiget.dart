import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderPage extends StatefulWidget {
  final double heightDiv;

  const LoaderPage({Key? key, this.heightDiv = 1.0}) : super(key: key);

  @override
  _LoaderPageState createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCubeGrid(color: Colors.redAccent),
      ),
    );
  }
}
