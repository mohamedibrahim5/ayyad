import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';

class WebViewPaymentScreen extends StatefulWidget {
  const WebViewPaymentScreen({super.key,});

  @override
  State<WebViewPaymentScreen> createState() => _WebViewPaymentScreenState();
}



class _WebViewPaymentScreenState extends State<WebViewPaymentScreen> {
  late WebViewController controller ;
  late String url ;
  late Map args ;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () {
    });
    args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    url = args['url'];
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            if(url.contains('success=true')){
              if(!mounted) return ;
              // BaseScreenNavigationCubit.get(context).reset();
              sl<NavigationService>().navigateReplacementTo(RoutesManager.orderConfirmedScreen);

            }else if (url.contains('failed')) {
              if(!mounted) return ;
              sl<NavigationService>().popup();

            }else if (url.contains('success')){
              if(!mounted) return ;
              sl<NavigationService>().navigateReplacementTo(RoutesManager.orderConfirmedScreen);
            }
          },
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

  }
}
