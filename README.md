# PawPal Signup 🐾

## MAD 4360 — Activity 10: Flutter Signup Form Quest

## 1. Project Information

- **Course:** MAD 4360
- **Activity:** 10 — Flutter Signup Form Quest
- **Track:** Graduate
- **Project Name:** PawPal Signup
- **Project Type:** Individual Project
- **Developer:** Sai Anuradha Kappaganthula
- **Tasks Implemented:** Task A — Local Signup Coach; Task C — Confirm & Celebrate
- **Framework:** Flutter
- **Language:** Dart
- **Target Platform:** Android

## 2. Project Overview

PawPal Signup is a Flutter application that provides a signup form with input validation and a local Signup Coach feature. Users can enter their full name, email address, password, and confirm their password before submitting the form. The application validates the inputs and displays a personalized welcome message when all fields are valid.

The Signup Coach provides preset signup tips stored locally in the application. It displays a brief loading state, shows a preset tip, and handles cases where tip data is empty or unavailable. The feature runs entirely on-device and does not make network requests or send personal form information to an external AI service.

## 3. Features Implemented

### 3.1 Core Signup Form

- Full name, email address, password, and confirm-password fields.
- Validation for empty fields and whitespace-only names.
- Email format validation.
- Minimum password length of six characters.
- Password confirmation must match the original password.
- Personalized welcome message after successful validation.
- Password fields hide entered characters.
- Scrollable layout and Material Design styling.

### 3.2 Task A — Local Signup Coach

- Provides preset tips stored locally in the application.
- Uses a fixed category: `password_help`.
- Simulates processing with a brief loading indicator.
- Displays a plain-text tip of no more than 240 characters.
- Displays an error message when the local tip list is empty.
- Provides a Retry button for the error state.
- Does not use form values to select tips.
- Clearly identifies displayed tips as preset content, not live AI output.
- Does not make API calls or network requests.

### 3.3 Task C — Confirm & Celebrate

- Includes a confirm-password field.
- Rejects signup when the confirmation field is empty.
- Rejects signup when the passwords do not match.
- Allows signup to proceed when all form fields are valid.
- Displays a personalized success message using the entered name.

## 4. Implementation Details

### Form Architecture

The application uses a `StatefulWidget` because it manages changing form input, loading indicators, tip results, and error messages. A `GlobalKey<FormState>` coordinates validation across all form fields. The Sign Up button calls the form's validation method before displaying success feedback.

### Input Validation

Each form field has a validator that checks its input and returns a meaningful error message when validation fails. The email validator checks the basic email format, the password validator requires at least six characters, and the confirm-password validator compares the entered values.

### Local Signup Coach

The Signup Coach uses a list of preset strings stored in the application. A short asynchronous delay simulates processing without contacting an external service. The app uses state variables to control loading, successful tip display, and error feedback. If the tip list is empty, the application displays an error and allows the user to retry.

### Controller Lifecycle

Text editing controllers manage the form inputs. Their resources are released in the widget's `dispose()` method when the widget is removed.

## 5. Privacy and Responsible AI

The Signup Coach does not access the user's name, email address, password, or confirm-password controller when selecting a tip. It selects preset content from a fixed category and makes no network requests. This keeps personal form information separate from the tip feature.

The tips are clearly labeled as preset content rather than live AI output. They do not determine whether signup is valid and cannot override the form validators. Form validation remains entirely within the application.

## 6. Testing and Results

The following table records the manual test cases for the application.

| Test ID | Test Case | Expected Result | Result |
|---|---|---|---|
| TC01 | Submit an empty form | Required-field errors appear | Pass |
| TC02 | Enter an invalid email without a valid domain | Email validation error appears | Pass |
| TC03 | Enter a password shorter than six characters | Password validation error appears | Pass |
| TC04 | Enter different password and confirmation values | Signup is blocked with a mismatch error | Pass |
| TC05 | Enter a whitespace-only name | Name validation error appears | Pass |
| TC06 | Submit valid details with matching passwords | Personalized welcome message appears | Pass |
| TC07 | Enter a malformed email such as `anu@` | Email validation error appears | Pass |
| TC08 | Enter a six-character password with matching confirmation | Password-length validation passes | Pass |
| TC09 | Request a signup tip | Loading indicator appears briefly | Pass |
| TC10 | Wait for the local tip | Preset tip appears with the required label | Pass |
| TC11 | Tap the tip button repeatedly | App remains responsive and button is disabled while loading | Pass |
| TC12 | Change form values and request a tip | Tip selection remains independent of form information | Pass |
| TC13 | Temporarily empty the local tips list | Error message and Retry button appear | Pass |
| TC14 | Retry while the tips list remains empty | Error is displayed again without a crash | Pass |
| TC15 | Restore the preset tips and request a tip | A preset tip appears successfully | Pass |
| TC16 | Enter matching passwords | Confirmation validation passes | Pass |
| TC17 | Enter mismatched passwords | Signup is blocked | Pass |
| TC18 | Enter a name with surrounding spaces and valid remaining inputs | Success message uses the trimmed name | Pass |
| TC19 | Leave the confirm-password field empty | Confirmation-required error appears | Pass |
| TC20 | Correct a mismatched confirmation and resubmit | Personalized success message appears | Pass |

