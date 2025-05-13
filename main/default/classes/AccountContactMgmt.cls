@RestResource(urlMapping = '/multipleAccountsContacts/*')

global class AccountContactMgmt {
    
    @HttpPost
    global static String createMultipleAccounts() {
        RestRequest req = RestContext.request;
        String jsonBody = req.requestBody.toString();
        AccountContactWrapper inputWrapper = (AccountContactWrapper) JSON.deserialize(jsonBody, AccountContactWrapper.class);
    
        try {
            for (AccountContactInfo record : inputWrapper.records) {
                insert record.accountRecord;
                record.contactRecord.AccountId = record.accountRecord.Id;
                insert record.contactRecord;
            }
            return 'All Accounts and Contacts are Successfully Created';
        } catch (Exception e) {
            return e.getMessage();
        }
    }
    global class AccountContactWrapper{
        global List<AccountContactInfo> records {get;set;}
    }
    global class AccountContactInfo {
        global Account accountRecord {get;set;}
        global Contact contactRecord {get;set;}       
    
    }
}