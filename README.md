# Shudder Demo
This example app was built to demonstrate my ability to clone an existing app from the store.

It features a very minimal set of requirements that was to mimic the look and feel of the existing iOS app, but use random images from the **Flickr API** 

## Running
To run the project via XCode simply `pod install` and then open the `ShudderDemo.xcworkspace` If you'd like to run the tests via command line use:

```bash
xcodebuild \
  -workspace ShudderDemo.xcworkspace \
  -scheme ShudderDemo \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone X,OS=latest' \
  test
```

## Flickr API
To successfully demo this app you will need to enter your own Flickr API token which can be obtained from (https://www.flickr.com/services/api/)[https://www.flickr.com/services/api/] the one hardcoded into the app has been removed and is no longer valid.