### Testing Notes

The empty-tip test is performed by temporarily replacing the preset tips list with an empty list. After verifying the error and retry behavior, the original tips are restored and the successful tip request is tested again.

The privacy-boundary test verifies that the tip-selection method uses the local preset list without reading the form controllers. Tip selection remains independent of the name, email, password, and confirmation values.

## 7. Graduate Concept Questions

### Question 1: Identify one privacy boundary in the local tip feature. What information does it keep out of the feature, and why?

The Signup Coach does not access the user's name, email address, password, or confirm-password field when selecting a tip. It uses preset tips stored locally in the app and selects a tip from a fixed category, `password_help`. This prevents personal information from being unnecessarily exposed to the tip feature. Since the feature uses no external API or network requests, the form information is not sent to an external AI service.

### Question 2: How would you evaluate whether the preset tips are useful, safe, and consistent? Name a small test set and at least one failure metric.

I would test the preset tips using a small set of cases, including a successful tip request, an empty tip list, repeated requests, and requests made with different form inputs. I would verify that every displayed tip is relevant to signup, contains no inappropriate content, and is no longer than 240 characters. I would also check that the app remains responsive during loading and error handling. One failure metric would be the percentage of test cases in which the app crashes, displays an invalid tip, or fails to show the expected error message.

### Question 3: What should the UI do when local tip data is empty or missing? Explain your error and retry behavior.

When the local tip list is empty, the UI should display a clear error message instead of trying to display a nonexistent tip. The Retry button should allow the user to request a tip again without restarting the app. In my implementation, the app checks whether the preset tip list is empty before selecting a tip, avoiding invalid list access. If the list remains empty, the error should appear again; if valid tip data is restored, the app should display a tip successfully.

## 8. Design Trade-Off and Proposed Improvement

One trade-off is that preset tips improve privacy and reliability by eliminating network dependency, but they provide limited variety and personalization. Because the tips are fixed, the application cannot dynamically adapt them to individual users. A practical improvement would be to evaluate the tips using a broader set of test cases and user feedback, while continuing to keep personal form information separate from the tip feature.

## 9. Individual Contribution

I completed this project individually. I implemented the signup form, field validation, password confirmation, and personalized success message. I also implemented the local Signup Coach, including preset tips, a simulated loading state, and error handling with a retry option. I tested the form's validation behavior, local tip success and failure states, and the separation between form information and tip selection.

## 10. Limitations

- The Signup Coach uses fixed, locally stored tips rather than a live AI service.
- The app simulates signup validation but does not create an account.
- No credentials are stored or transmitted.
- Email validation checks basic formatting and does not verify that an email address exists.
- Password validation checks the minimum length and matching confirmation but does not guarantee password security.
- The application does not include a backend authentication system.

## 11. How to Run the Application

### Prerequisites

- Flutter SDK installed and configured.
- Visual Studio Code or another Flutter-compatible IDE.
- Android emulator or Android device.
- Git installed if cloning the repository.

### Run the App

From the project root directory, run:

```bash
flutter pub get
flutter run
```

### Analyze the Code

```bash
flutter analyze
```

### Build the Release APK

```bash
flutter build apk --release
```

The generated APK is located at:

`build/app/outputs/flutter-apk/app-release.apk`

If a release build is blocked by signing or configuration issues, a debug APK can be built using:

```bash
flutter build apk --debug
```

The debug APK is located at:

`build/app/outputs/flutter-apk/app-debug.apk`

## 12. Conclusion

PawPal Signup demonstrates Flutter form construction, input validation, state management, local preset-tip handling, privacy-aware design, and error recovery. The implementation combines the core signup form with Task A and Task C to satisfy the graduate-track feature requirements. The project also demonstrates the importance of separating user input validation from optional guidance features.