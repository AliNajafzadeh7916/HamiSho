# HamiSho

**HamiSho** is a mobile application project developed using the Flutter framework and is responsible for displaying news and announcements from representatives. This application allows users to support representatives and send their messages. The system is connected to a backend developed with Django, which manages news, announcements, and representative information.

The project does not employ a complex or special architecture and has been developed as a small and introductory project. The primary goal of this project is to create a simple and functional example that is easy to understand and use. However, the project is designed to be readable and compact, with potential for future development and improvement. Although its structure is currently simple, it still has the potential to become a more complex and scalable project in the future.

## Related Project

This mobile application is connected and synchronized with a backend system developed using the Django framework. The backend provides the mobile application with necessary data and information. For more information about the backend project, please visit the [HamiSho Backend Project](https://github.com/Bestsenator/HamiSho).

## Features

- **Display news and announcements from representatives:** Shows new news and announcements related to representatives.
- **Support for representatives:** Allows users to support representatives and send messages to them.
- **Retrieve representative information:** Retrieves representative information from the backend based on the representative code.

## Prerequisites

To run this project, you need to install the following software and tools:

- [Flutter](https://flutter.dev/docs/get-started/install) version 3.0 or higher
- [Dart](https://dart.dev/get-dart) version 3.3 or higher
- [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/) for development

## Project Dependencies

The following packages are used in this project and are defined in the pubspec.yaml file:

## Installation and Setup

To set up the project, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/AliNajafzadeh7916/HamiSho.git
   ```

2. **Navigate to the project directory:**

   ```bash
   cd HamiSho/candidate
   ```

3. **Install dependencies:**

   ```bash
   flutter pub get
   ```

4. **Configure the project settings:**

   **Configure representative and application information:**

   Edit the file static_data.dart located at HamiSho/candidate/lib/Data/static_data.dart and set the following values:

   - Application version
   - Representative code
   - Representative name
   - API Key
   - Server address
   - Representative image

   **Configure the application name:**

   Set the application name in the AndroidManifest.xml file located at HamiSho/candidate/android/app/src/main/AndroidManifest.xml.

   **Configure the application ID:**

   Set the application ID in the build.gradle file located at HamiSho/candidate/android/app/build.gradle.

5. **Run the application:**
   ```bash
   flutter run
   ```

The application should now be available on the emulator or connected device.

## API Endpoints

To interact with the backend, the application uses the following endpoints:

- GET ${headUrl}getCandidateInfo/ - Retrieve candidate information
- GET ${headUrl}getPostCandidate/ - Retrieve candidate posts
- GET ${headUrl}getNewsCandidate/ - Retrieve candidate news
- POST ${headUrl}setSupporter/ - Register supporter for the candidate
- POST ${headUrl}setMessageToCandidate/ - Send message to the candidate

## Contributing

If you would like to contribute to this project, you can:

1. Fork this repository.
2. Create a new branch for the feature or bug fix (git checkout -b feature/AmazingFeature).
3. Commit your changes (git commit -m 'Add some AmazingFeature').
4. Push your branch (git push origin feature/AmazingFeature).
5. Open a Pull Request.

## Special Thanks

[**Bestsenator**](https://github.com/Bestsenator)
Special thanks to the backend developer who developed and connected this backend system to the mobile application with their effort and skill. Without their hard work, creating this integrated system would not have been possible.
