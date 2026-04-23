# BLOC ADVANCED - Flutter Clean Architecture Base Template

A production-ready Flutter template demonstrating **Clean Architecture**, **BLoC/Cubit pattern**, and industry best practices. Use this as a base for all future Flutter projects.

---

## 📋 Table of Contents

- [What This App Does](#-what-this-app-does)
- [Getting Started](#-getting-started)
- [Environments & Flavors](#-environments--flavors)
- [Project Architecture](#️-project-architecture-clean-architecture)
- [Development Standards](#-development-standards)
- [Folder Structure](#-folder-structure)
- [Core & Shared Modules](#-core--shared-modules)
- [Adding a New Feature](#-adding-a-new-feature)
- [Navigation & Routing](#-navigation--routing)
- [API Configuration](#-api-configuration)
- [Theming & Styling](#-theming--styling)
- [Dependency Injection](#-dependency-injection)
- [Dependencies](#-dependencies)
- [Commands Reference](#-commands-reference)
- [Troubleshooting](#-troubleshooting)
- [Best Practices](#-best-practices)

---

## 📱 What This App Does

1.  **Splash Screen** - Animations and session check.
2.  **Login Screen** - Authentication using the standardized `PrimaryButton`.
3.  **Dashboard** - Products with pagination and cached `CustomNetworkImage`.

---

## 🚀 Getting Started

### Prerequisites

| Requirement | Version |
|-------------|---------|
| Flutter SDK | `3.41.7` |
| Dart SDK | `^3.10.3` |
| Android Studio / VS Code | Latest |
| Xcode (for iOS) | Latest |

### Quick Start

```bash
# 1. Clone the repository
git clone <repository-url>
cd bloc_advanced

# 2. Install dependencies
flutter pub get

# 3. Run the app (Dev environment)
flutter run -t lib/main/main_dev.dart
```

### Setting Up for a New Project

When cloning this template for a new project:

```bash
# 1. Change app package name (Android bundle ID / iOS bundle identifier)
dart run change_app_package_name:main com.yourcompany.newapp

# 2. Rename the app display name
dart run rename_app:main all="Your App Name"

# 3. Generate new app icons (after replacing assets/images/app_icon.png)
dart run flutter_launcher_icons

# 4. Update pubspec.yaml with your app details
# - name: your_app_name
# - description: "Your app description"
```

---

## 🌍 Environments & Flavors

We use **Flavors** (different environments) to manage the app lifecycle from development to production effectively.

### Why do we use Flavors?

1.  **Safety**: We don't want to test new features on the "Production" database where real user data lives. We use "Dev" or "Staging" for that.
2.  **Configuration**: Each environment needs different settings (e.g., API Base URL, App Name, Icon).
    *   **Dev**: Uses test APIs, shows debug logs.
    *   **Staging**: A mirror of production for final testing.
    *   **Prod**: The live app for real users.

### How to Run (Command Line)

| Env | Entry Point | Command |
|-----|-------------|---------|
| **Dev** | `lib/main/main_dev.dart` | `flutter run -t lib/main/main_dev.dart` |
| **Staging** | `lib/main/main_staging.dart` | `flutter run -t lib/main/main_staging.dart` |
| **Prod** | `lib/main.dart` | `flutter run` |

### How to Set Up in Android Studio

To run different flavors easily in Android Studio, create **Run Configurations**:

1.  Click the **Run Configuration** dropdown (next to the Play button in the top toolbar).
2.  Select **Edit Configurations...**.
3.  Click the **+** (Plus) icon and select **Flutter**.
4.  **Create Dev Config**:
    *   **Name**: `main_dev`
    *   **Dart entrypoint**: Browse and select `lib/main/main_dev.dart`
5.  **Create Staging Config**:
    *   **Name**: `main_staging`
    *   **Dart entrypoint**: Browse and select `lib/main/main_staging.dart`
6.  **Create Prod Config**:
    *   **Name**: `main`
    *   **Dart entrypoint**: Browse and select `lib/main.dart`
7.  Click **Apply** and **OK**.

Now you can simply switch between `main_dev`, `main_staging`, and `main` from the dropdown and hit Play! ▶️

### Environment Configuration

Update your environment URLs in `lib/main/app_env.dart`:

```dart
static const _baseUrl = {
  AppEnvironment.dev: 'https://dev-api.yourapp.com/',
  AppEnvironment.stage: 'https://staging-api.yourapp.com/',
  AppEnvironment.prod: 'https://api.yourapp.com/',
};
```

---

## 🏗️ Project Architecture (Clean Architecture)

This project follows **Clean Architecture**. Each feature (e.g., `login`, `dashboard`) is split into **3 main layers** inside its folder.

```
┌─────────────────────────────────────────────────────────────┐
│                     PRESENTATION LAYER                       │
│              (UI, Widgets, Cubit/BLoC, Pages)               │
│                         ↓ calls                              │
├─────────────────────────────────────────────────────────────┤
│                       DOMAIN LAYER                           │
│              (UseCases, Repository Interfaces)               │
│                         ↓ calls                              │
├─────────────────────────────────────────────────────────────┤
│                        DATA LAYER                            │
│         (Repository Impl, DataSources, Models)              │
│                         ↓ calls                              │
├─────────────────────────────────────────────────────────────┤
│                    EXTERNAL SOURCES                          │
│                  (API, Local Database)                       │
└─────────────────────────────────────────────────────────────┘
```

---

## 🛠️ Development Standards (MANDATORY)

Follow these standards to maintain architectural integrity:

### 1. Model Structure
Every data model must follow this exact order:
1. **Top-Level Helpers**: `xxxFromJson()` and `xxxToJson()`.
2. **Variable Declarations**: Nullable variables at the very top.
3. **Default Constructor**: Using `this.xxx` parameters.
4. **Named Constructor**: `Model.fromJson(dynamic json)`.
5. **Method**: `Map<String, dynamic> toJson()`.

### 2. Request Parameters
- **NEVER** pass primitive values (strings, ints) through layers.
- **ALWAYS** create a Request Model (e.g., `ProductRequest`) and pass the entire object.

### 3. UI Values
- **Dimensions**: Use `Dimens.xxx` for all spacing, padding, and radii.
- **Strings**: Use `AppStrings.xxx` (localized via `en.json`).
- **Loader**: Use `CustomLoader()` for all progress indicators.

---

### Layer Details

#### 1. 📂 Data (`lib/features/feature_name/data/`)
*The "Hardware" of the feature. Handles raw data.*

*   **Datasource** (`datasource/`): Files that actually call the API (e.g., `Dio` requests) or Local DB.
*   **Models** (`models/`): Dart classes that match the API JSON response exactly (using `fromJson`).
*   **Repositories Implementation** (`repositories/`): The implementation of the Domain Repository. It decides *where* to get data (API vs Cache).

#### 2. 📂 Domain (`lib/features/feature_name/domain/`)
*The "Brain" of the feature. Pure business logic, no UI code.*

*   **Repositories** (`repositories/`): Abstract interfaces (contracts) defining *what* data is needed, but not *how* to get it.
*   **UseCase** (`use_case/`): Single-purpose classes that do ONE thing (e.g., `LoginUseCase`, `GetProductsUseCase`). The UI calls these.

#### 3. 📂 Presentation (`lib/features/feature_name/presentation/`)
*The "Face" of the feature. What the user sees.*

*   **Cubit/BLoC** (`cubit/`): State management. Calls UseCases and updates the State.
*   **Pages** (`pages/`): Flutter Widgets (UI). They listen to the Cubit state and rebuild.
*   **Widgets** (`widgets/`): *(Optional)* Reusable widgets specific to this feature. Only create this folder if the feature has custom widgets.

---

## 📁 Folder Structure

```
lib/
├── main.dart                    # Production entry point
├── main/                        # App initialization
│   ├── app.dart                 # Root MaterialApp widget
│   ├── app_env.dart             # Environment configuration
│   ├── main_dev.dart            # Dev environment entry
│   └── main_staging.dart        # Staging environment entry
│
├── core/                        # Core utilities (shared across all features)
│   ├── constants/               # App-wide constants
│   │   ├── routes.dart          # Route names
│   │   ├── endpoints.dart       # API endpoints
│   │   ├── asset_path.dart      # Asset paths
│   │   ├── constant.dart        # App constants
│   │   ├── date_converstion.dart # Date utilities
│   │   └── app_language.dart    # Language config
│   ├── database/                # Local database (Hive)
│   ├── dependency_injection/    # GetIt service locator
│   │   └── injector.dart        # DI setup
│   ├── exceptions/              # Custom exceptions
│   ├── extension/               # Dart extensions
│   ├── network/                 # Networking (Dio)
│   │   ├── dio_network_service.dart
│   │   ├── network_service.dart
│   │   ├── auth_interceptors.dart   # Automatic token refresh & 401 handling
│   │   └── connection/          # Connectivity checker
│   └── utils/                   # Utility functions
│
├── features/                    # Feature modules
│   ├── splash/                  # Splash screen feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── login/                   # Login feature
│   │   ├── data/
│   │   │   ├── datasource/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── repositories/
│   │   │   └── use_case/
│   │   └── presentation/
│   │       ├── cubit/
│   │       └── pages/
│   └── dashboard/               # Dashboard feature
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── routes/                      # Navigation
│   └── app_routes.dart          # GoRouter configuration
│
└── shared/                      # Shared components
    ├── config/                  # App configuration (dimensions)
    ├── models/                  # Shared models
    ├── theme/                   # Theming
    │   ├── app_colors.dart      # Color palette
    │   ├── app_theme.dart       # ThemeData
    │   └── text_styles.dart     # Typography
    └── widgets/                 # Reusable widgets
        ├── custom_loader.dart
        ├── custom_network_image.dart
        ├── custom_text_input.dart
        ├── custom_toast.dart
        ├── primary_button.dart
        └── svg_image.dart
```

---

## 🔧 Core & Shared Modules

### 📂 Core (`lib/core/`)
*Foundational utilities shared across all features.*

| Folder | Purpose |
|--------|---------|
| `constants/` | App-wide constants: routes, endpoints, asset paths, date conversions, language config. |
| `database/` | **Encrypted Local Storage**: Implementation of Hive with `flutter_secure_storage` for 256-bit AES encryption. |
| `dependency_injection/` | Service Locator setup using `get_it`. |
| `exceptions/` | Custom exception classes for error handling. |
| `extension/` | Dart extension methods for added functionality. |
| `network/` | Dio client setup, **5000ms timeouts**, Auth interceptors, API helpers. |
| `utils/` | General utility functions and helpers. |

### 📂 Shared (`lib/shared/`)
*Reusable components used across multiple features.*

| Folder | Purpose |
|--------|---------|
| `config/` | App configuration (e.g., dimensions, sizes). |
| `models/` | Shared data models used across features. |
| `theme/` | App theme, colors, and text styles. |
| `widgets/` | `PrimaryButton`, `CustomNetworkImage`, `CustomLoader`, `CustomTextInput`, `CustomToast`. |

---

## ➕ Adding a New Feature

Follow these steps to add a new feature (e.g., `profile`):

- **Quick Scaffolding**: 
  `mkdir -p lib/features/NAME/{data/{datasource,models,repositories},domain/{repositories,use_case},presentation/{cubit,pages}}`
- **File Initializing**:
  `NAME="feature_name" && touch lib/features/$NAME/{data/datasource/${NAME}_remote_data_source.dart,data/repositories/${NAME}_repository_impl.dart,domain/repositories/${NAME}_repository.dart,domain/use_case/${NAME}_use_case.dart,presentation/cubit/{${NAME}_cubit.dart,${NAME}_state.dart},presentation/pages/${NAME}.dart}`

### Step 1: Create the folder structure

```bash
mkdir -p lib/features/profile/{data/{datasource,models,repositories},domain/{repositories,use_case},presentation/{cubit,pages}}
```

### Step 2: Create files in order

1. **Domain Layer** (Start here - define the contract)
   ```
   lib/features/profile/domain/
   ├── repositories/profile_repository.dart    # Abstract interface
   └── use_case/get_profile_usecase.dart       # Business logic
   ```

2. **Data Layer** (Implement the contract)
   ```
   lib/features/profile/data/
   ├── models/profile_model.dart               # JSON model
   ├── datasource/profile_remote_data_source.dart
   └── repositories/profile_repository_impl.dart
   ```

3. **Presentation Layer** (UI)
   ```
   lib/features/profile/presentation/
   ├── cubit/profile_cubit.dart
   ├── cubit/profile_state.dart
   └── pages/profile_page.dart
   ```

### Step 3: Register in Dependency Injection

Add to `lib/core/dependency_injection/injector.dart`:

```dart
// DataSource
..registerLazySingleton<ProfileRemoteDataSource>(
  () => ProfileRemoteDataSourceImpl(injector()),
)
// Repository
..registerLazySingleton<ProfileRepository>(
  () => ProfileRepositoryImpl(injector()),
)
// UseCase
..registerLazySingleton<GetProfileUseCase>(
  () => GetProfileUseCase(injector()),
)
```

### Step 4: Add Route

Add to `lib/core/constants/routes.dart`:
```dart
static const profilePath = '/profile';
```

Add to `lib/routes/app_routes.dart`:
```dart
GoRoute(
  path: RoutesName.profilePath,
  builder: (context, state) => const ProfilePage(),
),
```

---

## 🗺️ Navigation & Routing

We use **GoRouter** for navigation. Routes are defined in two places:

### Route Names (`lib/core/constants/routes.dart`)

```dart
class RoutesName {
  static const defaultPath = '/';           // Splash
  static const loginPath = '/login';        // Login
  static const homePage = '/home';          // Dashboard
  static const profilePath = '/profile';    // Profile (example)
}
```

### Route Configuration (`lib/routes/app_routes.dart`)

```dart
final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/login', builder: (_, __) => const Login()),
    GoRoute(path: '/home', builder: (_, __) => const Dashboard()),
  ],
);
```

### Navigation Usage

```dart
// Navigate to a route
context.go(RoutesName.homePage);

// Navigate with replacement (can't go back)
context.pushReplacement(RoutesName.loginPath);

// Navigate with parameters
context.go('/product/123');
```

---

## 📡 API Configuration

### Base URL Configuration

Update URLs in `lib/main/app_env.dart`:

```dart
static const _baseUrl = {
  AppEnvironment.dev: 'https://dev-api.yourapp.com/',
  AppEnvironment.stage: 'https://staging-api.yourapp.com/',
  AppEnvironment.prod: 'https://api.yourapp.com/',
};
```

### Adding New Endpoints

Add to `lib/core/constants/endpoints.dart`:

```dart
class ApiEndpoint {
  // Auth
  static const String login = 'auth/login';
  static const String authMe = 'auth/me';
  static const String refreshToken = 'auth/refresh';

  // Products
  static const String products = 'products';
  
  // Add your new endpoint here
  static const String profile = 'user/profile';
}
```

### Making API Calls

Use the `NetworkService` in your DataSource:

```dart
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final NetworkService _networkService;
  
  ProfileRemoteDataSourceImpl(this._networkService);
  
  @override
  Future<ProfileModel> getProfile() async {
    final response = await _networkService.get(ApiEndpoint.profile);
    return ProfileModel.fromJson(response.data);
  }
}
```

---

## 🎨 Theming & Styling

### Color Palette (`lib/shared/theme/app_colors.dart`)

```dart
class AppColors {
  // Primary Colors
  static const Color colorPrimary = Color(0xFF2563EB);
  static const Color colorPrimaryDark = Color(0xFF1D4ED8);
  
  // Background Colors
  static const Color appBackGround = Color(0xFFF8FAFC);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  
  // Status Colors
  static const Color colorRed = Color(0xFFEF4444);
  static const Color colorGreen = Color(0xFF22C55E);
}
```

### Using Colors

```dart
Container(
  color: AppColors.colorPrimary,
  child: Text(
    'Hello',
    style: TextStyle(color: AppColors.textPrimary),
  ),
)
```

### Text Styles (`lib/shared/theme/text_styles.dart`)

Pre-defined text styles for consistent typography.

### Dimensions (`lib/shared/config/dimens.dart`)

Use predefined dimensions for consistent spacing:

```dart
Padding(
  padding: EdgeInsets.all(Dimens.padding16),
  child: ...
)
```

---

## 💉 Dependency Injection

We use **GetIt** for dependency injection. All dependencies are registered in `lib/core/dependency_injection/injector.dart`.

### How It Works

```dart
// Registration (in injector.dart)
final injector = GetIt.instance;

Future<void> init() async {
  injector
    // Services
    ..registerLazySingleton<NetworkService>(DioNetworkService.new)
    
    // DataSources
    ..registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(injector()),
    )
    
    // Repositories
    ..registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(injector()),
    )
    
    // UseCases
    ..registerLazySingleton<LoginUseCases>(
      () => LoginUseCases(injector()),
    );
}
```

### Using Dependencies

```dart
// In Cubit
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCases _loginUseCases;
  
  LoginCubit() : 
    _loginUseCases = injector<LoginUseCases>(),
    super(LoginInitial());
}
```

---

## 📦 Dependencies (`pubspec.yaml`)

This file manages all third-party libraries and assets.

### Key Packages

| Package | Purpose |
|---------|---------|
| **State Management** |
| `flutter_bloc` | Helps manage state using BLoC/Cubit pattern. |
| `bloc` | Core BLoC logic. |
| `equatable` | Helps compare objects (useful for identifying if State has changed). |
| `get_it` | Service Locator for Dependency Injection (accessing objects anywhere). |
| **Networking** |
| `dio` | Powerful HTTP client for making API calls. |
| `flutter_pretty_dio_logger` | Prints readable API logs to the console for debugging. |
| `connectivity_plus` | Checks if the device has internet connection. |
| **Navigation & UI** |
| `go_router` | Handles screen navigation and URLs (e.g., `/home`). |
| `get` | Used here mainly for Translation (`.tr`) and Utils. |
| `toastification` | Shows nice toast messages/notifications in the app. |
| `flutter_svg` | Allows rendering SVG (vector) icons. |
| `cupertino_icons` | iOS style icons. |
| `cached_network_image` | Loads and caches internet images (so they load faster next time). |
| **Storage & Utils** |
| `hive_flutter` | Fast local NoSQL database (storage) for the app. |
| `intl` | Date and number formatting. |

### Pubspec File Explained

Besides `dependencies`, the `pubspec.yaml` contains:

1.  **Environment**: 
    *   **Dart SDK**: `^3.10.3` (Requires Dart SDK version 3.10.3 or higher).
    *   **Flutter SDK**: `3.41.7` (Required Flutter version for this project).
2.  **Dev Dependencies**: Tools only for developers, not in the final app.
    *   `flutter_lints`: Linting rules for code quality and consistency.
    *   `flutter_launcher_icons`: Generates app icons for Android/iOS.
    *   `rename_app`: Updates the app bundle ID and name.
    *   `change_app_package_name`: Changes the app's package name (bundle ID).
3.  **Flutter Section**:
    *   **Assets**: Lists asset folders so Flutter knows to include them:
        *   `assets/images/` - App images and icons
        *   `assets/icons/` - SVG icons
        *   `assets/language/` - Translation files
        *   `assets/gif/` - GIF animations
        *   `assets/fonts/` - Custom font files
    *   **Fonts**: Registers custom fonts (e.g., `OpenSans` with Regular, Light, Bold weights).

---

## 🛠️ Commands Reference

### Development

```bash
# Run in dev mode
flutter run -t lib/main/main_dev.dart

# Run in staging mode
flutter run -t lib/main/main_staging.dart

# Run in production mode
flutter run

# Run on specific device
flutter run -d <device_id>

# Hot restart
r (in terminal) or Ctrl+Shift+F5 (VS Code)
```

### Building

```bash
# Build APK (Android)
flutter build apk --release

# Build App Bundle (Android - for Play Store)
flutter build appbundle --release

# Build iOS
flutter build ios --release

# Build with specific flavor
flutter build apk -t lib/main/main_prod.dart --release
```

### Utilities

```bash
# Install dependencies
flutter pub get

# Clean build cache
flutter clean && flutter pub get

# Analyze code
flutter analyze

# Format code
dart format lib/

# Generate app icons
dart run flutter_launcher_icons

# Change package name
dart run change_app_package_name:main com.yourcompany.appname

# Rename app
dart run rename_app:main all="App Name"
```

---

## 🐛 Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| `flutter pub get` fails | Run `flutter clean` then `flutter pub get` |
| Build fails after switching branches | Run `flutter clean && flutter pub get` |
| iOS build fails | Run `cd ios && pod install --repo-update && cd ..` |
| Android build fails | Check `minSdkVersion` in `android/app/build.gradle` |
| Fonts not loading | Ensure fonts are under `flutter:` section in `pubspec.yaml` |
| Assets not found | Run `flutter pub get` after adding new assets |
| GetIt not initialized | Ensure `await init()` is called in `main()` before `runApp()` |

### Debug Tips

1. **Check API logs**: `flutter_pretty_dio_logger` prints all API requests/responses in console.
2. **Check Bloc state**: Use `BlocObserver` to log all state changes.
3. **Check routes**: Print `GoRouter.of(context).location` to see current route.

---

## ✅ Best Practices

### Code Organization
- [ ] One class per file
- [ ] Use barrel files (`index.dart`) for clean exports
- [ ] Keep widgets small and focused
- [ ] Extract reusable widgets to `shared/widgets/`

### State Management
- [ ] Use Cubit for simple state, BLoC for complex event-driven state
- [ ] Always use `Equatable` for states
- [ ] Handle all states: Initial, Loading, Success, Error

### API Calls
- [ ] Always handle errors gracefully
- [ ] Use models for type-safe JSON parsing
- [ ] Add loading indicators during API calls
- [ ] **Network Resilience**: Use global 5000ms timeouts and Auth Interceptors for reliable API handling.

### Security
- [ ] **Data Encryption**: Sensitive data (Tokens, User Profiles) must be stored in encrypted Hive boxes.
- [ ] **Secure Storage**: Use `SecureStorageService` to manage encryption keys; never hardcode keys in the source.

### Testing
- [ ] Write unit tests for UseCases
- [ ] Write widget tests for critical UI components
- [ ] Test all state transitions in Cubits

### Performance
- [ ] Use `const` constructors where possible
- [ ] Avoid rebuilding entire widget trees
- [ ] Use `ListView.builder` for long lists
- [ ] Cache network images with `cached_network_image`

---

## 👨‍💻 Author

**Albert Jeba** - Clean Architecture Flutter Base Template




###