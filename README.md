# Offline Note App

A simple note-taking app built with Flutter that supports offline functionality using Hive for local storage and provides a sync feature to a remote database when online.

## Features

*   Create, read, update, and delete notes.
*   Offline storage using Hive.
*   Automatic synchronization with a remote database when internet is available.

## Getting Started

1.  Clone the repository:

    
    git clone <repository_url>
    

2.  Install dependencies:

    
    flutter pub get
    

3.  Generate Hive adapters:

    
    flutter pub run build_runner build
    

4.  Run the app:

    
    flutter run
    

## Folder Structure


lib/
├── main.dart
├── models/
│   └── note.dart
├── screens/
│   ├── home_screen.dart
│   └── note_screen.dart
├── services/
│   ├── hive_service.dart
│   └── api_service.dart


## Dependencies

*   Flutter SDK
*   Hive
*   Provider
*   http
*   path_provider