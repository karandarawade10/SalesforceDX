public class SFMC_SOAP_TO_SF_SECURITY 
{

    public class WrapperHeader{

        public WrapperHeader(String username, String password){
            this.header = new SFMC_SOAP_TO_SF_SECURITY.SecurityHeader(username, password);             
        }
        public SFMC_SOAP_TO_SF_SECURITY.SecurityHeader header;
        private String[] header_type_info = new String[]{'header','http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','UsernameToken','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','true','false'};
        private String[] field_order_type_info = new String[]{'header'}; 
    }
    
    public class SecurityHeader{

        public SecurityHeader(String username, String password){
            this.Action='Paymetric/XiPaySoap30/action/XiGGE.SoapOp';
            this.To='https://cert-xipayapi.paymetric.com/PMXIGGE/XiPay30WS.asmx';
            this.Security = new SFMC_SOAP_TO_SF_SECURITY.SecurityHeaderType(username, password);
        }
       
        public String Action;
        public String To;
       
        private String[] To_type_info = new String[]{'To','http://www.w3.org/2005/08/addressing',null,'0','1','false'};
        private String[] Action_type_info = new String[]{'Action','http://www.w3.org/2005/08/addressing',null,'0','1','false'};
        public SFMC_SOAP_TO_SF_SECURITY.SecurityHeaderType Security;
        private String[] Security_type_info = new String[]{'Security','http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd',null,'1','1','false'};
       // private String[] wsaNamespace_att_info = new String[]{'xmlns:wsa'};        
        private String[] apex_schema_type_info = new String[]{'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','true','false'};
        private String[] field_order_type_info = new String[]{'Security','Action','To'}; 

    }

    // SecurityHeaderType Class
    public class SecurityHeaderType 
    {       
        // Constructor for SecurityHeaderType used to pass in username and password parameters and instantiate the UsernameToken object     
        public SecurityHeaderType(String username, String password)
        {
            this.UsernameToken = new SFMC_SOAP_TO_SF_SECURITY.UsernameToken(username, password);
        }
        public String wsseNamespace ='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd';
        public String wsuNamespace ='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd';              
        public SFMC_SOAP_TO_SF_SECURITY.UsernameToken UsernameToken;
       
        private String[] UsernameToken_type_info = new String[]{'wsse:UsernameToken','http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','UsernameToken','1','1','false'};
        private String[] wsseNamespace_att_info = new String[]{'xmlns:wsse'};  
        private String[] wsuNamespace_att_info = new String[]{'xmlns:wsu'};               
        private String[] apex_schema_type_info = new String[]{'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','true','false'};
        private String[] field_order_type_info = new String[]{'UsernameToken'};
    }


    public class UsernameToken {
        // Constructor for UsernameToken used to pass in username and password parameters
        public UsernameToken(String username, String password)
        {
            this.Username = username;
            this.password=password;
           //this.Nonce = generateNounce();
           //this.Created = generateTimestamp();
        }
        
        public String wsuId ='UsernameToken-3c52cc57-4ab6-4e3c-9c4e-7aca3088a013'; 
      //  public String wsuNamespace ='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd'; 
        public String Username;
        public String Password;
        //public String Nonce;
        //public String Created;
        //Public password_e passwordToken;
       //xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"
        
        private String[] wsuId_att_info = new String[]{'wsu:Id'};
       // private String[] wsuNamespace_att_info = new String[]{'xmlns:wsu'};
       // private String[] Nonce_type_info = new String[]{'wsu:Nonce','http://www.w3.org/2001/XMLSchema','string','0','1','false'};
      //  private String[] Created_type_info = new String[]{'wsu:Created','http://www.w3.org/2001/XMLSchema','string','0','1','false'};        
        private String[] Username_type_info = new String[]{'wsse:Username','http://www.w3.org/2001/XMLSchema','string','0','1','false'};
        private String[] Password_type_info = new String[]{'wsse:Password','http://www.w3.org/2001/XMLSchema','string','0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','true','false'};
        private String[] field_order_type_info = new String[]{'Username','Password'/*,'Nonce','Created'*/};

            
            
        // Generate Nounce, random number base64 encoded
        public String generateNounce()
        {
            Long randomLong = Crypto.getRandomLong();
            return EncodingUtil.base64Encode(Blob.valueOf(String.valueOf(randomLong)));
        }

        // Generate timestamp in GMT
        public String generateTimestamp()
        {
            return Datetime.now().formatGmt('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');
        }
        
    }

    public class password_e{
        public password_e(String password) {
            this.password = password;
            type = 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText';             
        }
        
        public String password;
        public string type; 
        public String[] type_att_info = new String[]{'Type'};        
        private String[] password_type_info = new String[]{'Password','http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','true','false'};
        private String[] field_order_type_info = new String[]{'password'};
    }

       
}