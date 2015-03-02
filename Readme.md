iOS Test Task 

solved by Tudor Munteanu


## Implementation

The task has been implemented in Xcode 6.1.1 and Objective-C.

CocoaPods is used to manage dependencies. 
To compile the project, run ``pod install`` in Terminal, while being in the same working dir as QapitalTest.xcworkspace. Then open QapitalTest.xcworkspace and hit run.

You will need to change the Bundle ID to your team's wildcard Bundle Identifier.

Localization has been configured for the app and currently set to English and Swedish (well, not really Swedish, but the code works).

## Target iOS version

The project is targeted currently for iOS 8+

## Testing

The tests are handled in the QapitalTestTests target and written 
with the help of Kiwi, for many reasons - one being better readability.

The core components of the app are currently tested: the controllers, the managers and data formatters. 

No view logic has been tested and the main reason is that testing UIViews is that I don't know how final the layouts are. If the screens are still WIP, the tests will need refactoring anyway.

To avoid any side effects while testing, a separate AppDelegate has been created and loaded in main.m.

## Libraries used

1. AFNetworking - for network communicatios
2. ColorUtils - simple UIColor helper
3. DCKeyValueObjectMapping - for easier NSDictionary parsing into models
4. JLRoutes - for cleaner navigation between UIViewControllers
5. Kiwi - for testing
6. Masonry - for programmatic AutoLayout
