# Flutter Presentation Layer — BLoC, Screen, & Widget Pattern

## 🎯 Tujuan
Standar presentation layer di project ini — mencakup BLoC pattern, struktur halaman, dan state management.

## 🧠 State Management: flutter_bloc

Project ini menggunakan **flutter_bloc** (`^8.0.1`) sebagai state management utama.

### Perbedaan BLoC vs Cubit
| Aspek | BLoC | Cubit |
|-------|------|-------|
| Event | Ada (Event class) | Tidak ada (langsung method) |
| Penggunaan | Complex logic | Simple state |
| Contoh di project | `HomeBloc`, `ProjectBloc` | `ThemeCubit`, `LocaleCubit` |

## 📁 Struktur BLoC per Halaman

```
lib/presentation/bloc/<nama_halaman>/
├── <nama>_screen.dart          # Widget utama (entry point)
├── <nama>_content.dart         # Konten UI (terpisah dari screen)
├── bloc/
│   ├── <nama>_bloc.dart        # BLoC class
│   ├── <nama>_event.dart       # Events
│   └── <nama>_state.dart       # States
└── widget/
    └── *.dart                  # Widget spesifik halaman
```

### Contoh Struktur Home
```
lib/presentation/bloc/home/
├── home_screen.dart
├── home_content.dart
├── bloc/
│   ├── home_bloc.dart
│   ├── home_event.dart
│   └── home_state.dart
└── widget/
    ├── experience_card.dart
    ├── tech_stak_widget.dart
    └── testimonial_section_widget.dart
```

## 📝 Pola BLoC

### Event
```dart
// <nama>_event.dart
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeData extends HomeEvent {
  const LoadHomeData();

  @override
  List<Object> get props => [];
}
```

### State
```dart
// <nama>_state.dart
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final List<ExperienceData> experiences;
  const HomeLoaded({required this.experiences});

  @override
  List<Object> get props => [experiences];
}
class HomeError extends HomeState {
  final String message;
  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}
```

### BLoC
```dart
// <nama>_bloc.dart
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository;

  HomeBloc({required HomeRepository repository})
      : _repository = repository,
        super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final result = await _repository.getHomeData();

    if (result.isError) {
      emit(HomeError(message: result.message));
    } else {
      emit(HomeLoaded(experiences: result.data ?? []));
    }
  }
}
```

## 🖥️ Pola Screen

### Screen — Entry Point
```dart
// home_screen.dart
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(repository: getIt<HomeRepository>())..add(LoadHomeData()),
      child: const HomeView(),
    );
  }
}
```

### Content — UI
```dart
// home_content.dart
class HomeContent extends StatefulWidget {
  final ScrollController scrollController;
  final Function(String url) onNavigate;

  const HomeContent({
    super.key,
    required this.scrollController,
    required this.onNavigate,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}
```

## 🎨 Base Widget Pattern

Project memiliki base widgets untuk konsistensi:

File: `lib/utils/base/`
- `base_stateful_widget.dart` — `BaseStatefulWidget` (base class untuk semua halaman)
- `base_stateful_stay_alive_widget.dart` — `BaseStatefulStayAliveWidget` (preserve state)
- `base_bloc_event.dart` — `BaseBlocEvent` (base event)
- `base_config.dart` — `BaseConfig` (konfigurasi)

## 📍 Pola Penggunaan BLoC di Widget

### BlocProvider (menyediakan BLoC)
```dart
BlocProvider(
  create: (_) => HomeBloc(),
  child: HomeContent(),
)
```

### BlocBuilder (membangun UI berdasarkan state)
```dart
BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {
    // state: HomeInitial, HomeLoading, HomeLoaded, HomeError
  },
)
```

### BlocListener (side effect — navigasi, snackbar)
```dart
BlocListener<HomeBloc, HomeState>(
  listener: (context, state) {
    if (state is HomeError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  child: /* content */,
)
```

### context.watch / context.read
```dart
// watch — rebuild saat state berubah
final themeMode = context.watch<ThemeCubit>().state;

// read — akses tanpa rebuild
context.read<ThemeCubit>().toggleTheme(brightness);
```

## 🚨 Aturan Presentation Layer
1. **JANGAN panggil repository langsung** dari widget — harus lewat BLoC
2. **Pisahkan Screen dan Content** — `*_screen.dart` untuk BlocProvider/Scaffold, `*_content.dart` untuk isi
3. **Gunakan Equatable** untuk state/event
4. **SELALU emit state** yang jelas (Initial, Loading, Loaded, Error)
5. **Perhatikan dispose** — `AnimationController` dan stream wajib di-`dispose`
6. **Berikan callback** (`onNavigate`) dari parent, bukan navigasi langsung
7. **Widget spesifik halaman** taruh di folder `widget/`, bukan di `lib/presentation/widget/`