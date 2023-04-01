  // Citation for the following code:
  // Date: March 20, 2023
  // Adapted from nodejs-starter-app and modified to fit our project needs
  // Source URL: https://github.com/osu-cs340-ecampus/nodejs-starter-app




  function deleteItem(itemID) {
    // Put our data we want to send in a javascript object
    let data = {
        id: itemID
    };
  
    // Setup our AJAX request
    var xhttp = new XMLHttpRequest();
    xhttp.open("DELETE", "/delete-item/", true);
    xhttp.setRequestHeader("Content-type", "application/json");
  
    // Tell our AJAX request how to resolve
    xhttp.onreadystatechange = () => {
        if (xhttp.readyState == 4 && xhttp.status == 204) {
            // Add the new data to the table
            deleteRow(itemID);
            
        }
        else if (xhttp.readyState == 4 && xhttp.status != 204) {
            console.log("There was an error with the input.")
        }
    }
    // Send the request and wait for the response
    xhttp.send(JSON.stringify(data));
  }
  
  
  function deleteRow(itemID){
  
    let table = document.getElementById("items-table");
    for (let i = 0, row; row = table.rows[i]; i++) {
       //iterate through rows
       //rows would be accessed using the "row" variable assigned in the for loop
       if (table.rows[i].getAttribute("data-value") == itemID) {
            table.deleteRow(i);
  
            break;
       }
    }
  }