PayPal iOS SDK
==============

The PayPal iOS SDK provides a software library that makes it easy for iOS developers
to accept both credit cards and PayPal directly within native mobile apps.

For an introduction, see the
[PayPal Mobile SDK Overview](https://developer.paypal.com/webapps/developer/docs/integration/mobile/mobile-sdk-overview/).

![Screen shots of the iOS SDK UI](https://raw.github.com/paypal/PayPal-iOS-SDK/screenshots/sdk-screens.jpg)

### Table of Contents

- [Overview](#overview)
- [Integration](#integration)
  - [Requirements](#requirements)
  - [Initial Setup](#initial-setup)
  - [Credentials](#credentials)
  - [Sample Code](#sample-code)
- [Testing](#testing)
- [International Support](#international-support)
  - [Localizations](#localizations)
  - [Currencies](#currencies)
- [Hints & Tips](#hints-&-tips)
- [Older Libraries](#older-libraries)

Overview
--------

* The PayPal iOS SDK...
    1. Takes care of the UI to gather payment information from the user.
    2. Coordinates payment with PayPal.
    3. Returns to you a proof of payment.
* Your code...
    1. Receives proof of payment from the PayPal iOS SDK.
    2. [Sends proof of payment to your servers for verification](https://developer.paypal.com/webapps/developer/docs/integration/mobile/verify-mobile-payment/).
    3. Provides the user their goods or services.

Integration
-----------

### Requirements

* Xcode 5+
* iOS 6+ target deployment
* armv7, armv7s, and arm64 devices and the simulator (not armv6)
* iPhone and iPad of all sizes and resolutions


### Initial Setup

1. Clone or download the SDK, which consists of header files, license acknowledgements, release notes, and a static library. It also includes a sample app.
2. Add the `PayPalMobile` directory (containing several .h files and libPayPalMobile.a) to your Xcode project. We recommend checking "Copy items..." and selecting "Create groups...".
3. In your project's **Build Settings** (in the `TARGETS` section, not the `PROJECTS` section) add `-lc++ -ObjC` to Other Linker Flags.
4. In your project's **Build Phases**, *either:*
  * Link your project with these libraries. [Weak linking](http://developer.apple.com/library/mac/#documentation/DeveloperTools/Conceptual/cross_development/Configuring/configuring.html) for iOS versions back to 6.0 is supported.
    * `AVFoundation.framework`
    * `AudioToolbox.framework`
    * `CoreMedia.framework`
    * `CoreVideo.framework`
    * `libxml2.dylib`
    * `MessageUI.framework`
    * `MobileCoreServices.framework`
    * `OpenGLES.framework`
    * `QuartzCore.framework`
    * `Security.framework`
    * `SystemConfiguration.framework`
    * `UIKit.framework`
5. *or,* if you are using Xcode 5 or newer:
  * Add only these frameworks to your project:
    * `libxml2.dylib`
    * `AVFoundation.framework`
    * `CFNetWork.framework`
    * `MessageUI.framework`
    * `SystemConfiguration.framework`
  * and confirm that these two Build Settings are both enabled:
    * `Enable Modules (C and Objective-C)`
    * `Link Frameworks Automatically`
6. Add [the SDK's open source license acknowledgments](https://github.com/paypal/PayPal-iOS-SDK/blob/master/acknowledgments.md) to [your app's acknowledgments](http://stackoverflow.com/questions/3966116/where-to-put-open-source-credit-information-for-an-iphone-app).


### Credentials

Take note of these two identifiers:

  - `clientId`
  - `receiverEmail`
  
You can obtain your PayPal API credentials, including Client ID, by visiting the [Applications page on the PayPal Developer site](https://developer.paypal.com/webapps/developer/applications) and logging in with your PayPal account.

Once logged in on this page, you will be assigned a **sandbox** Client ID, which will let you test your iOS integration against the PayPal sandbox. In your code, set `receiverEmail` to a *business* sandbox account email address, then use a *personal* sandbox account email and password to log in to PayPal in the UI of your app. You can create business and personal sandbox accounts on the [Sandbox accounts](https://developer.paypal.com/webapps/developer/applications/accounts) page.

To obtain your **live** Client ID, you will need to have a business account. If you don't yet have a business account, there is a link at the bottom of that same Applications page that will get you started. For live transactions, use your PayPal email address as `receiverEmail`.



### Sample Code

1. Create a class (most likely a subclass of UIViewController) that conforms to PayPalPaymentDelegate.

    ```obj-c
    // SomeViewController.h
    #import "PayPalMobile.h"

    @interface SomeViewController : UIViewController<PayPalPaymentDelegate>
    // ...
    @end
    ```

2. In your implementation, create a `PayPalPayment` with an amount, a currency code, and a description.

    ```obj-c
    // SomeViewController.m

    - (IBAction)pay {

      // Create a PayPalPayment
      PayPalPayment *payment = [[PayPalPayment alloc] init];
      payment.amount = [[NSDecimalNumber alloc] initWithString:@"39.95"];
      payment.currencyCode = @"USD";
      payment.shortDescription = @"Awesome saws";

      // Check whether payment is processable.
      if (!payment.processable) {
        // If, for example, the amount was negative or the shortDescription was empty, then
        // this payment would not be processable. You would want to handle that here.
      }

      // continued below...
    ```

3. Create and display a `PayPalPaymentViewController` with the payment and your credentials (see above).

   **Tip:** Providing a `payerId` enables an improved experience
   for returning users. If you have a customer identifier that is *not* hardware- or device-based,
   such as an email address or a unique user ID in your system, you should provide it as a
   `payerId`; otherwise, pass `nil`.

    ```obj-c
      // ...continued from above

      // Start out working with the test environment! When you are ready, remove this line to switch to live.
      [PayPalPaymentViewController setEnvironment:PayPalEnvironmentNoNetwork];

      // Provide a payerId that uniquely identifies a user within the scope of your system,
      // such as an email address or user ID.
      NSString *aPayerId = @"someuser@somedomain.com";

      // Create a PayPalPaymentViewController with the credentials and payerId, the PayPalPayment
      // from the previous step, and a PayPalPaymentDelegate to handle the results.
      PayPalPaymentViewController *paymentViewController;
      paymentViewController = [[PayPalPaymentViewController alloc] initWithClientId:@"YOUR_CLIENT_ID"
                                                                      receiverEmail:@"YOUR_PAYPAL_EMAIL_ADDRESS"
                                                                            payerId:aPayerId
                                                                            payment:payment
                                                                           delegate:self];

      // Present the PayPalPaymentViewController.
      [self presentViewController:paymentViewController animated:YES completion:nil];
    }
    ```

4. Write delegate methods to receive either the completed payment or a cancellation. These delegate methods
   are responsible for dismissing the modal view controller.

    ```obj-c
    // SomeViewController.m

    #pragma mark - PayPalPaymentDelegate methods

    - (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment {
      // Payment was processed successfully; send to server for verification and fulfillment.
      [self verifyCompletedPayment:completedPayment];

      // Dismiss the PayPalPaymentViewController.
      [self dismissViewControllerAnimated:YES completion:nil];
    }

    - (void)payPalPaymentDidCancel {
      // The payment was canceled; dismiss the PayPalPaymentViewController.
      [self dismissViewControllerAnimated:YES completion:nil];
    }
    ```

5. [Send the proof of payment to your servers for verification](https://developer.paypal.com/webapps/developer/docs/integration/mobile/verify-mobile-payment/),
   as well as any other processing required for your business, such as fulfillment.

   **Tip:** At this point, the payment has been completed, and the user
   has been charged. If you can't reach your server, it is important that you save the proof
   of payment and try again later.

    ```obj-c
    // SomeViewController.m

    - (void)verifyCompletedPayment:(PayPalPayment *)completedPayment {
      // Send the entire confirmation dictionary
      NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation
                                                             options:0
                                                               error:nil];

      // Send confirmation to your server; your server should verify the proof of payment
      // and give the user their goods or services. If the server is not reachable, save
      // the confirmation and try again later.
    }
    ```


6. **Optional:** Add a preconnect to PayPal's servers.

   We recommend doing the preconnect when you first display the view controller from which your users will initiate payment.
   (Do not preconnect significantly earlier than that, as the connection has a limited lifetime.)

    ```obj-c
    // SomeViewController.m

    - (void)viewWillAppear:(BOOL)animated {
      [super viewWillAppear:animated];

      // Start out working with the test environment! When you are ready, remove this line to switch to live.
      [PayPalPaymentViewController setEnvironment:PayPalEnvironmentNoNetwork];
      [PayPalPaymentViewController prepareForPaymentUsingClientId:@"YOUR_CLIENT_ID"];
    }
    ```

Testing
-------

During development and testing, use `+setEnvironment:` to avoid moving real money around. See the header files for more information.


Usability
---------

User interface appearance and behavior is set within the library itself. For the sake of usability and user experience consistency, apps should not adjust appearance properties or attempt to modify the SDK's behavior beyond the documented methods in the provided headers.

Specifically, if you are using `UIAppearance` to modify the appearance of any UI elements in your app, you should reverse those changes prior to presenting our viewcontroller, and set them again after dismissing the viewcontroller. 


International Support
---------------------

### Localizations

The SDK has built-in translations for many languages and locales. See the header files for a complete list.

### Currencies

The SDK supports multiple currencies. See [the REST API country and currency documentation](https://developer.paypal.com/webapps/developer/docs/integration/direct/rest_api_payment_country_currency_support/) for a complete, up-to-date list.

Note that currency support differs for credit card versus PayPal payments. Unless you disable credit card acceptance (via the `PayPalPaymentViewController.hideCreditCardButton` property), **we recommend limiting transactions to currencies supported by both payment types.** Currently these are: USD, GBP, CAD, EUR, JPY.

If your app initiates a transaction with a currency that turns out to be unsupported for the user's selected payment type, then the SDK will display an error to the user and write a message to the console log.

Hints & Tips
------------

  - **Avoid fraud!** Be sure to [verify the proof of payment](https://developer.paypal.com/webapps/developer/docs/integration/mobile/verify-mobile-payment/).
  - Mobile networks are unreliable. Save the proof of payment to make sure it eventually reaches your server.
  - The header files are thoroughly documented; refer to them as needed for extra details about any given property or parameter.

Older Libraries
---------------

PayPal is in the process of replacing the older "Mobile Payments Libraries" (MPL) with the new PayPal Android and iOS SDKs. 
The new Mobile SDKs are based on the PayPal REST API, while the older MPL uses the Adaptive Payments API.

Until features such as third-party, parallel, and chained payments are available, you can use MPL:

 - [MPL on GitHub](https://github.com/paypal/sdk-packages/tree/gh-pages/MPL)
 - [MPL Documentation](https://developer.paypal.com/webapps/developer/docs/classic/mobile/gs_MPL/)

Issues related to MPL should be filed in the [sdk-packages repo](https://github.com/paypal/sdk-packages/).

Developers with existing Express Checkout integrations or who want additional features such as 
authorization and capture, may wish to use [Mobile Express Checkout](https://developer.paypal.com/webapps/developer/docs/classic/mobile/gs_MEC/)
 in a webview.
