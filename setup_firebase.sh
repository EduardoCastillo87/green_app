#!/bin/bash

echo "🔥 GreenApp Firebase Setup Script"
echo "=================================="
echo ""

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    echo "❌ Firebase CLI is not installed."
    echo "Please install it first:"
    echo "npm install -g firebase-tools"
    echo ""
    exit 1
fi

# Check if FlutterFire CLI is installed
if ! command -v flutterfire &> /dev/null; then
    echo "❌ FlutterFire CLI is not installed."
    echo "Installing FlutterFire CLI..."
    dart pub global activate flutterfire_cli
    echo ""
fi

echo "✅ Firebase CLI and FlutterFire CLI are installed."
echo ""

# Check if user is logged in to Firebase
if ! firebase projects:list &> /dev/null; then
    echo "❌ You are not logged in to Firebase."
    echo "Please login first:"
    echo "firebase login"
    echo ""
    exit 1
fi

echo "✅ You are logged in to Firebase."
echo ""

# List existing projects
echo "📋 Your Firebase projects:"
firebase projects:list
echo ""

# Ask for project ID
read -p "Enter your Firebase project ID (or 'new' to create one): " project_id

if [ "$project_id" = "new" ]; then
    echo ""
    echo "Creating new Firebase project..."
    read -p "Enter project name: " project_name
    firebase projects:create "$project_name"
    project_id="$project_name"
fi

echo ""
echo "🔧 Configuring Flutter app with Firebase..."
flutterfire configure --project="$project_id"

echo ""
echo "📦 Installing dependencies..."
flutter pub get

echo ""
echo "✅ Firebase setup complete!"
echo ""
echo "Next steps:"
echo "1. Enable Authentication in Firebase Console"
echo "2. Create Firestore Database"
echo "3. Set up security rules"
echo "4. Run: flutter run"
echo ""
echo "For detailed instructions, see: FIREBASE_SETUP.md" 