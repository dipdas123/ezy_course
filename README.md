# EzyCourse - Community Feed Application

EzyCourse is a Flutter-based community feed application designed to dynamically fetch and display posts. The app includes user authentication, post creation, reactions, comments, replies, and real-time updates. It also supports offline mode, allowing users to view previously loaded content without an internet connection.

## Features
- **User Authentication:** Login and logout functionality with session management.
- **Dynamic Feed:** Fetch and display posts dynamically from API.
- **Create Posts:** Users can create text posts.
- **Reactions:** Users can react to posts with options like 'like', 'love', etc.
- **Comments and Replies:** Users can comment on posts and reply to comments.
- **Offline Mode:** Local data storage using sqflite to view content offline.
- **Real-time Updates:** Immediate feed updates upon new post creation or reacions and increase or decrease counts.
- **Audio Feedback:** Sound effects for reactions.
- **Internet Status:** Real-time internet connection status updates.

## Architectural Pattern
EzyCourse is built using **Clean Architecture** and **Riverpod** for state management. The architecture ensures a clear separation of concerns, with distinct layers for UI, application logic, and data.

### Layers
- **Presentation Layer:** Contains the UI components and interacts with the ViewModel.
- **Infrastructure Layer:** Handles data retrieval from the API and local storage.
- **Core Layer:** Defines the core business logic and entities.
  
## Technologies Used
- **Riverpod:** For state management.
- **Dio:** For network requests and API interactions.
- **SQFLite:** For local data storage and offline mode.
- **SharedPreferences:** For storing tokens and small data.
- **GetX:** For navigation.
- **Audio Players:** For playing sound effects on reactions.

## How to Run the App

### Prerequisites
- Flutter SDK installed
- Dart SDK installed
- Android Studio or VS Code with Flutter plugin

### Steps
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/dipdas123/ezy_course.git
   ```
2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the App:**
   ```bash
   flutter run
   ```
4. **Build the App:**
   
   **For Android:**
   ```bash
   flutter build apk
   ```
   
   **For iOS:**
   ```bash
   flutter build ios
   ```

## Configuration
- **API Base URL:** Update the base URL if needed in `lib/infrastructure/remote/api_endpoints.dart`.
## Folder Structure
```
lib/
├── core/
│   ├── config.dart
│   ├── constants.dart
│   ├── utils/
├── data/
│   ├── datasources/
│   ├── models/
│   ├── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   ├── usecases/
├── presentation/
│   ├── pages/
│   ├── widgets/
│   ├── viewmodels/
├── main.dart
```

## Contributing
Contributions are welcome! Please fork the repository and create a pull request with your changes.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments
- **Flutter Community**
- **Riverpod for state management**
- **Dio for network requests**
- **SQLite for local storage**

Enjoy building and using **EzyCourse**! For any issues or feature requests, please open an issue on the GitHub repository.

