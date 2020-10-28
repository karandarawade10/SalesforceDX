public class ParkLocator {

    public static string[] country(String country){
        ParkService.ParksImplPort soapRes=new ParkService.ParksImplPort();
        return soapRes.byCountry(country);
    }
    
}