<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Invoice.aspx.cs" Inherits="Invoice" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <%-- <head runat="server">--%>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,700" rel="stylesheet" />

    <!-- Bootstrap CSS -->
     <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
      integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
      crossorigin="anonymous"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css"
      integrity="sha512-..."
      crossorigin="anonymous"
    />
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"
      integrity="sha512-..."
      crossorigin="anonymous"
    ></script>

    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

    <!--Custom CSS-->
    <style>
      h2 {
        text-align: center;
        font-size: 3em;
      }
      body{
        background-color: #7C7287;
      }
      form{
        background-color: #9DC0BC;
        padding: 20px;
        border-radius: 10px;
        margin: 4em;
      }
      select{
          padding: 4em;
      }
    </style>

    <title>Invoice</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
      <h2>Invoice</h2>
      
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label for="Date">Date:</label>
              <input type="date" class="form-control pt-2" id="Date" />
            </div>
          </div>

          <div class="col-md-6">
            <div class="form-group">
              <label for="Name">Name: </label>
              <select name="NamesList" id="NamesSelecter" class="form-control form-select-lg mb-3 js-example-basic-single select2" style="padding: 5rem;" aria-label=".form-select-lg example">
                <option selected value="-1">Select Name</option>
                <asp:Repeater ID="Repeater1" runat="server">
                  <ItemTemplate>
                    <option value="<%# Eval("ct_name") %>" data-address="<%# Eval("addr") %>"data-phone="<%# Eval("phone1") %> "data-ctcode="<%# Eval("ct_code") %>"data-po-number="<%# Eval("con_per") %>" ><%# Eval("ct_code") %> <%# Eval("ct_name") %> <%# Eval("addr") %></option>
                  </ItemTemplate>
                </asp:Repeater>
              </select>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label for="Address">Address: </label>
              <input type="text" class="form-control" id="Address" />
            </div>
          </div>

          <div class="col-md-6">
            <label for="Phone">Phone: </label>
            <input type="text" class="form-control" id="Phone" />
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label for="Customer_code">PO Number</label>
              <asp:TextBox runat="server" class="form-control" id="Customer_code"></asp:TextBox>
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label for="txtRemarks">Remarks</label>
                <asp:TextBox runat="server" class="form-control" id="txtRemarks"></asp:TextBox>
            </div>
          </div>
        </div>
        <div class="row">
            <div class="form-group">
              <select name="OrderSelect123" id="OrderSelector" class="form-control form-select-lg mb-3 js-example-basic-single select2" style="padding: 5rem;" aria-label=".form-select-lg example" >
                <option selected value="-1">Select Order No.</option>
                <asp:Repeater ID="Repeater3" runat="server">
                  <ItemTemplate>
                    <option value="<%# Eval("ord_no") %>" data-ordno="<%# Eval("ord_no") %>" ><%# Eval("ord_no") %></option>
                  </ItemTemplate>
                </asp:Repeater>
              </select>
            </div>
        </div>
        <h4>Items:</h4>
        <asp:Table class="table" runat="server" ID="table1">
            <asp:TableHeaderRow >
            
              <asp:TableCell>Serial No.</asp:TableCell>
              <asp:TableCell>Product Name</asp:TableCell>
              <asp:TableCell>Product Code</asp:TableCell>              
              <asp:TableCell >Quantity</asp:TableCell>
              <asp:TableCell >Bonus</asp:TableCell>
              <asp:TableCell>Price</asp:TableCell>
              <asp:TableCell>Percentage</asp:TableCell>
              <asp:TableCell >Quantity Discount</asp:TableCell>
              <asp:TableCell>Tax</asp:TableCell>
              <asp:TableCell>Fix Tax</asp:TableCell>
              <asp:TableCell >Total item</asp:TableCell>
            
          </asp:TableHeaderRow>
          <asp:TableFooterRow>
             <asp:TableCell ColumnSpan="9" class="text-end">Total:</asp:TableCell>
             <asp:TableCell>
                <asp:TextBox ID="txtTotal" runat="server" class="form-control" value="0"></asp:TextBox>
             </asp:TableCell>
          </asp:TableFooterRow>
        </asp:Table>
        <button type="button" class="btn btn-primary" id="AddRow" onclick="addRow()">
          Add New Row
        </button>
        <asp:LinkButton ID="SaveCourse" type="submit" class="btn btn-success btn-lg" runat="server" onclick="SaveCotent">Save</asp:LinkButton>
      
    </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

        <script>

            function addRow() {
                var table = document.getElementById('<%= table1.ClientID %>');

                var row = table.insertRow(table.rows.length - 1);

                var cell1 = row.insertCell();
                var serialNo = table.rows.length - 2; // Increment serial number based on the current row count
                cell1.innerHTML = '<span>' + serialNo + '</span>'; // Display serial number as a span


                var cell2 = row.insertCell();
                cell2.innerHTML = `
    <select name="productName[]" class="form-control form-select-lg mb-3 js-example-basic-single select2" style="width: 100px; height: 60px;" aria-label=".form-select-lg example" id="ProductSelector" onchange="fillPrice(this); addRow()">
        <option selected value="-1">Select Product</option>
        <asp:Repeater ID="Repeater2" runat="server">
            <ItemTemplate>
                <option value='<%# Eval("pr_name") %>' data-prcode='<%# Eval("pr_code") %>' data-price='<%# Eval("cost_price") %>'><%# Eval("pr_code") %> <%# Eval("pr_name") %></option>
            </ItemTemplate>
        </asp:Repeater>
    </select>`;

                var selectElement = cell2.querySelector('select[name="productName[]"]');
                $(selectElement).select2();
//pr_name, pr_code, cost_price  
                
                var cell3 = row.insertCell();
                cell3.innerHTML = '<input type="text"  class="form-control" id="PrCodeTable" name="ProductCode[]" />'; 

                //pr_name, pr_code, cost_price
                // Add more cells as needed for other columns
                var cell4 = row.insertCell();
                cell4.innerHTML = '<input type="text" class="form-control" id="quantityTable" name="quantity[]" onchange="calculateTotalItem(this.parentNode.parentNode)" />';
                var cell5 = row.insertCell();
                cell5.innerHTML = '<input type="text" class="form-control" id="bonusTable" value="0" name="bonus[]" />';
                var cell6 = row.insertCell();
                cell6.innerHTML = '<input type="text" class="form-control" id="priceTable" name="price[]" />';
                var cell7 = row.insertCell();
                cell7.innerHTML = '<input type="text" class="form-control" id="percentageTable" name="percentage[]" value="10%" />';
                var cell8 = row.insertCell();
                cell8.innerHTML = '<input type="text" class="form-control" id="discountTable" name="quantityDiscount[]" value="1" />';
                var cell9 = row.insertCell();
                cell9.innerHTML = '<input type="text" class="form-control" name="tax[]" value="17" />';
                var cell10 = row.insertCell();
                cell10.innerHTML = '<input type="text" class="form-control" name="fixTax[]" value="17" />';
                var cell11 = row.insertCell();
                cell11.innerHTML = '<input type="text" class="form-control" id="item_total" name="totalItem[]" />';

                var cellDelete = row.insertCell();
                cellDelete.innerHTML = '<button type="button" class="btn btn-danger" onclick="deleteRow(this)">X</button>';
                
                

            }

            function fillPrice(selectElement) {
                var selectedOption = selectElement.options[selectElement.selectedIndex];
                var price = selectedOption.getAttribute('data-price');
                var productCode = selectedOption.getAttribute('data-prcode');
                var row = selectElement.parentNode.parentNode;
                var priceInput = row.querySelector('input[name="price[]"]');
                priceInput.value = price;
                var productCodeInput = row.querySelector('input[name="ProductCode[]"]');
                productCodeInput.value = productCode;

                calculateTotalItem(row);   
            }

            function calculateTotalItem(row) {
                var quantityInput = row.cells[3].querySelector('input[name="quantity[]"]');
                var quantity = parseInt(quantityInput.value) || 0;
                
                var price = parseFloat(row.cells[5].querySelector('input[name="price[]"]').value) || 0;
                var tax = parseFloat(row.cells[8].querySelector('input[name="tax[]"]').value) || 0;
                var bonus = parseFloat(row.cells[4].querySelector('input[name="bonus[]"]').value) || 0;
                var percentage = (quantity > 3) ? 0.1 : 0;

                var totalItemInput = row.querySelector('input[name="totalItem[]"]');

                if (quantity === 0) {
                    totalItemInput.value = 0;
                } else {
                    var totalItem = (quantity * price * (1 + tax / 100)) + bonus;
                    var quantityDiscount = totalItem * percentage;
                    var itemTotal = totalItem - quantityDiscount;

                    row.cells[7].querySelector('input[name="quantityDiscount[]"]').value = quantityDiscount.toFixed(2);
                    row.cells[10].querySelector('input[name="totalItem[]"]').value = itemTotal.toFixed(2);
                    totalItemInput.value = itemTotal.toFixed(2);
                }

                calculateGrandTotal();
            }

            function calculateGrandTotal() {
                var table = document.getElementById('<%= table1.ClientID %>');
                  var rows = table.getElementsByTagName('tr');
                  var grandTotal = 0;

                  // Iterate through all rows (excluding header and footer)
                  for (var i = 1; i < rows.length - 1; i++) {
                    var row = rows[i];

                    // Get the value of the total item input field for the current row
                    var totalItemInput = row.querySelector('input[name="totalItem[]"]');
                    var totalItemValue = parseFloat(totalItemInput.value) || 0;

                    // Add the total item value to the grand total
                    grandTotal += totalItemValue;
                  }

                  // Update the value of the txtTotal TextBox with the grand total
                var txtTotal = document.getElementById('<%= txtTotal.ClientID %>');
                txtTotal.value = grandTotal.toFixed(2);
            }
            function deleteRow(button) {
                var row = button.parentNode.parentNode;
                row.parentNode.removeChild(row);

                // Recalculate the grand total after deleting the row
                calculateGrandTotal();
            }

            $(document).ready(function () {
                $('#NamesSelecter').on('change', function () {
                    var selectedOption = $(this).find(':selected');
                    var address = selectedOption.data('address');
                    var phone = selectedOption.data('phone');
                    var ct_code = selectedOption.data('ctcode');
                    

                    $('#Address').val(address);
                    $('#Phone').val(phone);
                    $('#Customer_code').val(ct_code);
                });
                
            });

            $(document).ready(function () {
                $('.js-example-basic-single').select2();
            });
            $(document).ready(function () {
                $('#ProductSelector').select2
            });

        </script>
    </form>
</body>
</html>
