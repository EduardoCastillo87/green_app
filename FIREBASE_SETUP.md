# Firebase Setup Guide for GreenApp

This guide will help you set up Firebase for your GreenApp Flutter project.

## Prerequisites

1. **Flutter SDK** installed on your machine
2. **Firebase CLI** installed globally
3. **Google account** with access to Firebase Console

## Step 1: Install Firebase CLI

```bash
npm install -g firebase-tools
```

## Step 2: Login to Firebase

```bash
firebase login
```

## Step 3: Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter a project name (e.g., "greenapp-xxxxx")
4. Choose whether to enable Google Analytics (recommended)
5. Click "Create project"

## Step 4: Enable Authentication

1. In Firebase Console, go to "Authentication" in the left sidebar
2. Click "Get started"
3. Go to "Sign-in method" tab
4. Enable "Email/Password" provider
5. Click "Save"

## Step 5: Create Firestore Database

1. In Firebase Console, go to "Firestore Database" in the left sidebar
2. Click "Create database"
3. Choose "Start in test mode" for development
4. Select a location for your database
5. Click "Done"

## Step 6: Set Up Security Rules

In Firestore Database > Rules, replace the default rules with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read and write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Add more collection rules as needed
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## Step 7: Install FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
```

## Step 8: Configure Flutter App

1. Navigate to your Flutter project directory
2. Run the following command:

```bash
flutterfire configure --project=your-firebase-project-id
```

This will:
- Create the necessary Firebase configuration files
- Update `lib/firebase_options.dart` with your actual Firebase credentials
- Add platform-specific configuration files

## Step 9: Update Firebase Options

After running `flutterfire configure`, the `lib/firebase_options.dart` file will be automatically updated with your actual Firebase credentials.

## Step 10: Install Dependencies

```bash
flutter pub get
```

## Step 11: Test the Setup

1. Run your Flutter app:
```bash
flutter run
```

2. Try to register a new user
3. Try to login with the registered user
4. Check Firebase Console to see if users are being created

## Firebase Features Implemented

### Authentication
- ✅ Email/Password sign up
- ✅ Email/Password sign in
- ✅ Password reset
- ✅ Sign out
- ✅ User session management

### Firestore Database
- ✅ User profile creation
- ✅ User data storage
- ✅ Last login tracking
- ✅ User preferences (ready for future use)

## Database Structure

```
users/
├── {userId}/
│   ├── fullName: string
│   ├── email: string
│   ├── createdAt: timestamp
│   ├── lastLogin: timestamp
│   ├── preferences: map (future use)
│   └── updatedAt: timestamp
```

## Troubleshooting

### Common Issues

1. **Firebase initialization fails**
   - Check if `firebase_options.dart` has correct credentials
   - Ensure Firebase project is properly set up

2. **Authentication errors**
   - Verify Email/Password provider is enabled in Firebase Console
   - Check Firestore security rules

3. **Platform-specific issues**
   - For Android: Ensure `google-services.json` is in `android/app/`
   - For iOS: Ensure `GoogleService-Info.plist` is in `ios/Runner/`

### Error Messages

- **"No user found"**: User doesn't exist, try registering first
- **"Wrong password"**: Incorrect password entered
- **"Email already in use"**: User already registered with this email
- **"Weak password"**: Password is less than 6 characters

## Next Steps

1. **Add more authentication methods** (Google, Facebook, etc.)
2. **Implement user profile management**
3. **Add data validation and sanitization**
4. **Implement offline support**
5. **Add push notifications**

## Security Considerations

1. **Never commit sensitive Firebase credentials** to version control
2. **Use environment variables** for production deployments
3. **Regularly review Firestore security rules**
4. **Enable Firebase App Check** for additional security
5. **Monitor Firebase usage** in the console

## Support

If you encounter issues:
1. Check Firebase Console for error logs
2. Review Flutter Firebase documentation
3. Check Firebase status page for service issues
4. Consult Flutter Firebase GitHub issues 