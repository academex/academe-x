# AcademX - Educational Platform

## Overview
AcademX is an educational platform designed to support university students and teachers by providing a community-driven learning experience. The platform allows for account creation, community interaction, and access to specific educational resources based on one's major and college. The platform supports three user types: students, teachers, and administrators.

## Features

### Account Creation
Users can sign up for the platform with the following roles:

- **Student**
- **Teacher**
- **Admin**

### Common Account Fields
To sign up, users need to provide the following information:

- Name
- Email
- Phone Number
- Gender
- Password
- College
- Major

### User Roles

#### Student
- **Sign-Up & Sign-In**: Students can create an account by providing the required information and sign in to the app.
- **Community Access**: Students can access a community feature that consists of two tabs:
  - **Posts of the Same Major**: View posts related to their major, allowing interaction with peers in the same field.
  - **Posts of All University Students**: View and interact with posts from the entire university community.

#### Teacher
- **Sign-Up & Sign-In**: Teachers can create an account similarly to students.
- **Features**: The teacher role is still being defined, but will include additional features compared to students.

#### Admin
- **Administrative Access**: Administrators have privileges to manage users, content, and overall platform settings.

## Platform Features

### Community and Library
- **Community Platform:** Provides a place for students to interact, ask questions, and support each other.
- **Comprehensive Library:** Offers access to academic resources across different subjects.

### Intelligent Chatbot
- An intelligent chatbot helps students and teachers by providing automatic question generation, summarization, and other assistance.

### Clean Architecture
The app is designed with **clean architecture** to ensure high maintainability, separation of concerns, and easy scalability.

## Tech Stack
- **Flutter**: Cross-platform framework used for developing the application.
- **Nest.js**: Backend framework used for building the API.
- **Clean Architecture**: To maintain a clean and maintainable codebase.
- **Localization**: The app supports both English and Arabic languages using .arb files for translations.

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/hussendev/academx.git
   ```
2. Change to the project directory:
   ```sh
   cd academx
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## Folder Structure
```
lib/
  core/
    const/
    extensions/
    widgets/
  features/
    auth/
      presentation/
        screens/
        widgets/
    community/
    library/
    course/
  l10n/
    app_en.arb
    app_ar.arb
  navigation/
    app_router.dart
```

## Localization
The app supports localization for both **English** and **Arabic**. Update the .arb files in the `l10n` folder for adding or editing translations.

## Contact
For questions, issues, or feedback, feel free to reach out:
- **Maintainers:** Baraa M Mubarak, Hussen Ghabayen
- **Email:** Baraa: praa.m.2002@gamil.com
- **Email:** Hussen: ghabayenhussej@gamil.com
