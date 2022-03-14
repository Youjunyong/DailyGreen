# Appstore Reject issue



### Guideline 2.1 - Performance - App Completeness

## 애플 카카오 로그인



We discovered one or more bugs in your app. Specifically, we were unable to log in using Kakao or Sign In with Apple. Please review the details below and complete the next steps.

Review device details:

\- Device type: iPad
\- OS version: iOS 15.1

Next Steps

Please run your app on a device to reproduce the issues, then revise and submit your app for review. If at first you're unable to reproduce the issue, try the following:

\- For new apps, uninstall all previous versions of your app from a device, then install and follow the steps to reproduce.
\- For app updates, install the new version as an update to the previous version, then follow the steps to reproduce.

If we misunderstood the intended behavior of your app, please reply to this message in Resolution Center to provide information on how these features were intended to work.

**Resources**

\- For information about testing apps and preparing them for review, see [Technical Note TN2431: App Testing Guide](https://developer.apple.com/library/archive/technotes/tn2431/_index.html).
\- To learn about troubleshooting networking issues, see [About Networking](https://developer.apple.com/library/archive/documentation/NetworkingInternetWeb/Conceptual/NetworkingOverview/Introduction/Introduction.html).





### Guideline 2.1 - Information Needed

### 아이디 비밀번호 외에 코드가 필요

We have started the review of your app, but in addition to the demo account username and password you provided, we need an authentication code to complete the registration process.

**Next Steps**

In order for us to proceed with the review of your app, you will need to provide an authentication code. Please respond to this message with the code.

If you are unable to provide a code by reply, we will arrange for an Apple representative to call you to obtain the code. Please respond to this message to confirm you require a call for us to obtain the code to access your app.

To ensure we have accurate contact information, please verify the phone number listed in the App Review Information section of this app's Version Information page in [App Store Connect](https://appstoreconnect.apple.com/) is up-to-date.

You may also include a demonstration mode that exhibits your app’s full features and functionality. We do not accept demo videos to show your app in use for this issue.







### Guideline 2.1 - Information Needed

## 회원가입시 휴대폰 번호가 왜 필요한가요?

We’re looking forward to completing the review of your app, but we need more information to continue.

**Next Steps**

Please provide detailed answers to the following questions in your reply to this message in Resolution Center:

\- Why is mobile number required for registration?







### Guideline 4.0 - Design



We noticed that several screens of your app were crowded or laid out in a way that made it difficult to use your app.

**Next Steps**

To resolve this issue, please revise your app to ensure that the content and controls on the screen are easy to read and interact with.

**Resources**

For more information, please review the following resources on the iOS Developer Center page:

\- [UI Do's and Don'ts](https://developer.apple.com/design/tips/)

\- [iOS Human Interface Guidelines](https://developer.apple.com/ios/human-interface-guidelines/)

\- [UIKit](https://developer.apple.com/documentation/uikit#//apple_ref/doc/uid/TP40012857)



### Guideline 5.1.1 - Legal - Privacy - Data Collection and Storage



We noticed that your app requests the user’s consent to access the photos, but doesn’t sufficiently explain the use of the photos in the purpose string.

To help users make informed decisions about how their data is used, permission request alerts need to explain **and** include an example of how your app will use the requested information.

**Next Steps**

Please revise the purpose string in your app’s Info.plist file for the photos to explain why your app needs access and include an example of how the user's data will be used.

You can modify your app's Info.plist file using the property list editor in Xcode.

**Resources**

\- See examples of [helpful, informative purpose strings](https://developer.apple.com/ios/human-interface-guidelines/app-architecture/requesting-permission/).
\- Review a list of [relevant property list keys](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW18).

Please see attached screenshots for details.

```c
Resolved issues with previous submission rejections

1. Guideline 2.1 - Performance - App Completeness 
social login problem (apple Login, kakao Login)
 The problem seems to have occurred because the country is different, and things that are expected to be bugs have been fixed. I tested it on a total of 5 devices and found that they all worked well. please check attached video below. Since this app will be distributed only in Korea, it is expected that there will be no problems at all.

2. Guideline 2.1 - Information Needed
The code was used to verify user's mobile phone number.  However, all cell phone number verification functions have been deleted.

3. Guideline 2.1 - Information Needed
All functions related to mobile phone numbers have been deleted.

4. Guideline 4.0 - Design
The UI layout was revised again.

5. Guideline 5.1.1 - Legal - Privacy - Data Collection and Storage
 We also updated additional information about the usages of  photos in the purpose string. It has been revised to be more detailed and clear.


```


