public class testApiREsponse {

    
    public static void getData(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://demo4202316.mockable.io/getOrder');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        system.debug('response=>'+response.getBody());
        ResponseData resData=(ResponseData)json.deserialize(response.getBody(), ResponseData.Class);
        system.debug('final response=>'+resData.amount);
        Double d=Double.valueOf(resData.amount);
        System.debug('double=>'+d);
    }
    
    public class ResponseData{
        public String amount;
    }
}