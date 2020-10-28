@isTest
public class AnimalLocatorTest {

    @isTest static void testCalloutMock(){
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
        String response = AnimalLocator.getAnimalNameById(1);
    }
     
}