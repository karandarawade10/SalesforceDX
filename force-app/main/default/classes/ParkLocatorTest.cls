@isTest
public class ParkLocatorTest {

    @isTest static void testCallout() {
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        
        String country='Germany';
        String[] responses=ParkLocator.country(country);
        
        
    }
}