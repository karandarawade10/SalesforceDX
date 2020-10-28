import { LightningElement,api, track } from 'lwc';

export default class BubbleEvent extends LightningElement {
    
    @api accountName;
    @track parentMsg;

    @api
     childMethodCallingFromParent(parentMessage){
         this.parentMsg=parentMessage;
     }

    captureAccountName(event){
        this.accountName=event.target.value;
    }
    handleBubbleEvent(){
           alert('account name:'+this.accountName);
       const eventS=new CustomEvent('simplebubble',
         {
             bubbles:true,
             composed:false
         }
    );

         // Dispatch event
         this.dispatchEvent(eventS);
    }

}