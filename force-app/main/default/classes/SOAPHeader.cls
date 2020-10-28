public class SOAPHeader {
    
    // SecurityHeaderType Class
    public class SecurityHeaderType 
    {       
        // Constructor for SecurityHeaderType used to pass in username and password parameters and instantiate the UsernameToken object     
        public SecurityHeaderType(String soapHeader)
        {
            this.soapHeader =soapHeader;
        }
        public String soapHeader;
       
        private String[] soapHeader_type_info = new String[]{'soapHeader','http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','true','false'};
        private String[] field_order_type_info = new String[]{'soapHeader'}; 
    }
}