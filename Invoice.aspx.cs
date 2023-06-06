using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;


public partial class Invoice : System.Web.UI.Page
{

    public class OrderDetail
    {
        public string pr_code { get; set; }
        public int qty { get; set; }
        public int bonus { get; set; }
        public decimal price { get; set; }
        public decimal per { get; set; }
        public decimal qdis { get; set; }
        public decimal total { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        /*if (IsPostBack)
        {
            string selectedOrderNumber = Request.Form["selectedOrderNumber"];

            if (!string.IsNullOrEmpty(selectedOrderNumber))
            {
                List<OrderDetail> orderDetails = RetrieveOrderDetails(selectedOrderNumber);

                // Populate the dynamic table with the retrieved data
                PopulateDynamicTable(orderDetails);
            }
        }*/

        //Show Names
        string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        using(SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT ct_name, ct_code, phone1, addr, con_per FROM customer";
            string query2 = "SELECT pr_name, pr_code, cost_price FROM product";
            string query3 = "SELECT ord_no, ct_code, ord_amt from ord";
            //For Name Drop Down
            SqlCommand command = new SqlCommand(query, connection);
            //command.Parameters.AddWithValue("@employeeid", Session["EmployeeID"]);
            connection.Open();
            //only single row is expected
            SqlDataReader reader = command.ExecuteReader();
            //store data in a datatable
            System.Data.DataTable Customer = new System.Data.DataTable();
            Customer.Load(reader);
            //bind data to the repeater
            Repeater1.DataSource = Customer;
            Repeater1.DataBind();
            reader.Close();
            connection.Close();

            //For Product Drop Down
            SqlCommand command2 = new SqlCommand(query2, connection);
            //command.Parameters.AddWithValue("@employeeid", Session["EmployeeID"]);
            connection.Open();
            //only single row is expected
            SqlDataReader reader2 = command2.ExecuteReader();
            //store data in a datatable
            System.Data.DataTable Product = new System.Data.DataTable();
            Product.Load(reader2);
            //bind data to the repeater
            Repeater2.DataSource = Product;
            Repeater2.DataBind();
            reader2.Close();

            connection.Close();
            SqlCommand command3 = new SqlCommand(query3, connection);
            connection.Open();
            SqlDataReader reader3 = command3.ExecuteReader();
            System.Data.DataTable Order = new System.Data.DataTable();
            Order.Load(reader3);
            Repeater3.DataSource = Order;
            Repeater3.DataBind(); reader3.Close();
        }
    }

