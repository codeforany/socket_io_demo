import 'package:flutter/material.dart';
import 'package:socket_io_demo/common/analytics_helper.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AnalyticHelper.eventLog("open_home", {"event_name": "open_home" ,"name":"Code For Any","address" : "address" } );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),),
      backgroundColor: Colors.red,
    );
  }
}