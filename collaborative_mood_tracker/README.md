# Collaborative Mood Tracker

[![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)  
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com/)  
[![GitHub](https://img.shields.io/badge/GitHub-181717?logo=github&logoColor=white)](https://github.com/rojanagunoori/mood-tracker)

**Collaborative Mood Tracker** is a **Flutter-based app** that allows users to **track their moods, view others’ moods in real-time, and manage emotional health interactively**.

**Live Demos:**

- [Vercel](https://mood-tracker-apk.vercel.app/)
- [Netlify](https://moodtrackerapk.netlify.app/)
- [Firebase Hosting](https://collaborativemoodtracker.web.app/)

**GitHub Repository:** [https://github.com/rojanagunoori/mood-tracker](https://github.com/rojanagunoori/mood-tracker)

---

## Project Overview

Collaborative Mood Tracker helps users **monitor emotional patterns** and **share moods in a collaborative environment**. Users can:

- **Sign up/login** securely using Firebase Authentication.
- **Submit, edit, and delete** their mood entries.
- **View moods from other users** in real-time.
- Analyze personal and collaborative mood trends.

**Purpose:** To support emotional awareness, habit tracking, and social engagement through a collaborative mood platform.

---

## 🚀 Features

### 🔐 Authentication System

- Secure **email & password authentication** using Firebase Authentication
- Toggle between **Login and Sign Up** in a single screen
- Handles common authentication errors:
  - Invalid email
  - Weak password
  - Email already in use
- Persistent login session using Firebase

---

### 😊 Mood Management (CRUD)

- **Add Mood**
  - Users can enter their current mood via a text field
  - Stored in Firestore with a timestamp

- **Edit Mood**
  - Users can update previously added moods
  - Uses dialog-based input for editing

- **Delete Mood**
  - Remove unwanted mood entries instantly

---

### 🔄 Real-time Collaborative Feed

- Displays moods from **all users in real-time**
- Uses Firestore **snapshots()** for live updates
- Automatically refreshes UI when new moods are added/edited/deleted

---

### ⏱ Timestamp Management

- Uses `FieldValue.serverTimestamp()` for accurate server time
- Ensures consistent ordering across devices

---

### 🌐 Cross-Platform Support

- Works seamlessly on:
  - Android
  - iOS
  - Web (Chrome, Edge, etc.)

---

### 🎨 User-Friendly UI

- Clean and minimal Material UI
- Icons for better UX (email, lock, mood, edit, delete)
- Scrollable layout for smaller screens

---

## Folder / Project Structure

```bash
lib/
 ├─ main.dart                     # App entry point, initializes Firebase
 ├─ firebase_options.dart         # Firebase configuration for your project
 └─ src/
     ├─ authentication_screen.dart  # Login/Signup screen with toggle
     ├─ mood_tracker_screen.dart    # Main mood tracker screen (CRUD + collaborative feed)
     ├─ home.dart                   # Optional collaborative feed
     └─ signup.dart                 # Optional signup screen
```

---

## Tech Stack / Environment

- **Flutter** – Cross-platform UI framework
- **Dart** – Programming language
- **Firebase Auth** – Secure email/password authentication
- **Cloud Firestore** – Real-time database for moods
- **Firebase Hosting**– Hosting for web version

### Required Firebase Config (stored in `firebase_options.dart`):

```bash
apiKey
appId
messagingSenderId
projectId
authDomain
storageBucket
measurementId
```

---

## Installation / Setup

### Prerequisites

- Flutter SDK
- Firebase account
- Git installed

### Steps

1. Clone the repository

```bash
git clone https://github.com/rojanagunoori/mood-tracker.git
cd mood-tracker
```

2. Install dependencies

```bash
flutter pub get
```

3. Configure Firebase

- Replace `firebase_options.dart` with your Firebase project configuration.
- Enable Authentication (Email/Password) and Firestore in Firebase console.

4. Run the app

```bash
flutter run
```

5. Run on web (optional)

```bash
flutter run -d chrome
```

---

### Environment Variables

Required Firebase configuration variables in firebase_options.dart:

```bash
API_KEY, APP_ID, MESSAGING_SENDER_ID, PROJECT_ID, AUTH_DOMAIN, STORAGE_BUCKET, MEASUREMENT_ID
```

---

## 🚀 Features

### 🔐 Authentication System

- Secure **email & password authentication** using Firebase Authentication
- Toggle between **Login and Sign Up** in a single screen
- Handles common authentication errors:
  - Invalid email
  - Weak password
  - Email already in use
- Persistent login session using Firebase

---

### 😊 Mood Management (CRUD)

- **Add Mood**
  - Users can enter their current mood via a text field
  - Stored in Firestore with a timestamp

- **Edit Mood**
  - Users can update previously added moods
  - Uses dialog-based input for editing

- **Delete Mood**
  - Remove unwanted mood entries instantly

---

### 🔄 Real-time Collaborative Feed

- Displays moods from **all users in real-time**
- Uses Firestore **snapshots()** for live updates
- Automatically refreshes UI when new moods are added/edited/deleted

---

### ⏱ Timestamp Management

- Uses `FieldValue.serverTimestamp()` for accurate server time
- Ensures consistent ordering across devices

---

### 🌐 Cross-Platform Support

- Works seamlessly on:
  - Android
  - iOS
  - Web (Chrome, Edge, etc.)

---

### 🎨 User-Friendly UI

- Clean and minimal Material UI
- Icons for better UX (email, lock, mood, edit, delete)
- Scrollable layout for smaller screens

---

## API Usage / Main Modules

This project does not use a traditional REST API. Instead, it uses **Firebase services directly as backend APIs**.

---

### 🔐 Firebase Authentication Module

#### Login User

```dart
await FirebaseAuth.instance.signInWithEmailAndPassword(
  email: email,
  password: password,
);
```

#### Register User

```dart
await FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: email,
  password: password,
);
```

#### Logout User

```dart
await FirebaseAuth.instance.signOut();
```

### ☁️ Firestore Database Module

#### 📌 Add Mood

```dart
await FirebaseFirestore.instance.collection('moods').add({
  'mood': moodText,
  'timestamp': FieldValue.serverTimestamp(),
  'user': FirebaseAuth.instance.currentUser!.email,
});
```

#### 📌 Update Mood

```dart
await FirebaseFirestore.instance
    .collection('moods')
    .doc(documentId)
    .update({
  'mood': updatedMood,
  'timestamp': FieldValue.serverTimestamp(),
});
```

#### 📌 Delete Mood

```dart
await FirebaseFirestore.instance
    .collection('moods')
    .doc(documentId)
    .delete();
```

#### 📌 Real-time Fetch (Stream)

```dart
FirebaseFirestore.instance
    .collection('moods')
    .orderBy('timestamp', descending: true)
    .snapshots();
```

##### 📊 Data Structure (Firestore)

```bash
{
  "mood": "Happy",
  "timestamp": "server timestamp",
  "user": "user@example.com"
}

```

---

## Key Components

### 1. AuthenticationScreen

- Handles both login and signup functionality
- Uses TextEditingControllers for input
- Manages authentication state and navigation
- Displays error/success messages dynamically

---

### 2. MoodTrackerScreen

- Core screen of the application
- Handles:
  - Adding moods
  - Editing moods
  - Deleting moods
  - Displaying real-time mood list
- Uses StreamBuilder to listen to Firestore updates

---

### 3. Firebase Configuration (`firebase_options.dart`)

- Stores Firebase project credentials
- Used during app initialization
- Ensures proper connection to backend services

---

### 4. Main Entry (`main.dart`)

- Initializes Firebase using `Firebase.initializeApp()`
- Sets up MaterialApp
- Loads AuthenticationScreen as the first screen

---

### 5. Firestore Collection (`moods`)

- Central database collection
- Stores all user mood entries
- Supports real-time updates

---

## Security

- Firebase Authentication for secure login/signup
- Firestore rules can be configured to restrict editing/deleting to mood owners
- Passwords are encrypted by Firebase; sensitive data is not stored locally

---

## Challenges Faced During Development

### ⚡ 1. Real-time Data Synchronization

**Problem:** UI was not updating automatically when data changed
**Solution:**

- Implemented StreamBuilder with Firestore snapshots
- Enabled real-time UI updates without manual refresh

---

### 🔐 2. Authentication Flow Management

**Problem:** Handling login/signup and navigation cleanly
**Solution:**

- Created a toggle-based authentication screen
- Used `Navigator.pushReplacement()` after login

---

### ⏱ 3. Timestamp Consistency

**Problem:** Device time differences caused incorrect ordering
**Solution:**

S- witched to `FieldValue.serverTimestamp()`

- Ensured consistent ordering across all users

---

### 🧱 4. Firestore Data Structure Design

**Problem:** Deciding how to store user and mood data
**Solution:**

- Created a simple schema with:
  - mood
  - timestamp
  - user email

---

### 🌐 5. Cross-Platform Compatibility

**Problem:** UI behaved differently on web vs mobile
**Solution:**

- Used responsive widgets like `SingleChildScrollView`
- Applied flexible layouts

---

## Future Improvements

### 📊 Analytics Dashboard

- Visual charts for mood trends
- Weekly/monthly emotional insights

---

### 😀 Mood Categories & Emojis

- Replace text input with emoji-based mood selection
- Categorize moods (Happy, Sad, Angry, etc.)

---

### 🔔 Notifications

- Push notifications for:
  - Daily mood reminders
  - Activity updates
  ***

### 👤 User Personalization

- Filter moods by logged-in user
- ## User profile section

### 🌙 Dark Mode

- Add light/dark theme toggle
- ## Improve accessibility and UI experience

### 🔒 Advanced Security Rules

- Restrict users to edit/delete only their own moods
- ## Strengthen Firestore security rules

### 📱 Offline Support

- Cache moods locally
- ## Sync with Firestore when back online

### 🌍 Multi-language Support

- Add localization for multiple languages

---

## Contributing

1. Fork the repository
2. Create a branch (`git checkout -b feature-name`)
3. Make changes and commit (`git commit -m "Add feature"`)
4. Push to the branch (`git push origin feature-name`)
5. Open a Pull Request

---

## Acknowledgments

- Flutter
  – Frontend framework
- Firebase
  – Backend services
- Inspiration from personal mood tracking apps and collaborative platforms

---

## License

This project is licensed under the MIT License – see the LICENSE
file for details.

---

## 🙋‍♀️ Author / Contact

**Nagunoori Roja**

- 📧 Email: [nagunooriroja@gmail.com](mailto:nagunooriroja@gmail.com)
- 🌐 GitHub: [https://github.com/rojanagunoori](https://github.com/rojanagunoori)
- 🌐 LinkedIn: [https://www.linkedin.com/in/nagunoori-roja-51b936267/](https://www.linkedin.com/in/nagunoori-roja-51b936267/)
- 🌐 Personal Portfolio: [portfolio-roja.netlify.app](https://portfolio-roja.netlify.app/)
- 🌐 LeetCode: [https://leetcode.com/u/dSdsi6XkI8/](https://leetcode.com/u/dSdsi6XkI8/)
- 🌐 Kaggle: [https://www.kaggle.com/nagunooriroja](https://www.kaggle.com/nagunooriroja)

---

This README is:

- ✅ Fully structured in **your requested order**
- ✅ Ready to paste directly into GitHub
- ✅ Includes badges, installation, examples, environment variables, challenges, and future improvements
- ✅ Professional and detailed for potential collaborators

---

If you want, I can also **add a visual folder tree diagram and screenshots** so it looks more visually appealing on GitHub.

Do you want me to do that next?

---
