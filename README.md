# GithubAPI
## Overview

The **GitHubAPI** Project is an iOS application designed to fetch and display user repositories from the GitHub API. Developed using modern iOS best practices, the app emphasizes clean code principles, testability, and security. It integrates networking, local caching, and core software development principles to ensure scalability and maintainability.

## Key Features

- **MVVM Architecture**: Implements the Model-View-ViewModel pattern to ensure a clear separation of concerns and enhance testability.
- **OOP(Object-Oriented Programming)**: The app is designed with OOP principles, focusing on modularity, encapsulation, and reuse.
- **POP (Protocol-Oriented Programming)**: Protocols are extensively used to create flexible and reusable components, promoting clean and maintainable code.
- **SOLID Principles**: Adherence to SOLID principles ensures that the codebase is scalable and easy to extend without introducing technical debt.
- **Unit Testing**: Comprehensive unit tests cover critical functionality, providing a reliable and robust foundation.
- **Core Data for Local Persistence**: Core Data is used to store and manage data offline, allowing users to access repositories even when the network is unavailable.
- **Generic Network Manager**: The project features a generic network manager that handles API requests and responses, ensuring efficient data fetching and error management.
- **Closures for Asynchronous Operations**: Closures are used to handle callbacks in asynchronous operations, such as fetching data from the network.
- **Enums for State Management**: Enums are used to manage different states across the application, providing a clear and type-safe way to handle various outcomes.

  
## Technologies Used

- **Swift**: The programming language used for development.
- **Core Data**: Used for local data storage and offline access.
- **XCTest**: Framework used for unit testing.
- **GitHub API**: The API that provides data for the application.

## Design and Architecture

- **OOP and POP (Protocol-Oriented Programming)**
- The project leverages both Object-Oriented Programming (OOP) and Protocol-Oriented Programming (POP):

- OOP: The app's structure follows classic object-oriented principles like encapsulation and inheritance, making the codebase modular and easy to maintain.

- OP: Protocols define the essential behaviors of different components, making the system flexible and promoting code reuse.

- **SOLID Principles**
---The app adheres to the SOLID design principles:

---S: Single Responsibility - Every class has a single responsibility.
---O: Open/Closed - The app is open for extension but closed for modification, allowing for easy additions without changing existing code.
---L: Liskov Substitution - Subclasses can replace base classes without breaking functionality.
---I: Interface Segregation - Each protocol defines only the necessary methods to prevent unnecessary dependencies.
---D: Dependency Inversion - High-level modules depend on abstractions (protocols) rather than concrete implementations.

- **Generic Network Manager**
---The app includes a generic network manager that handles all API requests. This allows for:

---Efficient data fetching from different endpoints.
---Error management and handling across various network operations.
---Flexibility to extend the manager for additional APIs.
---Core Data for Local Persistence

- **Core Data is employed to**:
---Store fetched GitHub repositories locally.
---Provide offline access to repositories when the network is unavailable.
---Cache API responses, ensuring quick access and improved user experience.

- **Unit Testing**
---The project includes unit tests that cover:

---Network operations: Ensuring that API calls return expected results or handle errors appropriately.
---Core Data operations: Verifying data is properly stored, retrieved, and managed.
---Business logic: Ensuring correct transformation of data between layers.
---Security Considerations

## Core Data Vulnerabilities and Precautions

**Unencrypted Data Storage**:
---Issue: Core Data stores data unencrypted by default, which could expose sensitive information.

---Precaution: Sensitive data can be encrypted manually before saving or by using NSPersistentStoreCoordinator's encryption options.

**Data Tampering**:
---Issue: Local Core Data files could be modified if a device is compromised.

---Precaution: Validate and sanitize data before using it and consider using cryptographic hashes to ensure data integrity.

**Weak Access Control**:
---Issue: Unauthorized access to Core Data could expose sensitive information.

---Precaution: Use iOS security features like Keychain for storing sensitive information and enforce authentication for accessing critical data.

## Network Security Vulnerabilities and Precautions

**Insecure HTTP Requests**:
---Issue: Requests made over HTTP rather than HTTPS could expose sensitive information.

---Precaution: The app enforces the use of HTTPS by checking the URL scheme and rejecting non-secure connections. ATS (App Transport Security) is also configured to block HTTP requests.

**Lack of SSL Pinning**:
---Issue: Without SSL pinning, the app is vulnerable to man-in-the-middle (MITM) attacks, where an attacker intercepts network traffic.

---Precaution: Implement SSL pinning to ensure that the app only communicates with trusted servers.

**No Timeout Configuration**:
---Issue: Without timeouts, network requests could hang indefinitely, leading to poor user experiences.

---Precaution: Configure appropriate timeout intervals in URLSession to ensure requests do not wait indefinitely.
