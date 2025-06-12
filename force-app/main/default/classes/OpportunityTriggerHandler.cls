public with sharing class OpportunityTriggerHandler {
    /*
    * Question 5
    * Opportunity Trigger
    * When an opportunity is updated validate that the amount is greater than 5000.
    * Error Message: 'Opportunity amount must be greater than 5000'
    * Trigger should only fire on update.
    */
    public static void amountValidation(List<Opportunity> opps) {
        for(Opportunity opp: opps) {
            if(!(opp.Amount > 5000)) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }

    }
    /*
     * Question 6
	 * Opportunity Trigger
	 * When an opportunity is deleted prevent the deletion of a closed won opportunity if the account industry is 'Banking'.
	 * Error Message: 'Cannot delete closed opportunity for a banking account that is won'
	 * Trigger should only fire on delete.
	 */
    public static void deleteCloseWonOpportunity(List<Opportunity> opps) {

        Set<Id> accIds = new Set<Id>();
        for(Opportunity opp: opps) {
            if (opp.StageName == 'Closed Won') {
                accIds.add(opp.AccountId);
            }
        }

        Map<Id, Account> accIdToaccMap = new  Map<Id, Account>([SELECT Id, industry FROM Account WHERE Id IN :accIds]);
        for(Opportunity opp: opps) {
            if(opp.StageName == 'Closed Won' && accIdToaccMap.containsKey(opp.AccountId) && accIdToaccMap.get(opp.AccountId).Industry == 'Banking') {
                opp.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }

    }
    /*
    * Question 7
    * Opportunity Trigger
    * When an opportunity is updated set the primary contact on the opportunity to the contact on the same account with the title of 'CEO'.
    * Trigger should only fire on update.
    */
    public static void setPrimaryContact(List<Opportunity> opps) {
        Set<Id> acctIds = new Set<Id>();
        for(Opportunity opp : opps){
            if(opp.AccountId != null){
                acctIds.add(opp.AccountId);
            }
        }
        Map<id, Contact> accIdToContactMap = new  Map<id, Contact>();
        List<Contact> acctContactsList = [SELECT id, AccountId, Name, Title FROM Contact WHERE AccountId IN :acctIds];

        for(Contact con : acctContactsList){
            if(con.Title == 'CEO' && !accIdToContactMap.containsKey(con.AccountId)){
                accIdToContactMap.put(con.AccountId, con);
            }
        }
        for(Opportunity opp : opps){
            if(accIdToContactMap.containsKey(opp.AccountId)){
                opp.Primary_Contact__c = accIdToContactMap.get(opp.AccountId).Id;
            }
        }
    }
}