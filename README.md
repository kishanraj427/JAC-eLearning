# JAC-eLearning

A comprehensive mobile learning platform built with Flutter for **Jharkhand Academic Council (JAC)** board students. The app provides access to news & notifications, study materials (books), and previous year question papers — all powered by Firebase.

## Features

- **News & Notifications** — Real-time updates, announcements, and results via Firebase Realtime Database and FCM push notifications.
- **Books Module** — Browse study materials organized by class (9th–12th), stream (Science/Commerce/Arts), and subject. View chapters and solutions as PDFs.
- **Question Bank** — Access previous year question papers filtered by subject and year with an in-app PDF viewer.
- **In-App PDF Viewer** — Powered by Syncfusion for smooth reading, sharing, and downloading.
- **Recent History** — Tracks recently accessed books and question papers locally.
- **Push Notifications** — Firebase Cloud Messaging with custom notification channels.
- **In-App Updates** — Checks Firebase for the latest version and prompts users to update.

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.41.0 / Dart 3.4.1+ |
| State Management | GetX |
| Backend | Firebase Realtime Database |
| Authentication | Firebase Auth |
| Notifications | Firebase Cloud Messaging + Flutter Local Notifications |
| PDF Viewer | Syncfusion Flutter PDF Viewer |
| Animations | Lottie |
| UI | Material Design, Google Fonts, Bottom Navy Bar |

## Project Structure

```
lib/
├── main.dart                 # App entry point, Firebase init, FCM setup
├── MyHomePage.dart            # Main navigation shell with bottom tabs
├── AppColor.dart              # Centralized color constants
├── models/                    # Data models
│   ├── Book.dart
│   ├── News.dart
│   └── Subject.dart
├── controller/                # GetX controllers (business logic)
│   ├── ClassController.dart
│   ├── QuestionController.dart
│   ├── NewsController.dart
│   ├── SubjectController.dart
│   ├── PDFController.dart
│   ├── QPDFController.dart
│   └── QSubjectController.dart
├── screens/                   # UI screens
│   ├── HomeScreen/
│   ├── BookScreen/
│   └── QuestionScreen/
└── widgets/                   # Reusable UI components
    ├── Header.dart
    ├── ClassesWidget.dart
    ├── SubjectWidget.dart
    ├── BookWidget.dart
    └── ...
```

## Architecture

The app follows an **MVC-like pattern** using GetX for state management and dependency injection.

See the full architecture and data flow diagrams in the [docs/](docs/) folder:

- [Architecture Diagram](docs/architecture.md)
- [Data Flow Diagram](docs/data-flow.md)

## Getting Started

### Prerequisites

- Flutter 3.41.0+ (managed via [FVM](https://fvm.app/))
- Android Studio / VS Code
- Firebase project configured with `google-services.json`

### Setup

```bash
# Clone the repository
git clone https://github.com/kishanraj427/JAC-eLearning.git
cd JAC-eLearning

# Install Flutter version (if using FVM)
fvm install

# Get dependencies
flutter pub get

# Run the app
flutter run
```

### Build APK

```bash
flutter build apk --split-per-abi
```

## CI/CD

GitHub Actions workflow builds the APK on push/PR to main and publishes releases automatically. See [.github/workflows/main.yml](.github/workflows/main.yml).

## License

This project is proprietary. All rights reserved.
