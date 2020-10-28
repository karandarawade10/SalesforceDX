import { LightningElement, wire, track } from 'lwc';
import getAllContacts from '@salesforce/apex/LWXApex.getAllContacts';

export default class LWCApexCall extends LightningElement {
 
   @track contactName;
   @track contacts;
   @track contactData;
   @track error;
   @track listItem=['1','2','3'];
   @track contacts1=[
      {
          id:1,
          name:'Karan Darawade',
          email:'Karandarawade10@gmail.com',
          phone:'9987654312'
      },
      {
          id:2,
          name:'Pratik Darawade',
          email:'Karandarawade10@gmail.com',
          phone:'9987654312'
      },
      {
          id:3,
          name:'Raj Darawade',
          email:'Karandarawade10@gmail.com',
          phone:'9987654312'
      }
  ];

   // Call apex method using @wire
   @wire(getAllContacts,{name:'$contactName'}) contacts;
   
   onContactChange(event){
     this.contactName=event.target.value;
   }

   // Call apex method using Imperative approach
   loadContact(){
      console.log("contact name"+this.contactName);
      var items=this.listItem;
      
      for(var l in items){
         console.log("List value"+items[l]);
     }

     items.forEach(function(obj){

      console.log("List value"+obj);
     }
     )



      var con = this.contacts1;
         for(var c in con){
         console.log("List value"+con[c].name);
      }

      getAllContacts({
         name:this.contactName
      }).then(result=>{
         console.log("result=>"+result); 
         this.contactData=result;
      }).catch(error=>{
         console.log("Error=>"+error);
         this.error=error;
      });
   }
}