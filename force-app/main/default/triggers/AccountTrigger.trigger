trigger AccountTrigger on Account (before insert, after insert) {

    //BEFORE_INSERT, BEFORE_UPDATE, BEFORE_DELETE,AFTER_INSERT, AFTER_UPDATE, AFTER_DELETE, and AFTER_UNDELETE
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            AccountTriggerHandler.setTypeProspect(Trigger.new);
            AccountTriggerHandler.addressCopy(Trigger.new);
            AccountTriggerHandler.setRating(Trigger.new);
        }  
        when AFTER_INSERT {
            AccountTriggerHandler.defaultContact(Trigger.new);
        }
    }
}

