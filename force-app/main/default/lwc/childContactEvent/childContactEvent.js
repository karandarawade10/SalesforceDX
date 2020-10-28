import { LightningElement } from 'lwc';

export default class ChildContactEvent extends LightningElement {

    testEvent(){
        // Create Event 
            const eventS=new CustomEvent('simplechild');

            // Dispatch event
            this.dispatchEvent(eventS);
    }
}