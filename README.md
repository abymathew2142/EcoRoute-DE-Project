![CI Status](https://github.com/abymathew2142/EcoRoute-DE-Project/workflows/EcoRoute%20DE%20CI/badge.svg)
[![iOS starter workflow](https://github.com/abymathew2142/EcoRoute-DE-Project/actions/workflows/ios.yml/badge.svg)](https://github.com/abymathew2142/EcoRoute-DE-Project/actions/workflows/ios.yml)


# EcoRoute DE 🚄📱

An enterprise-ready iOS utility built entirely in **SwiftUI** designed for German professionals to seamlessly track daily commutes, optimize their carbon footprint, and automate their local tax refunds (*Pendlerpauschale*). Fraud Prevention using CoreLocation API to avoid manual data tampering for German Tax Office compliance

## 🏛 Architecture & Design Patterns
This project uses a decoupled **Three-Layer Clean Architecture** optimized for maximum maintainability and separation of concerns:

- **Presentation Layer**: Built declaratively using SwiftUI with the modern `@Observable` state machinery.
- **Domain Layer**: Contains the core business domain logic models and abstraction boundary protocols.
- **Data Layer**: Implements the Repository Pattern leveraging **SwiftData** for local persistence caching.

## 🛠 Features & Tech Stack
- **Native Local Database**: SwiftData storage infrastructure keeping user data private and safe offline.
- **Strict Testing Suite**: Robust unit tests with mocked abstractions targeting business math logic.
- **Swift Concurrency**: Fully non-blocking, multi-threaded task management via native `async/await`.

## 🧪 Running the Tests
Simply clone the repository, open `EcoRouteDE.xcodeproj` in Xcode, and press `⌘+U` to run the suite.
