public class testJSON {
    
    public static void testData(){
        MuleSoftOrderAPIResponse muleSoftResponse=new MuleSoftOrderAPIResponse();
        Http h = new Http(); 
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://demo6576049.mockable.io/testOrder');
        req.setMethod('GET');    
        //perform get rqquest to API
        HttpResponse res = h.send(req);
        
        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        m.put('docType','Order');
        system.debug('Order=>'+JSON.serialize(m));
        muleSoftResponse=(MuleSoftOrderAPIResponse)JSON.deserialize(res.getBody().replace('"currency"', '"currencyCode"'),MuleSoftOrderAPIResponse.class);

        getdata(muleSoftResponse);
         
        system.debug('JSON=>'+JSON.serialize(muleSoftResponse));
              
    }
    
     public class MuleSoftOrderAPIResponse{
        public String docType;
        public List<OrderLineRes> lineItems;
    }
    public class OrderLineRes{
        
        public string lineNumber;
        public string shipDate;
        public string originalQty;
        public string shippedQuantity;
        public NetPrice1 netPrice1;
        //public TaxPrice1 taxPrice1;
        public ShippingPrice shippingPrice;
        public NetDiscountedPrice netDiscountedPrice;
        
    }
   
    public class NetPrice1{
        public string amount;
        public string currencyCode;
    }
    public class TaxPrice1{
        public string amount;
        public string currencyCode;
    } 
    public class ShippingPrice{
        public string amount;
        public string currencyCode;
    }
    public class NetDiscountedPrice{
        public string amount;
        public string currencyCode;
    }
    
    public static void getdata(Object orderReponse){
        
        MuleSoftOrderAPIResponse muleSoftResponse=(MuleSoftOrderAPIResponse)JSON.deserialize(String.valueOf(orderReponse).replace('"currency"', '"currencyCode"'),MuleSoftOrderAPIResponse.class);

        system.debug('orderReponse=>'+string.valueOf(orderReponse));
        
        
    }
    
}