    /*protected void OrderSelector_SelectedIndexChanged(object sender, EventArgs e)
    {

        string selectedOrderNo = OrderSelector.SelectedValue;

        // Assuming you have a connection string named "ConnectionString" in your web.config file
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        // Create a SQL connection
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            // Define the SQL query to retrieve the ord_deta content for the selected order number
            string query = "SELECT * FROM ord_deta WHERE ord_no = @OrderNo";

            // Create a SQL command
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                // Set the parameter value for the order number
                command.Parameters.AddWithValue("@OrderNo", selectedOrderNo);

                // Open the connection
                connection.Open();

                // Execute the SQL command and retrieve the data
                SqlDataReader reader = command.ExecuteReader();

                // Process the retrieved data
                if (reader.Read())
                {
                    // Access the individual columns from the ord_deta table
                    string prCode = reader["pr_code"].ToString();
                    int quantity = Convert.ToInt32(reader["qty"]);
                    int bonus = Convert.ToInt32(reader["bonus"]);
                    decimal price = Convert.ToDecimal(reader["price"]);
                    decimal discount = Convert.ToDecimal(reader["qdis"]);
                    decimal total = Convert.ToDecimal(reader["total"]);
                    string userId = reader["u_id"].ToString();

                    // Do whatever you need to do with the retrieved values
                    // For example, store them in variables, display them on the page, etc.
                }

                // Close the data reader and the connection
                reader.Close();
                connection.Close();
            }
        }
    }

    private List<OrderDetail> RetrieveOrderDetails(string orderNumber)
    {
        string connectionString = "your_connection_string";
        List<OrderDetail> orderDetails = new List<OrderDetail>();

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();

            string sql = "SELECT pr_code, qty, bonus, price, per, qdis, total FROM ord_deta WHERE ord_no = @ord_no";

            using (SqlCommand command = new SqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@ord_no", orderNumber);

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        OrderDetail orderDetail = new OrderDetail();
                        orderDetail.pr_code = reader.GetString(0);
                        orderDetail.qty = reader.GetInt32(1);
                        orderDetail.bonus = reader.GetInt32(2);
                        orderDetail.price = reader.GetDecimal(3);
                        orderDetail.per = reader.GetDecimal(4);
                        orderDetail.qdis = reader.GetDecimal(5);
                        orderDetail.total = reader.GetDecimal(6);
                        orderDetails.Add(orderDetail);
                    }
                }
            }
        }

        return orderDetails;
    }



    private void PopulateDynamicTable(List<OrderDetail> orderDetails)
    {
        // Assuming you have a placeholder for the dynamic table in your ASPX markup with the ID "dynamicTable"
        Table dynamicTable = (Table)FindControl("dynamicTable");

        // Clear existing rows from the dynamic table
        dynamicTable.Rows.Clear();

        // Add header row
        TableRow headerRow = new TableRow();
        // Add header cells
        headerRow.Cells.Add(new TableCell { Text = "Serial No" });
        headerRow.Cells.Add(new TableCell { Text = "Product Code" });
        headerRow.Cells.Add(new TableCell { Text = "Quantity" });
        headerRow.Cells.Add(new TableCell { Text = "Bonus" });
        headerRow.Cells.Add(new TableCell { Text = "Price" });
        headerRow.Cells.Add(new TableCell { Text = "Percentage" });
        headerRow.Cells.Add(new TableCell { Text = "Quantity Discount" });
        headerRow.Cells.Add(new TableCell { Text = "Total" });
        // Add header row to the dynamic table
        dynamicTable.Rows.Add(headerRow);

        // Iterate through the order details and create table rows dynamically
        for (int i = 0; i < orderDetails.Count; i++)
        {
            TableRow dataRow = new TableRow();

            // Add serial number cell
            TableCell serialNoCell = new TableCell();
            int serialNo = i + 1;
            serialNoCell.Controls.Add(new Label { Text = serialNo.ToString() });
            dataRow.Cells.Add(serialNoCell);

            // Add product code cell
            TableCell productCodeCell = new TableCell();
            productCodeCell.Text = orderDetails[i].pr_code;
            dataRow.Cells.Add(productCodeCell);

            // Add quantity cell
            TableCell quantityCell = new TableCell();
            TextBox quantityTextBox = new TextBox
            {
                ID = "quantityTable_" + i,
                CssClass = "form-control",
                Text = orderDetails[i].qty.ToString(),
                AutoPostBack = true
            };
            quantityTextBox.TextChanged += QuantityTextBox_TextChanged; // Assign the event handler for quantity change
            quantityCell.Controls.Add(quantityTextBox);
            dataRow.Cells.Add(quantityCell);

            // Add bonus cell
            TableCell bonusCell = new TableCell();
            TextBox bonusTextBox = new TextBox
            {
                ID = "bonusTable_" + i,
                CssClass = "form-control",
                Text = orderDetails[i].bonus.ToString()
            };
            bonusCell.Controls.Add(bonusTextBox);
            dataRow.Cells.Add(bonusCell);

            // Add price cell
            TableCell priceCell = new TableCell();
            TextBox priceTextBox = new TextBox
            {
                ID = "priceTable_" + i,
                CssClass = "form-control",
                Text = orderDetails[i].price.ToString()
            };
            priceCell.Controls.Add(priceTextBox);
            dataRow.Cells.Add(priceCell);

            // Add percentage cell
            TableCell percentageCell = new TableCell();
            TextBox percentageTextBox = new TextBox
            {
                ID = "percentageTable_" + i,
                CssClass = "form-control",
                Text = orderDetails[i].per.ToString()
            };
            percentageCell.Controls.Add(percentageTextBox);
            dataRow.Cells.Add(percentageCell);

            // Add quantity discount cell
            TableCell quantityDiscountCell = new TableCell();
            TextBox quantityDiscountTextBox = new TextBox
            {
                ID = "discountTable_" + i,
                CssClass = "form-control",
                Text = orderDetails[i].qdis.ToString()
            };
            quantityDiscountCell.Controls.Add(quantityDiscountTextBox);
            dataRow.Cells.Add(quantityDiscountCell);

            // Add total cell
            TableCell totalCell = new TableCell();
            TextBox totalTextBox = new TextBox
            {
                ID = "totalTable_" + i,
                CssClass = "form-control",
                Text = orderDetails[i].total.ToString()
            };
            totalCell.Controls.Add(totalTextBox);
            dataRow.Cells.Add(totalCell);

            // Add data row to the dynamic table
            dynamicTable.Rows.Add(dataRow);
        }
    }



    protected void QuantityTextBox_TextChanged(object sender, EventArgs e)
    {
        TextBox quantityTextBox = (TextBox)sender;
        TableCell parentCell = (TableCell)quantityTextBox.Parent;
        TableRow parentRow = (TableRow)parentCell.Parent;
        //int rowIndex = parentRow.RowIndex;
        // Retrieve the other controls in the same row using the rowIndex
        // Update the corresponding data or perform any necessary calculations
        // You can use the FindControl method to locate the other controls by their IDs
    }


    private void UpdateOrderDetail(string orderNumber, string prCode)
    {
        string connectionString = "your_connection_string";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();

            string sql = "UPDATE ord_deta SET qty = @qty, bonus = @bonus, price = @price, per = @per, qdis = @qdis, total = @total WHERE ord_no = @ord_no AND pr_code = @pr_code";

            // Assuming you have the updated values available, you can replace the parameter values below accordingly
            int qty = 10;
            int bonus = 5;
            decimal price = 19.99m;
            decimal per = 0.1m;
            decimal qdis = 5.0m;
            decimal total = 199.99m;

            using (SqlCommand command = new SqlCommand(sql, connection))
            {
                command.Parameters.AddWithValue("@qty", qty);
                command.Parameters.AddWithValue("@bonus", bonus);
                command.Parameters.AddWithValue("@price", price);
                command.Parameters.AddWithValue("@per", per);
                command.Parameters.AddWithValue("@qdis", qdis);
                command.Parameters.AddWithValue("@total", total);
                command.Parameters.AddWithValue("@ord_no", orderNumber);
                command.Parameters.AddWithValue("@pr_code", prCode);

                command.ExecuteNonQuery();
            }
        }
    }

*/

