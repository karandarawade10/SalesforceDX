//soap headers need to be generated and inserted for authentication against WSSE web-services
public class Security{
    public class Securityheader {
        public UsernameToken usernameToken;
        public Securityheader(UsernameToken u){
            this.usernameToken = u;
        }
        private String[] usernameToken_type_info = new String[]{'UsernameToken','http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','UsernameToken','0','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','true','false'};
        private String[] field_order_type_info = new String[]{'usernameToken'};
    }
    
    public class UsernameToken {
    public String username;
    public Password password;
    
    public UsernameToken(String username, Password password){
    	this.username = username;
    	this.password = password;
    }
    
    private String[] username_type_info = new String[]{'Username','http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','string','0','1','true'};
    private String[] password_type_info = new String[]{'Password','http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','string','1','1','true'};
    private String[] apex_schema_type_info = new String[]{'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','true','false'};
    private String[] field_order_type_info = new String[]{'username','password'};
    }
    
    public class Password {
    	
        public string Type;
        public string content;
        
        public Password(String Type, String value){
            this.Type = Type;
            this.content = value;
        }
        
        private String[] Type_att_info = new String[]{'Type'};
        private String[] content_type_info = new String[]{'content','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','true','false'};
        private String[] field_order_type_info = new String[]{'content'};	
                        
    }
}