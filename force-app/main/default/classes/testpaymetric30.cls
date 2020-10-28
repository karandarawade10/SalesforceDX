//Generated by wsdl2apex

public class testpaymetric30 {
    public class XiPayWSSoap {
        public String endpoint_x = 'https://cert-xipayapi.paymetric.com/PMXIGGE/XiPay30WS.asmx';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://Paymetric/XiPaySoap30/message/', 'testpaymetric', 'http://Paymetric/XiPaySoap30', 'testpaymetric30'};
        public testpaymetric.IPackets SoapOp(testpaymetric.IPackets pPacketsIn) {
            testpaymetric.SoapOp_element request_x = new testpaymetric.SoapOp_element();
            request_x.pPacketsIn = pPacketsIn;
            testpaymetric.SoapOpResponse_element response_x;
            Map<String, testpaymetric.SoapOpResponse_element> response_map_x = new Map<String, testpaymetric.SoapOpResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'Paymetric/XiPaySoap30/action/XiGGE.SoapOp',
              'http://Paymetric/XiPaySoap30/message/',
              'SoapOp',
              'http://Paymetric/XiPaySoap30/message/',
              'SoapOpResponse',
              'testpaymetric.SoapOpResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.SoapOpResult;
        }
    }
}