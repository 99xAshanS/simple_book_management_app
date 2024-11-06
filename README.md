# simple_book_management_app

## Overview

The **SimpleBook Management Application** is a simple Flutter-based app that allows users to manage a collection of books. The application provides functionality for adding, editing, deleting, searching, and filtering books by different attributes like title, author, and genre. It is designed to be user-friendly and helps to keep track of a book collection efficiently.

## Features

- **Add Book**: Add new books to the collection with details like title, author, ISBN, and genre.
- **Edit Book**: Modify existing book information.
- **Delete Book**: Remove books from the collection.
- **Search Books**: Search by title or author to quickly locate books.
- **Filter by Genre**: Filter books based on genre for easy categorization.


## Getting Started

### Prerequisites

- **Flutter SDK**: Make sure you have Flutter installed. You can install it from [Flutter Installation Guide](https://flutter.dev/docs/get-started/install).
- **Android Studio or Xcode**: Required for running the app on emulators or physical devices.

### Installation

1. **Clone the Repository**
   ```sh
   git clone https://github.com/yourusername/book-management-app.git
   cd book-management-app
   ```

2. **Install Dependencies**
   - Navigate to the project directory and install dependencies using:
     ```sh
     flutter pub get
     ```

3. **Run the Application**
   - Connect a physical device or start an emulator.
   - Run the app using:
     ```sh
     flutter run
     ```

## Usage

1. **Add a New Book**: Click on the "+" floating action button to open a dialog for adding new books. Fill in the details and click "Add".
2. **Edit a Book**: Click on the edit icon next to the book you want to edit. Modify the details and click "Save".
3. **Delete a Book**: Click the delete icon to remove a book from the list.
4. **Search Books**: Use the search bar to search books by title or author.
5. **Filter by Genre**: Use the dropdown menu to filter the book list by genre.

## Project Structure

- **main.dart**: The entry point for the Flutter application, which initializes the `BookManagementPage`.
- **book_management_page.dart**: The main page for book management, containing all the UI and functionality for adding, editing, deleting, and searching books.
- **book.dart**: Contains the `Book` model and `BookCollection` class, which manages the collection of books.

## Dependencies

Ensure that the following dependencies are included in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
```

## Screenshots

![Home Screen](assets/home_screen.png)

![Add Book Dialog](assets/add_book_dialog.png)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contribution

Feel free to fork the repository and make changes. Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Contact

For any questions or suggestions, please contact me at **your-email@example.com**.

