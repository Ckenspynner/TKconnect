import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tkconnect/utils/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../utils/size_config.dart';

class WastePlayerMap extends StatefulWidget {
  const WastePlayerMap({Key? key}) : super(key: key);

  @override
  State<WastePlayerMap> createState() => _WastePlayerMapState();
}

class _WastePlayerMapState extends State<WastePlayerMap> {

  late final WebViewController controller;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = WebViewController()
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..setBackgroundColor(const Color(0x00000000))
    // ..setNavigationDelegate(
    //   NavigationDelegate(
    //     onProgress: (int progress) {
    //       // Update loading bar.
    //     },
    //     onPageStarted: (String url) {},
    //     onPageFinished: (String url) {},
    //     onWebResourceError: (WebResourceError error) {},
    //     onNavigationRequest: (NavigationRequest request) {
    //       if (request.url.startsWith('https://www.youtube.com/')) {
    //         return NavigationDecision.prevent;
    //       }
    //       return NavigationDecision.navigate;
    //     },
    //   ),
    // )
  //     ..loadRequest(Uri.parse('https://ckenspynner.github.io/Waste-Resource-Player/'));
  // }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20),vertical: getProportionateScreenWidth(20) ),
          child: const Text('Waste Players Interactive Map',),//SectionTitle(title: "Waste Players Map", press: () {}),
        ),


        // SingleChildScrollView(
        //   child: SizedBox(
        //     height: MediaQuery.of(context).size.height*0.8,
        //     child: WebViewWidget(controller: controller),
        //   ),
        // ),

        SizedBox(
          height: MediaQuery.of(context).size.height*0.8,
          child: const InteractiveMap(),
        ),
      ],
    );
  }
}



class InteractiveMap extends StatefulWidget {
  const InteractiveMap({Key? key}) : super(key: key);

  @override
  State<InteractiveMap> createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {

  double _progress = 0;
  late InAppWebViewController  inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{

        var isLastPage = await inAppWebViewController.canGoBack();

        if(isLastPage){
          inAppWebViewController.goBack();
          return false;
        }

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            color: const Color(0xFFB4B4B4),
            child: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(
                      url: Uri.parse("https://ckenspynner.github.io/Waste-Resource-Player/")
                  ),
                  onWebViewCreated: (InAppWebViewController controller){
                    inAppWebViewController = controller;
                  },
                  onProgressChanged: (InAppWebViewController controller , int progress){
                    setState(() {
                      _progress = progress / 100;
                    });
                  },
                ),
                _progress < 1 ? Container(
                  child: LinearProgressIndicator(
                    color: kPrimaryColor,
                    backgroundColor:
                    const Color(0xFFB4B4B4),
                    value: _progress,
                  ),
                ):const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
