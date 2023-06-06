# Invoice Form Server Side

This repository contains the code for an Invoice Form developed using ASPX and C# for server-side functionality. The form is designed for customers to place their orders and includes features such as auto-filling fields based on customer name code lookup from a SQL database. The orders table is dynamic, and users can search and add order items.

## Features

- **Customer Lookup**: Customers can search for their name code, and relevant information will be automatically filled in from the SQL database.
- **Dynamic Orders Table**: The orders table is dynamic, allowing customers to add multiple order items as needed.
- **Searchable Order Items**: Customers can search for specific order items, making it easier to add items to the invoice.
- **SQL Database Integration**: The form fetches data from an SQL database to populate customer information and perform efficient data retrieval and storage.

## Prerequisites

- Visual Studio (version X.X.X)
- ASP.NET
- C#
- SQL Server

## Installation

1. Clone the repository: `git clone https://github.com/BeastMasterGrinder/Invoice-Form-.NET.git`
2. Open the project in Visual Studio.
3. Configure the SQL database connection string in the web.config file.
4. Run the SQL scripts provided in the `database` folder to set up the necessary tables and data.
5. Build and run the project using Visual Studio.

## Usage

1. Access the form via a web browser.
2. Search for a customer by entering the name code.
3. The relevant customer details will be automatically filled in.
4. Add order items to the dynamic orders table by entering the item details.
5. Search for specific order items using the search functionality.
6. Complete the form and submit the invoice.

## Contributing

Contributions are welcome! If you find any bugs or have suggestions for improvements, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).
