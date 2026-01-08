if [ ! -f .env ]; then
    echo ".env file not found!"
    exit 1
fi

flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs