class BlogUiModel {
  final String id;
  final String slug;
  final String title;
  final String description;
  final String category;
  final String date;
  final String readTime;
  final List<String> tags;
  final String? mediumUrl;
  final String content;

  const BlogUiModel({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.readTime,
    required this.tags,
    this.mediumUrl,
    required this.content,
  });

  static const List<BlogUiModel> dummyBlogs = [
    BlogUiModel(
      id: "1",
      slug: "mastering-clean-architecture-in-flutter",
      title: "Mastering Clean Architecture in Flutter Web & Mobile",
      description: "A comprehensive deep dive into decoupling business logic, state management, and repository abstraction in modern multi-platform Flutter apps.",
      category: "Architecture",
      date: "Aug 20, 2026",
      readTime: "6 min read",
      tags: ["Flutter", "Clean Architecture", "BLoC", "State Management"],
      mediumUrl: "https://medium.com/@rakaagus/mastering-clean-architecture-in-flutter",
      content: """
Clean Architecture is an engineering paradigm that isolates software into concentric layers of responsibility. When building scalable Flutter applications targeting both Web and Mobile, maintaining clean separation between presentation and data sources prevents high coupling and makes testability effortless.

### 1. The Three Core Layers

In our architecture, the codebase is partitioned into:
- **Presentation Layer**: Contains UI screens, reusable atomic widgets, and BLoC/Cubit state machines. UI elements only listen to immutable state emissions and dispatch intent events.
- **Domain Layer**: The purest core of the application. Contains domain entities and repository contracts without any Flutter or third-party SDK dependencies.
- **Data Layer**: Implements repository contracts, orchestrates remote REST / Supabase endpoints, and maintains local persistence via Drift SQLite tables and DAOs.

### 2. Dependency Inversion with GetIt

By registering our data sources, repositories, and blocs through a centralized service locator (`get_it`), any UI component can inject dependencies without knowing their concrete implementations. This enables painless mocking in unit tests and easy switching between local dummy data and remote APIs.

### 3. Key Takeaways
- Decouple your business entities from backend JSON schemas.
- UI should only react to state emissions, never perform direct network calls.
- Always use repository interfaces in domain logic to maintain high modularity.
""",
    ),
    BlogUiModel(
      id: "2",
      slug: "modern-android-development-with-jetpack-compose",
      title: "Modern Android Development: Jetpack Compose & MVI Pattern",
      description: "How to build declarative, crash-resilient native Android UIs using Jetpack Compose, Kotlin Coroutines, and Model-View-Intent architecture.",
      category: "Android",
      date: "Jul 15, 2026",
      readTime: "8 min read",
      tags: ["Android", "Kotlin", "Jetpack Compose", "MVI", "Coroutines"],
      mediumUrl: "https://medium.com/@rakaagus/modern-android-jetpack-compose-mvi",
      content: """
Jetpack Compose has fundamentally reshaped native Android UI engineering. Transitioning from traditional imperative XML layouts to declarative Kotlin composables reduces boilerplate and drastically improves code maintainability.

### 1. The Power of Unidirectional Data Flow (UDF)

In MVI (Model-View-Intent), the UI is a pure function of state:
- **Intent**: User interactions (button taps, text inputs) are captured as sealed interface events.
- **Model**: The ViewModel processes these intents asynchronously using Kotlin StateFlow and Coroutines, emitting a new immutable UI state.
- **View**: Jetpack Compose functions recompose efficiently whenever observed StateFlow values update.

### 2. Managing Side Effects Gracefully

Handling one-time events such as navigation triggers, snackbars, and hardware permission prompts requires dedicated effect handlers:
- Use `LaunchedEffect` tied to a specific key to handle lifecycle-aware actions.
- Use `rememberCoroutineScope` for UI-bound interactions like drawer toggles.

### 3. Hardware & POS Interoperability

When building enterprise handheld POS applications with thermal printers, Kotlin coroutines allow seamless background spooling of ESC/POS commands without blocking the 60fps Compose UI render loop.
""",
    ),
    BlogUiModel(
      id: "3",
      slug: "offline-first-mobile-apps-with-drift-sqlite",
      title: "Building Resilient Offline-First Mobile Apps with Drift SQLite",
      description: "Practical engineering patterns for syncing local SQLite databases with cloud backends, handling offline queues, and WebAssembly compilation.",
      category: "Database",
      date: "Jun 28, 2026",
      readTime: "5 min read",
      tags: ["Drift", "SQLite", "Offline-First", "Flutter Web"],
      mediumUrl: "https://medium.com/@rakaagus/offline-first-flutter-drift-sqlite",
      content: """
In real-world field operations—such as smart parking gates or retail POS terminals—network reliability is never guaranteed. Building offline-first systems ensures that users can continue recording transactions seamlessly regardless of connectivity dropouts.

### 1. Reactive Queries with Drift (formerly Moor)

Drift provides type-safe Dart APIs for SQLite with compile-time query validation. One of its standout superpowers is reactive stream queries:
- `watch()` returns a `Stream<List<T>>` that auto-emits fresh data whenever the underlying table undergoes insertion or updates.
- Combined with `Bloc`, local data changes instantly reflect on the screen without manual polling.

### 2. WebAssembly (WASM) for Flutter Web

Drift supports compiling SQLite to WebAssembly using modern browser IndexedDB backings via `drift/wasm.dart`. This brings desktop-grade relational database speeds and full ACID transaction guarantees directly into client-side browser PWAs.

### 3. Synchronization Queue Pattern

- Every mutation (e.g. ticket validation, invoice creation) is initially saved locally with a `sync_status = pending` flag.
- A background worker syncs pending records to the backend when connectivity is restored, resolving conflicts deterministically.
""",
    ),
  ];
}