    //Save button



    protected void SaveCotent(object sender, EventArgs e)
    {
        try
        {
            string[] productNames = Request.Form.GetValues("productName[]");
            string[] productCodes = Request.Form.GetValues("ProductCode[]");
            string[] quantities = Request.Form.GetValues("quantity[]");
            string[] bonuses = Request.Form.GetValues("bonus[]");
            string[] prices = Request.Form.GetValues("price[]");
            string[] percentages = Request.Form.GetValues("percentage[]");
            string[] discounts = Request.Form.GetValues("quantityDiscount[]");
            string[] taxes = Request.Form.GetValues("tax[]");
            string[] fixTaxes = Request.Form.GetValues("fixTax[]");
            string[] totalItems = Request.Form.GetValues("totalItem[]");



            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlTransaction transaction = connection.BeginTransaction();

                try
                {
                    // Generate dynamic ord_no
                    string ordNoQuery = "SELECT MAX(ord_no) FROM ord";
                    SqlCommand ordNoCommand = new SqlCommand(ordNoQuery, connection, transaction);
                    object result = ordNoCommand.ExecuteScalar();
                    int ordNo = result != DBNull.Value ? Convert.ToInt32(result) + 1 : 1;

                    // Save data to the ord table
                    string ordQuery = "INSERT INTO ord (ord_no, ct_code, ord_amt, date, time, u_id, remarks) VALUES (@ord_no, @ct_code, @ord_amt, @date, @time, @user_id, @remarks1)";
                    SqlCommand ordCommand = new SqlCommand(ordQuery, connection, transaction);
                    ordCommand.Parameters.AddWithValue("@ord_no", ordNo.ToString());
                    ordCommand.Parameters.AddWithValue("@ct_code", Customer_code.Text);
                    ordCommand.Parameters.AddWithValue("@ord_amt", txtTotal.Text);
                    ordCommand.Parameters.AddWithValue("@date", DateTime.Today);
                    ordCommand.Parameters.AddWithValue("@time", DateTime.Now.TimeOfDay);
                    ordCommand.Parameters.AddWithValue("@user_id", Customer_code.Text);
                    ordCommand.Parameters.AddWithValue("@remarks1", txtRemarks.Text);
                    ordCommand.ExecuteNonQuery();


                    

                    string sql = "INSERT INTO ord_deta (ord_no, pr_code, qty, bonus, price, per, qdis, total, u_id) VALUES (@ord_no, @pr_code, @qty, @bonus, @price, @per, @qdis, @total, @u_id)";

                    // Create the SqlCommand object
                    using (SqlCommand command1 = new SqlCommand(sql, connection))
                    {
                        // Add parameters and execute the command1 for each row
                        for (int i = 0; i < productNames.Length; i++)
                        {
                            command1.Parameters.Clear();
                            command1.Parameters.AddWithValue("@ord_no", ordNo.ToString()); // Replace with the actual ord_no value
                            command1.Parameters.AddWithValue("@pr_code", productCodes[i]);
                            command1.Parameters.AddWithValue("@qty", int.Parse(quantities[i]));
                            command1.Parameters.AddWithValue("@bonus", int.Parse(bonuses[i]));
                            command1.Parameters.AddWithValue("@price", prices[i]);
                            command1.Parameters.AddWithValue("@per", int.Parse(percentages[i].Replace("%", "")));
                            command1.Parameters.AddWithValue("@qdis", discounts[i]);
                            command1.Parameters.AddWithValue("@total", totalItems[i]);
                            command1.Parameters.AddWithValue("@u_id", Customer_code.Text); // Replace with the actual u_id value

                            // Execute the command1
                            command1.Transaction = transaction;
                            command1.ExecuteNonQuery();
                        }
                    }

                            transaction.Commit();
                    connection.Close();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    throw ex;
                }
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }


}