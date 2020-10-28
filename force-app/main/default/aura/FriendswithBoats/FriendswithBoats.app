<aura:application extends="force:slds">
  <lightning:layout>
    <lightning:layoutItem size="12" mediumDeviceSize="8" padding="around-small">
      <lightning:card title="Find a Boat" class="slds-m-bottom_medium">
        <c:BoatSearchForm />
      </lightning:card>
      <lightning:card title="Matching Boats">
        <c:BoatSearchResults />
      </lightning:card>
    </lightning:layoutItem>
    <lightning:layoutItem size="12" mediumDeviceSize="4" padding="around-small">
      <c:BoatDetails />
      <c:Map />
    </lightning:layoutItem>
  </lightning:layout>
</aura:application>