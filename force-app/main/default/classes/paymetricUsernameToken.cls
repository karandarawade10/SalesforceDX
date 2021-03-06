public class paymetricUsernameToken {
      
       // Constructor for UsernameToken used to pass in username and password parameters
        public paymetricUsernameToken(String username, String password)
        {
            this.Username = username;
            this.Password = password;
            this.Nonce = generateNounce();
            this.Created = generateTimestamp();
        }
        
        public String Username;
        public String Password;
        public String Nonce;
        public String Created;
        private String[] Username_type_info = new String[]{'Username','http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','string','0','1','false'};
        private String[] Password_type_info = new String[]{'Password','http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText','string','0','1','false'};
        private String[] Nonce_type_info = new String[]{'Nonce','http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','string','0','1','false'};
        private String[] Created_type_info = new String[]{'wsu:Created','http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','string','0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd','true','false'};
        private String[] field_order_type_info = new String[]{'Username','Password'};
                                    
        // Generate Nounce, random number base64 encoded
         public String generateNounce(){
               Long randomLong = Crypto.getRandomLong();
                return EncodingUtil.base64Encode(Blob.valueOf(String.valueOf(randomLong)));
         }
        
        // Generate timestamp in GMT
        public String generateTimestamp()
        {
            return Datetime.now().formatGmt('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');
        }
}