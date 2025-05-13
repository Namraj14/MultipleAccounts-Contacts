**Account and Contact Creation via REST API
**``**Overview**
This Salesforce Apex REST API allows the creation of multiple Accounts and their related Contacts in a single request using a structured wrapper class approach. This is particularly useful when working with external systems that need to push bulk data into Salesforce.

**Data Structure Explanation**
To efficiently send multiple Account and Contact records together, we use two nested wrapper classes:

1. AccountContactInfo (Inner Wrapper)
This class represents a single pair of related records:
One Account record
One Contact record (linked to the Account)

**Apex Class**
global class AccountContactInfo {
    global Account accRec { get; set; }
    global Contact contRec { get; set; }
}
2. AccountContactWrapper (Outer Wrapper)
This class wraps a list of AccountContactInfo objects, enabling us to send multiple record pairs in a single JSON request.

global class AccountContactWrapper {
    global List<AccountContactInfo> records { get; set; }
}

**💡 Why Two Wrappers?**
Salesforce REST services require the request body to map cleanly to Apex classes. Using this two-level wrapper:

Allows grouping multiple Account + Contact pairs

Ensures JSON deserialization works smoothly

Keeps your API design clean and scalable

**📥 Sample JSON Request Payload**
This is how the external system should send the data to your API:


{
  "records": [
    {
      "accRec": {
        "Name": "Acme Corp",
        "Industry": "Manufacturing"
      },
      "contRec": {
        "FirstName": "John",
        "LastName": "Doe",
        "Email": "john.doe@acme.com"
      }
    },
    {
      "accRec": {
        "Name": "Tech Innovators",
        "Industry": "Technology"
      },
      "contRec": {
        "FirstName": "Jane",
        "LastName": "Smith",
        "Email": "jane.smith@techinnovators.com"
      }
    }
  ]
}

**✅ Benefits of This Design**
Modular & Clean: Separates each Account-Contact pair logically
Easy to Map JSON: Cleanly maps complex JSON to Apex using wrapper structure
Bulk Operations: Supports multiple record creation in one API call
Scalable: Future-proof for adding more objects (e.g., Opportunities, Cases)
