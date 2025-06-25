trigger OpportunityTrigger on Opportunity (before update, before delete) {
    //BEFORE_INSERT, BEFORE_UPDATE, BEFORE_DELETE,AFTER_INSERT, AFTER_UPDATE, AFTER_DELETE, and AFTER_UNDELETE

    switch on Trigger.operationType {
        when BEFORE_UPDATE {
             OpportunityTriggerHandler.amountValidation(Trigger.new);
             OpportunityTriggerHandler.setPrimaryContact(Trigger.new);
        } 
        when BEFORE_DELETE {
             OpportunityTriggerHandler.deleteCloseWonOpportunity(Trigger.old);
        } 
    }
}