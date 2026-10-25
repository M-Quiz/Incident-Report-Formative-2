# Campus Care

Campus Care is a Flutter Android app for university communities to discover,
report, and follow campus facilities issues.

## Features

- University-email sign-in screen with form validation and password visibility
- Searchable campus incident feed with active/resolved filters and issue details
- Four-step issue report flow: category, location, details, and review
- My Reports, profile preferences, active-session information, and sign-out
- Responsive Material 3 interface with sample campus reports

## Run the app

Install Flutter stable (3.27 or later), Android Studio with the Android SDK, and
a Java 17 JDK. Generate any missing Android runner or Gradle wrapper files, then
from the project root run:

```sh
flutter pub get
flutter run
```

Select an Android emulator or connected device when prompted. To build an
Android APK, run `flutter build apk`.

## Authentication and data

This starter includes a **local demo sign-in**, in-memory sample reports, and
in-memory session state. It does not authenticate credentials, persist reports,
or communicate with a university system. Connect the sign-in screen to your
university's approved OIDC/SAML identity provider and enforce authorization in
a trusted backend before using this app with real accounts or campus data. Do
not treat client-side validation as authentication or authorization.

## Android project setup

The Android app module and Flutter Gradle plugin configuration are under
`android/`. Flutter normally generates the Gradle wrapper files when it creates
an Android project. This checkout does not include the generated wrapper
scripts; if they are missing, run `flutter create --platforms=android .` with
Flutter installed to generate the Android runner and wrapper. Preserve the
`edu.campuscare.app` application ID when scaffolding.
