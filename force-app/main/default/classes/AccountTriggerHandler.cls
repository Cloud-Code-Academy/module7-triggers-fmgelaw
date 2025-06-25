public with sharing class AccountTriggerHandler {
    /*
    * Question 1
    * Account Trigger
    * When an account is inserted change the account type to 'Prospect' if there is no value in the type field.
    * Trigger should only fire on insert.
    */
    public static void setTypeProspect(List<Account> accts) {
        for (Account acc : accts) {
            if (acc.Type == null) {
                acc.Type = 'Prospect';
            }
        }
    }
    /*
    * Question 2
    * Account Trigger
    * When an account is inserted copy the shipping address to the billing address.
    * BONUS: Check if the shipping fields are empty before copying.
    * Trigger should only fire on insert.
    */
    public static void addressCopy(List<Account> accts) {
        for(Account acc : accts) {
           // Boolean isBillingFieldsEmpty = String.isBlank(acc.BillingStreet) && String.isBlank(acc.BillingCity) && String.isBlank(acc.BillingState) 
                                     //&& String.isBlank(acc.BillingPostalCode) && String.isBlank(acc.BillingCountry);
            // check if each Shipping field was null before placing the value in the Billing field.
           // if(isBillingFieldsEmpty) {
                acc.BillingStreet     = String.isNotBlank(acc.ShippingStreet) ? acc.ShippingStreet: '';
                acc.BillingCity       = String.isNotBlank(acc.ShippingCity) ? acc.ShippingCity: '';
                acc.BillingState      = String.isNotBlank(acc.ShippingState) ? acc.ShippingState : '';
                acc.BillingPostalCode = String.isNotBlank(acc.ShippingPostalCode) ? acc.ShippingPostalCode : '';
                acc.BillingCountry    = String.isNotBlank(acc.ShippingCountry) ? acc.ShippingCountry: '';
           // }
        }
    }
    /*
    * Question 3
    * Account Trigger
	* When an account is inserted set the rating to 'Hot' if the Phone, Website, and Fax ALL have a value.
    * Trigger should only fire on insert.
    */
    public static void setRating(List<Account> accts) {
        for(Account acc : accts) {
            //Boolean isFieldsNotEmpty = !String.isBlank(acc.Phone) && !String.isBlank(acc.Website) && !String.isBlank(acc.Fax);
            //Check if the billing fields are empty before copying.
            if(String.isNotBlank(acc.Phone) && String.isNotBlank(acc.Website) && String.isNotBlank(acc.Fax)) {
                acc.Rating = 'Hot';
            }
        }
    }
    /*
    * Question 4
    * Account Trigger
    * When an account is inserted create a contact related to the account with the following default values:
    * LastName = 'DefaultContact'
    * Email = 'default@email.com'
    * Trigger should only fire on insert.
    */
    public static void defaultContact(List<Account> accts) {
        List<Contact> consToInsert = new List<Contact>();
        for(Account acc : accts) {
          // Contact con = new Contact(AccountId = acc.id, LastName = 'DefaultContact', Email = 'default@email.com');
           consToInsert.add(new Contact(
                AccountId = acc.id, 
                LastName = 'DefaultContact', 
                Email = 'default@email.com'));
        }
        //System.debug(JSON.serializePretty(conToInsert));
        insert consToInsert;
    }

}

    