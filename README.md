# flutter_project_template

A CLI tool that bootstraps a new Flutter project with a clean architecture, pre-configured dependencies, and a ready-to-use folder structure.

## What It Does

Running `dart run flutter_project_template` in a Flutter project will:

1. **Install dependencies** — `http`, `flutter_bloc`, `shared_preferences`, `go_router`, `http_parser`, `easy_localization`, `equatable`
2. **Create the folder structure** under `lib/`:

```
lib/
├── config/
│   ├── theme_config/
│   └── locale_config/
├── models/
├── modules/
│   ├── splash/screen/
│   ├── home/
│   │   ├── bloc/
│   │   ├── cubit/
│   │   ├── screen/
│   │   └── widget/
│   ├── main/screen/
│   ├── profile/screen/
│   └── search/screen/
├── repository/
├── services/
├── utils/
└── widgets/
languages/
```

3. **Generate boilerplate files** — theme management, routing, API services, shared preferences, localization, and more (defined in `lib/file_with_content.dart`)
4. **Write `lib/main.dart`** — with `EasyLocalization`, `ThemeCubit` (via `BlocProvider`), `go_router` config, and text-scale clamping
5. **Update `pubspec.yaml`** — adds a `languages/` asset entry

## Features

- Automated dependency installation
- Clean, scalable folder structure ready from the start
- Pre-configured `main.dart` with theme, localization, and routing
- Internationalization support via `easy_localization` (en, my)
- Theme switching with `ThemeCubit` (light / dark)
- Text-scale clamping (0.8–1.1) for consistent UI
- Utility extensions and context extensions included

## Getting Started

1. **Create a new Flutter project** (or use an existing one):
   ```bash
   flutter create my_app
   cd my_app
   ```

2. **Add this package**:
   ```bash
   flutter pub add flutter_project_template
   ```

3. **Run the bootstrap script**:
   ```bash
   dart run flutter_project_template
   ```

4. **Customize** the generated files to suit your needs and add your business logic.