/* (A) MAF1.6 Update Format list detail when store creation [After-Insert trigger.]
 * (B) MAF1.5 Update Country list detail when store / Web / DC creation [on After-Update trigger]
 * (C) MAF15.5 Update Country detail list when status begin open [on After-Update trigger]
 * (D) MAF21.2 List can't be close if active contract (before update) [on Before-Update trigger]
 * (E) MAF16.2 Close Country will close all linked Stores / DC / Web / List
 * (F) MAF17.1 Country can change his allocation country zone if no contract as been defined to its country zone
 */

trigger Trg_Org_Orga_BU on Orga_BU__c (after insert, after update, before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            // Static method to handle (A) procedure.
            Trg_Org_Orga_BU_Handler.OnBeforeInsert(Trigger.new);
        }
        if(Trigger.isUpdate){
            // Static method to handle (D) (E) (F) procedures.
            Trg_Org_Orga_BU_Handler.OnBeforeUpdate(Trigger.new, Trigger.OldMap);
        }
        // Fill Country Reference Field From Country_List__c
        Trg_Org_Orga_BU_Handler.OnBeforeInsertOrUpdate(Trigger.new, Trigger.OldMap);
    }
    else if(Trigger.isAfter){
        if(Trigger.isInsert){
            // Static method to handle (A) procedure.
            Trg_Org_Orga_BU_Handler.OnAfterInsert(Trigger.new);
        }
        if(Trigger.isUpdate){
            // Static method to handle (B) (C) procedures.
            Trg_Org_Orga_BU_Handler.OnAfterUpdate(Trigger.new, Trigger.OldMap);
        }
    }
}