import { LightningElement, track } from 'lwc';

export default class PropertyLWC extends LightningElement {

    @track message="Reactive @track provate property";

    handleOnchangeEvent(event){
        this.message=event.target.value;
    }

}