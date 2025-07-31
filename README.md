# Crypto App (SwiftUI)

This iOS application is a practice project built with SwiftUI, designed to explore and implement Clean Architecture principles and the Model-View-ViewModel (MVVM) design pattern. It fetches cryptocurrency data from the now-deprecated OpenBlur API (previously accessible via RapidAPI's free API collection).  **Please note that the API key and related code for OpenBlur have been removed from the repository for security reasons.** This project also integrates Firebase for authorization.

This project served as a learning experience, focusing on:

* **Clean Architecture:** Structuring the codebase for maintainability, testability, and scalability by separating concerns into distinct layers (Presentation, Domain, Data, Core).
* **MVVM (Model-View-ViewModel):** Implementing the MVVM pattern to decouple the view from the underlying data and business logic, improving code organization and testability.
* **SwiftUI:** Utilizing SwiftUI for building the user interface.
* **API Integration:** Working with RESTful APIs to retrieve and display data. While the specific API used in this project (OpenBlur) is no longer available, the architecture demonstrates how to integrate with external data sources.
* **Firebase Integration:** Utilizing Firebase for authorization

## Architecture

The project is structured according to Clean Architecture principles, with the following layers:

* **Presentation Layer (SwiftUI Views & ViewModels):** Contains the UI elements built with SwiftUI and ViewModels responsible for handling user interactions and presenting data.
* **Domain Layer (Use Cases & Entities):** Contains the business logic of the application, independent of any specific implementation details. Use Cases define actions the app can perform, and Entities represent the core data structures.
* **Core Layer(Networking & *Data Models & Extensions and Helpers ):** This layer contains shared components and utilities that are used across multiple other layers.
* **Data Layer (Repositories & Data Sources):** Handles data access, including fetching data from the API (in this case, previously OpenBlur) and persisting data. Repositories provide a unified interface for data access to the Domain Layer.

## Firebase Integration

This project uses Firebase for : 

* **Firebase Authentication:** To manage user accounts.


## Disclaimer

This project is for educational purposes only. The author is not responsible for any issues arising from the use of this code. The OpenBlur API is no longer available, and you will need to use a different API if you want to fetch live cryptocurrency data.
