# Coffee Shop iOS App

## Overview
This is a personal project developed as a SwiftUI-based iOS application for a coffee shop, showcasing a clean and scalable codebase using the Model-View-ViewModel (MVVM) architecture. The app includes core features such as browsing coffee items, viewing item details, placing orders, and tracking delivery, designed to provide a seamless user experience.

## Features
- **Home Screen**: Displays a welcoming interface with a list of coffee items and promotions.
- **Item Detail Screen**: Provides detailed information about each coffee item, including description, price, and customization options.
- **Order Screen**: Allows users to add items to their cart and place orders.
- **Delivery Screen**: Tracks the status of placed orders and delivery updates.
- **MVVM Architecture**: Ensures a clean separation of concerns, making the codebase scalable and maintainable.

## Technologies Used
- **SwiftUI**: For building a modern, declarative user interface.
- **Swift**: Programming language for iOS development.
- **MVVM Architecture**: For organizing code into models, views, and view models for scalability and testability.
- **Xcode**: Development environment for building and testing the app.

## Prerequisites
- **Xcode**: Version 15.0 or higher.
- **iOS**: Version 16.0 or higher for compatibility.
- **MacOS**: For running Xcode and iOS simulators.
- **Git**: For cloning the repository.

## Installation
1. Clone the repository from GitHub:
   ```bash
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```bash
   cd coffee-shop-ios
   ```
3. Open the project in Xcode:
   ```bash
   open CoffeeShop.xcodeproj
   ```
4. Select a simulator or connect an iOS device.
5. Build and run the app in Xcode:
   - Press `Cmd + R` or click the "Run" button in Xcode.

## Project Structure
```
coffee-shop-ios/
├── CoffeeShop/            # Main app directory
│   ├── Models/            # Data models (e.g., CoffeeItem, Order)
│   ├── Views/             # SwiftUI view components (HomeView, ItemDetailView, etc.)
│   ├── ViewModels/        # ViewModel classes for MVVM architecture
│   ├── Services/          # Networking or mock data services
│   ├── Assets.xcassets/   # Images and app icons
│   └── AppDelegate.swift  # App entry point
├── Tests/                 # Unit tests for ViewModels and Models
├── README.md              # This file
└── CoffeeShop.xcodeproj   # Xcode project file
```

## Usage
1. Launch the app on a simulator or iOS device.
2. Navigate the **Home Screen** to browse available coffee items.
3. Tap an item to view the **Item Detail Screen** and customize your order.
4. Add items to the cart and proceed to the **Order Screen** to place your order.
5. Track your order status on the **Delivery Screen**.
6. Explore the MVVM architecture in the codebase for learning purposes or further development.

## Screenshots
*(Optional: Add screenshots of the app's screens to the `assets/` folder and link them here for visual reference.)*

## Contributing
1. Fork the repository on GitHub.
2. Create a new branch for your feature or bug fix:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature or fix description"
   ```
4. Push to your branch:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request with a detailed description of your changes.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact
For questions or feedback, please contact [mennahmustafaa@gmail.com] or open an issue on the GitHub repository.

## Acknowledgments
- Built as a personal project to demonstrate SwiftUI and MVVM expertise.
- Inspired by modern coffee shop app designs and user experiences.
