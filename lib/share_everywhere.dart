library share_everywhere;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class SocialConfig extends Object {
  /// Create configuration for social network
  ///
  /// requires [type] to be facebook, linkedin or twitter
  ///
  /// The [icon] is optional to add a custom social network logo
  SocialConfig({required this.type, this.appId, this.icon});

  /// Required by facebook
  var appId;

  /// Allowed types are: facebook, linkedin and twitter
  String type;

  Image? icon;

  IconButton button(url) {
    if (this.type == "facebook") {
      var _url =
          "https://www.facebook.com/dialog/share?app_id=$appId&display=page&href=$url";
      return IconButton(
        icon: icon ??
            new Image.asset(
              'icons/facebook.png',
              package: 'share_everywhere',
            ),
        onPressed: () => {_launchURL(_url)},
      );
    }
    if (this.type == "linkedin") {
      var _url = "https://www.linkedin.com/sharing/share-offsite/?url=$url";
      return IconButton(
        icon: icon ??
            new Image.asset(
              'icons/linkedin.png',
              package: 'share_everywhere',
            ),
        onPressed: () => {_launchURL(_url)},
      );
    }
    if (this.type == "twitter") {
      var _url = "https://twitter.com/intent/tweet?text=$url";
      return IconButton(
        icon: icon ??
            new Image.asset(
              'icons/twitter.png',
              package: 'share_everywhere',
            ),
        onPressed: () => {_launchURL(_url)},
      );
    }

    return IconButton(
      icon: Icon(Icons.error),
      onPressed: () => {},
    );
  }

  void _launchURL(_url) async => await canLaunchUrl(_url)
      ? await launchUrl(
          _url,
          webOnlyWindowName: "_blank",
        )
      : throw 'Could not launch $_url';
}

class ShareController {
  List<SocialConfig> networks = [];
  String? title;
  Text? elevatedButtonText;

  ShareController(
      {this.title, required this.networks, this.elevatedButtonText});
}

class ShareButton extends StatefulWidget {
  final ShareController controller;
  final String url;
  ShareButton(this.controller, this.url);

  _ShareButtonState createState() => _ShareButtonState(controller, url);
}

class _ShareButtonState extends State<ShareButton> {
  ShareController controller;
  String url;

  var startButton;

  List<IconButton> buttons = [];

  _ShareButtonState(this.controller, this.url) {
    for (var network in controller.networks) {
      buttons.add(network.button(url));
    }
    if (controller.elevatedButtonText != null) {
      startButton = ElevatedButton(
        onPressed: () => {share()},
        child: controller.elevatedButtonText,
      );
    }
  }

  void share() {
    print(Theme.of(context).platform);
    if (Theme.of(context).platform == TargetPlatform.android ||
        Theme.of(context).platform == TargetPlatform.iOS) {
      Share.share(url);
    } else {
      print(url);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: controller.title != null
                  ? Text(
                      controller.title ?? '',
                      textAlign: TextAlign.center,
                    )
                  : null,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buttons,
                ),
              ],
            );
          });
    }
  }

  Widget build(BuildContext context) {
    return startButton;
  }
}
