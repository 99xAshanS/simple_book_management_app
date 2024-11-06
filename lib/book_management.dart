import 'package:flutter/material.dart';

class Book {
  String title;
  String author;
  String isbn;
  String genre;

  Book(
      {required this.title,
      required this.author,
      required this.isbn,
      required this.genre});
}

class BookCollection {
  List<Book> books = [];

  void addBook(Book book) {
    books.add(book);
  }

  void removeBook(String isbn) {
    books.removeWhere((book) => book.isbn == isbn);
  }

  void editBook(String isbn, String title, String author, String genre) {
    for (var book in books) {
      if (book.isbn == isbn) {
        book.title = title;
        book.author = author;
        book.genre = genre;
      }
    }
  }

  List<Book> searchBooks(String query) {
    return books
        .where((book) =>
            book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<Book> filterBooks({String? genre}) {
    if (genre != null && genre.isNotEmpty) {
      return books.where((book) => book.genre.toLowerCase() == genre.toLowerCase()).toList();
    }
    return books;
  }
}

class BookManagementPage extends StatefulWidget {
  @override
  _BookManagementPageState createState() => _BookManagementPageState();
}

class _BookManagementPageState extends State<BookManagementPage> {
  final BookCollection collection = BookCollection();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController genreController = TextEditingController();

  late FocusNode titleFocusNode;
  late FocusNode authorFocusNode;
  late FocusNode isbnFocusNode;
  late FocusNode genreFocusNode;

  String searchQuery = "";
  String selectedGenre = "";

  @override
  void initState() {
    super.initState();
    titleFocusNode = FocusNode();
    authorFocusNode = FocusNode();
    isbnFocusNode = FocusNode();
    genreFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Management'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search your book by Title or Author',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            searchQuery = searchController.text;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedGenre.isNotEmpty ? selectedGenre : null,
                  hint: Text('Filter by Genre'),
                  items: [
                    DropdownMenuItem(value: '', child: Text('All Genres')),
                    ...collection.books.map((book) => book.genre).toSet().map((genre) =>
                        DropdownMenuItem(value: genre, child: Text(genre))).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedGenre = value ?? "";
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _getFilteredBooks().length,
              itemBuilder: (context, index) {
                final book = _getFilteredBooks()[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.indigo[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.book,
                        color: Colors.indigo,
                      ),
                    ),
                    title: Text(
                      book.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text("Author: ${book.author}"),
                        Text("ISBN: ${book.isbn}"),
                        Text("Genre: ${book.genre}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _showEditBookDialog(book);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red[400]),
                          onPressed: () {
                            setState(() {
                              collection.removeBook(book.isbn);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBookDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  List<Book> _getFilteredBooks() {
    List<Book> searchedBooks = collection.searchBooks(searchQuery);
    if (selectedGenre.isNotEmpty) {
      return searchedBooks.where((book) => book.genre.toLowerCase() == selectedGenre.toLowerCase()).toList();
    }
    return searchedBooks;
  }

  void _showAddBookDialog() {
    titleController.clear();
    authorController.clear();
    isbnController.clear();
    genreController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Book'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                focusNode: titleFocusNode,
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                focusNode: authorFocusNode,
                controller: authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
              TextField(
                focusNode: isbnFocusNode,
                controller: isbnController,
                decoration: InputDecoration(labelText: 'ISBN'),
              ),
              TextField(
                focusNode: genreFocusNode,
                controller: genreController,
                decoration: InputDecoration(labelText: 'Genre'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  collection.addBook(Book(
                    title: titleController.text,
                    author: authorController.text,
                    isbn: isbnController.text,
                    genre: genreController.text,
                  ));
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditBookDialog(Book book) {
    titleController.text = book.title;
    authorController.text = book.author;
    isbnController.text = book.isbn;
    genreController.text = book.genre;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Book'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                focusNode: titleFocusNode,
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                focusNode: authorFocusNode,
                controller: authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
              TextField(
                focusNode: genreFocusNode,
                controller: genreController,
                decoration: InputDecoration(labelText: 'Genre'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  collection.editBook(
                    book.isbn,
                    titleController.text,
                    authorController.text,
                    genreController.text,
                  );
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    titleController.dispose();
    authorController.dispose();
    isbnController.dispose();
    genreController.dispose();
    titleFocusNode.dispose();
    authorFocusNode.dispose();
    isbnFocusNode.dispose();
    genreFocusNode.dispose();
    super.dispose();
  }
}
