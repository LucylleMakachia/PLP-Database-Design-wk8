-- Database Creation and Selection
-- Create the database (if it doesn't exist)
CREATE DATABASE IF NOT EXISTS library_management_system;

-- Select the database to use
USE library_management_system;

-- Table Creation: Patrons

CREATE TABLE Patrons (
    patron_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(20),
    membership_date DATE NOT NULL
);

-- Table Creation: Books

CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_date DATE,
    publisher VARCHAR(100),
    edition VARCHAR(50),
    category VARCHAR(100)
);

-- Table Creation: Authors

CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- Table Creation: Book_Authors (Many-to-Many Relationship)

CREATE TABLE Book_Authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Table Creation: Loans

CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    patron_id INT,
    book_id INT,
    loan_date DATE NOT NULL,
    return_date DATE,
    due_date DATE NOT NULL,
    FOREIGN KEY (patron_id) REFERENCES Patrons(patron_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    CONSTRAINT CHK_ReturnDate CHECK (return_date IS NULL OR return_date >= loan_date)
);

-- Table Creation: Fines

CREATE TABLE Fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT,
    fine_amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE,
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id),
    CONSTRAINT CHK_FineAmount CHECK (fine_amount >= 0)
);

-- Table Creation: BookCopies

CREATE TABLE BookCopies (
    copy_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    acquisition_date DATE NOT NULL,
    condition VARCHAR(50) NOT NULL,  -- e.g., "New", "Good", "Damaged"
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
     CONSTRAINT CHK_Condition CHECK (condition IN ('New', 'Good', 'Damaged', 'Poor'))
);

-- Table Creation: Reservations

CREATE TABLE Reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    patron_id INT,
    book_id INT,
    reservation_date DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL, -- e.g., "Pending", "Active", "Cancelled", "Fulfilled"
    FOREIGN KEY (patron_id) REFERENCES Patrons(patron_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    CONSTRAINT CHK_Status CHECK (status IN ('Pending', 'Active', 'Cancelled', 'Fulfilled'))
);
