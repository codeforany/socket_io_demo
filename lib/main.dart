import 'dart:io';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_demo/common/socket_helper.dart';
import 'common/analytics_helper.dart';
import 'common/dynamic_link_helper.dart';
import 'common/my_http_overrides.dart';
import 'package:firebase_core/firebase_core.dart';
import 'details_view.dart';
import 'firebase_options.dart';
import 'home_view.dart';

void main() async {

  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
// Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  //SocketManager.shared.initSocket();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Socket io',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  DynamicLinkHelper dHelper = DynamicLinkHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dHelper.initDynamicLinks((openLink) {
      print(openLink.link.path);
      AnalyticHelper.eventLog("open_link",
          {
        "event_name": "open_link",
        "name": "Code For Any", "address": "address", "path": openLink.link.path
      });
      if(openLink.link.path == "/home") {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView() ));
      }else if(openLink.link.path == "/details") {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsView() ));
      }
    });
  }
  void _incrementCounter() {
    throw Exception();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            TextButton(onPressed: (){
              throw const FormatException(" Button Press on Format Exception");
            }, child: const Text(
                  'FormatException Fire',
                )),


            TextButton(
                onPressed: () {
                  dHelper.createDynamicLink("home");
                },
                child: const Text(
                  'Dynamic link Create Home Path',
                ))
                ,

              TextButton(
                onPressed: () {
                  dHelper.createDynamicLink("details");
                },
                child: const Text(
                  'Dynamic link Create Details Path',
                )),
                TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeView()));
                },
                child: const Text(
                  'Home',
                )),
            TextButton(
                onPressed: () {
                   
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DetailsView()));
                  
                },
                child: const Text(
                  ' Details',
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
