# share_everywhere

Create a share button for all platforms.

On Android and IOS the share_plus functionality is used.

On Mac, Linux and Windows a popup is shown with the configured networks.

## Usage

import the package
```dart
import 'package:share_everywhere/share_everywhere.dart';
```
create a controller
```dart
ShareController shareController = ShareController(
    title: "Share on:",
    elevatedButtonText: Text("Share"),
    networks: [
      SocialConfig(type: "facebook", appId: "your-facebook-app-id"),
      SocialConfig(type: "linkedin"),
      SocialConfig(type: "twitter"),
    ],
  );
```

show the share button in a widget
```dart
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Click the share button below:',
            ),
            ShareButton(shareController, "https://example.com")
          ],
        ),
      ),
    );
  }
```

