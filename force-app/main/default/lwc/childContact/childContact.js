import { LightningElement,api } from 'lwc';

export default class ChildContact extends LightningElement {
    @api contact;
    @api contactData;


    handleEventFromChid(event){
        
        
        this.contactData=event.target.value; 
        //console.log('Inside child event'+this.contactData.name);
         // Create Event 
         const eventS=new CustomEvent('simple',
         {
             detail:this.contactData
         });

         // Dispatch event
         this.dispatchEvent(eventS);
    }
}