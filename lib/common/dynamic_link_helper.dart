import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLinkHelper {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  Future<void> initDynamicLinks( Function (PendingDynamicLinkData openLink) dataObj ) async {
    dynamicLinks.onLink.listen((dynamicLinkData) {

      dataObj(dynamicLinkData);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  Future<void> createDynamicLink(String  screenPath) async {


    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://codeforany.page.link',

      link: Uri.parse("https://codeforany.page.link/$screenPath"),
      androidParameters: const AndroidParameters(
        packageName: 'com.codeforany.socket_io_demo',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.codeforany.socketIoDemo',
        minimumVersion: '0',
      ),
    );

    Uri url;
    
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
      Share.share(url.toString());    
  }
}