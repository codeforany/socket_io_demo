import 'package:flutter/material.dart';

import 'common/analytics_helper.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({super.key});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AnalyticHelper.eventLog(
        "open_details", { "event_name": "open_details" , "name": "Code For Any", "address": "address", "type":"detilas"});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      backgroundColor: Colors.green,
    );
  }
}
