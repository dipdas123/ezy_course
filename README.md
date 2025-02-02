# EzyCourse - Community Feed Application

EzyCourse is a Flutter-based community feed application designed to dynamically fetch and display posts from an API. The app includes user authentication, post creation, reactions, comments, replies, and real-time updates. It also supports offline mode, allowing users to view previously loaded content without an internet connection.

## Features
- **Authentication**: Login and logout functionality with session management.
- **Dynamic Feed**: Fetch and display posts including user details, images, and reactions.
- **Create Post**: Users can create and submit new posts, with or without backgrounds.
- **Reactions**: Support for liking and reacting to posts dynamically.
- **Comments & Replies**: Users can comment and reply in a nested format.
- **Offline Mode**: Uses local storage to keep content accessible offline.
- **Audio Reactions**: Adds sound effects for user interactions.
- **Internet Status Monitoring**: Detects and informs users about connectivity status.

## Architecture
EzyCourse is built using **Clean Architecture** to ensure a modular, scalable, and maintainable structure. It consists of:
1. **Presentation Layer**: UI components (screens, widgets) interacting with business logic through ViewModels
