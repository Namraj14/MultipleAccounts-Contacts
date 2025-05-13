@RestResource(urlMapping = '/multipleAccountsContacts/*')

global class AccountContactMgmt {
    
    @HttpPost
    global static String createMultipleAccounts(AccountContactWrapper inputWrapper){
        try{
            for (AccountContactInfo record : inputWrapper.records) {
                Account accRecord = record.accountRecord;
                insert accRecord;

                record.contactRecord.AccountId = accRecord.Id;
                insert record.contactRecord;
                
            }
            return 'All Accounts and Contacts are Successfully Created';
        } catch (Exception e){
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