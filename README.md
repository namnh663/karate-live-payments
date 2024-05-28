# Karate Live Payments

`karate-live-payments` is a Java-based application that leverages the power of the Karate framework to test api services.

## Getting Started

These instructions will guide you on how to get a copy of the project up and running on your local machine for testing purposes.

### Prerequisites

Ensure you have the following installed on your local machine:

- Java 21.0.1
- Maven 3.9.5
- Extensions for VS Code (vscode-icons, Karate, Extension Pack for Java, GitLens — Git supercharged)

#### Setting the `JAVA_HOME` variable in Windows

1. Open "Edit environment variables for your account".
2. Under "User variables".
    - Click "New".
    - In the "Variable name" field, type `JAVA_HOME`.
    - In the "Variable value" field, enter the path to your Java installation directory (e.g., `C:\Users\NamNguyen\Downloads\jdk-21.0.1`).
    - Open `Path`.
    - Add new `%JAVA_HOME%\bin`.
    - Click "OK".
3. Click "OK" on all open windows to save the changes.

#### Setting the `mvn` variable in Windows

1. Open "Edit environment variables for your account".
2. Under "User variables".
    - Open `Path`.
    - Add new `%USERPROFILE%\Downloads\apache-maven-3.9.5\bin`.
    - Click "OK".
3. Click "OK" on all open windows to save the changes.

### Installation

Follow these steps to get a development environment running:

1. Clone the repository to your local machine
2. Navigate to the project directory
3. Run `mvn install` to install the necessary dependencies

## Running the Tests

Detailed instructions on how to run the automated tests for this system will be updated soon.

Execute the entire script:

```
mvn clean test
```

## Built With

- [Maven](https://maven.apache.org/) - Dependency Management
- [Karate](https://intuit.github.io/karate/) - Testing Framework for API Services

## Authors

- nam.nguyen@livepayments.com