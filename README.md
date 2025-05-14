# Library Management System Database

## Overview

This is a MySQL database schema for a Library Management System. It provides a structured set of tables to manage library resources, patrons, loans, fines, and reservations.

## Database Schema

The database consists of the following tables:

* **Patrons:** Stores information about library members.
* **Books:** Stores details about each book title.
* **Authors:** Stores information about book authors.
* **Book\_Authors:** A many-to-many relationship table linking Books and Authors.
* **Loans:** Tracks book loans to patrons.
* **Fines:** Stores information about fines incurred for overdue loans.
* **BookCopies:** Tracks individual copies of a book.
* **Reservations:** Stores the reservations made by patrons for the books.

## Table Details

### Patrons

| Column Name     | Data Type       | Constraints                     | Description                               |
| :-------------- | :-------------- | :------------------------------ | :---------------------------------------- |
| patron\_id      | INT             | AUTO\_INCREMENT, PRIMARY KEY    | Unique identifier for each patron       |
| first\_name    | VARCHAR(50)     | NOT NULL                        | First name of the patron                  |
| last\_name     | VARCHAR(50)     | NOT NULL                        | Last name of the patron                   |
| date\_of\_birth | DATE            | NOT NULL                        | Date of birth of the patron               |
| email           | VARCHAR(100)    | UNIQUE, NOT NULL                | Email address of the patron               |
| address         | VARCHAR(255)    |                                 | Address of the patron                     |
| phone\_number   | VARCHAR(20)     |                                 | Phone number of the patron                |
| membership\_date| DATE            | NOT NULL                        | Date when the patron became a member      |

### Books

| Column Name       | Data Type       | Constraints                     | Description                               |
| :---------------- | :-------------- | :------------------------------ | :---------------------------------------- |
| book\_id          | INT             | AUTO\_INCREMENT, PRIMARY KEY    | Unique identifier for each book         |
| title             | VARCHAR(255)    | NOT NULL                        | Title of the book                           |
| isbn              | VARCHAR(20)     | UNIQUE, NOT NULL                | ISBN of the book                            |
| publication\_date | DATE            |                                 | Date when the book was published          |
| publisher         | VARCHAR(100)    |                                 | Publisher of the book                       |
| edition           | VARCHAR(50)     |                                 | Edition of the book                         |
| category          | VARCHAR(100)    |                                 | Category of the book                        |

### Authors

| Column Name   | Data Type       | Constraints                     | Description                           |
| :------------ | :-------------- | :------------------------------ | :------------------------------------ |
| author\_id    | INT             | AUTO\_INCREMENT, PRIMARY KEY    | Unique identifier for each author    |
| first\_name  | VARCHAR(50)     | NOT NULL                        | First name of the author              |
| last\_name   | VARCHAR(50)     | NOT NULL                        | Last name of the author               |

### Book\_Authors

| Column Name | Data Type | Constraints             | Description                                                              |
| :---------- | :---------- | :---------------------- | :----------------------------------------------------------------------- |
| book\_id    | INT         | PRIMARY KEY, FOREIGN KEY | Foreign key referencing Books(book\_id)                                    |
| author\_id  | INT         | PRIMARY KEY, FOREIGN KEY | Foreign key referencing Authors(author\_id)                                  |

### Loans

| Column Name   | Data Type | Constraints                     | Description                                                                                             |
| :------------ | :---------- | :------------------------------ | :------------------------------------------------------------------------------------------------------ |
| loan\_id      | INT         | AUTO\_INCREMENT, PRIMARY KEY    | Unique identifier for each loan                                                                       |
| patron\_id    | INT         | FOREIGN KEY                       | Foreign key referencing Patrons(patron\_id)                                                               |
| book\_id      | INT         | FOREIGN KEY                       | Foreign key referencing Books(book\_id)                                                                 |
| loan\_date    | DATE        | NOT NULL                        | Date when the book was loaned                                                                         |
| return\_date   | DATE        |                                 | Date when the book was returned                                                                         |
| due\_date    | DATE        | NOT NULL                        | Date when the book is due                                                                           |
|               |             | CHECK                           | return\_date must be greater than or equal to loan\_date                                                |

### Fines

| Column Name   | Data Type       | Constraints                     | Description                                            |
| :------------ | :-------------- | :------------------------------ | :----------------------------------------------------- |
| fine\_id      | INT             | AUTO\_INCREMENT, PRIMARY KEY    | Unique identifier for each fine                        |
| loan\_id      | INT             | FOREIGN KEY                       | Foreign key referencing Loans(loan\_id)                  |
| fine\_amount  | DECIMAL(10, 2)  | NOT NULL, CHECK                 | Amount of the fine (must be >= 0)                       |
| payment\_date | DATE            |                                 | Date when the fine was paid                             |

### BookCopies

| Column Name     | Data Type       | Constraints                     | Description                                                              |
| :-------------- | :-------------- | :------------------------------ | :----------------------------------------------------------------------- |
| copy\_id        | INT             | AUTO\_INCREMENT, PRIMARY KEY    | Unique identifier for each book copy                                     |
| book\_id        | INT             | FOREIGN KEY                       | Foreign key referencing Books(book\_id)                                    |
| acquisition\_date | DATE            | NOT NULL                        | Date when the book copy was acquired                                     |
| condition       | VARCHAR(50)     | NOT NULL, CHECK                 | Condition of the book copy (e.g., "New", "Good", "Damaged", "Poor")   |
| is\_available    | BOOLEAN         | DEFAULT TRUE                      | Indicates if the book copy is currently available for loan             |

### Reservations

| Column Name     | Data Type       | Constraints                     | Description                                                                      |
| :-------------- | :-------------- | :------------------------------ | :------------------------------------------------------------------------------- |
| reservation\_id | INT             | AUTO\_INCREMENT, PRIMARY KEY    | Unique identifier for each reservation                                           |
| patron\_id      | INT             | FOREIGN KEY                       | Foreign key referencing Patrons(patron\_id)                                        |
| book\_id        | INT             | FOREIGN KEY                       | Foreign key referencing Books(book\_id)                                          |
| reservation\_date | DATETIME      | NOT NULL                        | Date and time when the reservation was made                                      |
| status          | VARCHAR(20)     | NOT NULL, CHECK                 | Status of the reservation (e.g., "Pending", "Active", "Cancelled", "Fulfilled") |

## Relationships

* A Patron can have many Loans.
* A Book can have many Loans.
* A Book can have many Authors, and an Author can have many Books (through the Book\_Authors table).
* A Book can have many BookCopies.
* A Patron can make many Reservations.
* A Book can have many Reservations.
* A Loan can have one Fine.

## ER Diagram

![Library Management System ER Diagram](libraryerd.png)

*The above diagram illustrates the relationships between the tables in the database schema.*

## Installation

1.  Ensure you have MySQL installed.
2.  Create a database named `library_management_system` (or you can change the name in the script).
3.  Execute the SQL script (found in `library_management_system.sql`) to create the tables and relationships.

## Usage

This database schema can be used to manage the core functions of a library, including:

* Managing patron information
* Cataloging books and authors
* Tracking book copies and their availability
* Managing the loaning and returning of books
* Recording fines for overdue books
* Handling book reservations

## Contributing

Contributions to improve the schema or add new features are welcome. Please submit a pull request with your proposed changes.
