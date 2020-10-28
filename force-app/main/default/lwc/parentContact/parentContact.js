import { LightningElement,track } from 'lwc';

export default class ParentContact extends LightningElement {
  
     @track childMessage;

     @track listItem=['1','2','3'];


     testChildEvent(){
        alert('Child to parent');
    }
    
    // calling child method from parent
    callChildMethod(){
        this.template.querySelector('c-bubble-event').childMethodCallingFromParent('Parent message passed');
    }
    handleChildClickEvent(event){

      var listitm=this.listItem;
      for(var l in listitm){
          console.log("List value"+listitm[l]);
      }

      //  alert('Child to parent on click'+event.detail.name);
        this.childMessage=event.detail.name;
    }
    bubbleEventParent(event){
      alert('Bubble Event'+event.target.accountName)
    }

     contacts=[
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
        },
        {
            id:4,
            name:'Kuldip Darawade',
            email:'Karandarawade10@gmail.com',
            phone:'9987654312'
        },
        {
            id:5,
            name:'Pooja Darawade',
            email:'Karandarawade10@gmail.com',
            phone:'9987654312'
        },
        {
            id:6,
            name:'Poonam Darawade',
            email:'Karandarawade10@gmail.com',
            phone:'9987654312'
        }
    ];

    renderedCallback(){
        console.log('Size of Contacts  ' + this.contacts.length);
    }
}