#!/bin/bash

echo "🔍 GreenApp Setup Verification"
echo "=============================="
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

echo "✅ Flutter is installed"

# Check Flutter version
flutter_version=$(flutter --version | head -n 1)
echo "📱 $flutter_version"

# Check if dependencies are installed
if [ ! -f "pubspec.lock" ]; then
    echo "❌ Dependencies not installed. Run: flutter pub get"
    exit 1
fi

echo "✅ Dependencies are installed"

# Check if Firebase dependencies are in pubspec.lock
if grep -q "firebase_core" pubspec.lock; then
    echo "✅ Firebase Core is installed"
else
    echo "❌ Firebase Core is missing"
fi

if grep -q "firebase_auth" pubspec.lock; then
    echo "✅ Firebase Auth is installed"
else
    echo "❌ Firebase Auth is missing"
fi

if grep -q "cloud_firestore" pubspec.lock; then
    echo "✅ Cloud Firestore is installed"
else
    echo "❌ Cloud Firestore is missing"
fi

# Check iOS deployment target
ios_target=$(grep "IPHONEOS_DEPLOYMENT_TARGET" ios/Runner.xcodeproj/project.pbxproj | head -n 1)
if [[ $ios_target == *"13.0"* ]]; then
    echo "✅ iOS deployment target is set to 13.0"
else
    echo "❌ iOS deployment target needs to be 13.0"
fi

# Check Podfile
podfile_target=$(grep "platform :ios" ios/Podfile)
if [[ $podfile_target == *"13.0"* ]]; then
    echo "✅ Podfile platform is set to 13.0"
else
    echo "❌ Podfile platform needs to be 13.0"
fi

# Check if pods are installed
if [ -d "ios/Pods" ]; then
    echo "✅ iOS Pods are installed"
else
    echo "❌ iOS Pods are not installed. Run: cd ios && pod install"
fi

echo ""
echo "🚀 Setup Status:"
echo "=================="

# Count the number of ✅ and ❌
success_count=$(grep -c "✅" <<< "$(cat $0)")
error_count=$(grep -c "❌" <<< "$(cat $0)")

if [ $error_count -eq 0 ]; then
    echo "🎉 All checks passed! Your GreenApp is ready to run."
    echo ""
    echo "Next steps:"
    echo "1. Set up Firebase project (see FIREBASE_SETUP.md)"
    echo "2. Run: flutter run"
    echo "3. Test the app functionality"
else
    echo "⚠️  Some issues found. Please fix them before running the app."
    echo ""
    echo "Common fixes:"
    echo "- Run: flutter pub get"
    echo "- Run: cd ios && pod install"
    echo "- Check iOS deployment target settings"
fi

echo ""
echo "For Firebase setup, run: ./setup_firebase.sh" 