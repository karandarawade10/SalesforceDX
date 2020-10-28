//Generated by wsdl2apex

public class AsyncSiebelComAsi {
    public class SREngUpdate_Output_elementFuture extends System.WebServiceCalloutFuture {
        public String getValue() {
            siebelComAsi.SREngUpdate_Output_element response = (siebelComAsi.SREngUpdate_Output_element)System.WebServiceCallout.endInvoke(this);
            return response.VStatus;
        }
    }
    public class AsyncSREngReallocation {
        public String endpoint_x = 'http://ftizssdweb016.FTDC.cummins.com:8001/eai_enu/start.swe?SWEExtSource=SecureWebService&SWEExtCmd=Execute&WSSOAP=1';
        public Map<String,String> inputHttpHeaders_x;
        public String clientCertName_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://siebel.com/asi/', 'siebelComAsi'};
        public AsyncSiebelComAsi.SREngUpdate_Output_elementFuture beginSREngUpdate(System.Continuation continuation,String VSFDCSrNum,String VSFDCSerEngLoginId) {
            siebelComAsi.SREngUpdate_Input_element request_x = new siebelComAsi.SREngUpdate_Input_element();
            request_x.VSFDCSrNum = VSFDCSrNum;
            request_x.VSFDCSerEngLoginId = VSFDCSerEngLoginId;
            return (AsyncSiebelComAsi.SREngUpdate_Output_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncSiebelComAsi.SREngUpdate_Output_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'document/http://siebel.com/asi/:SREngUpdate',
              'http://siebel.com/asi/',
              'SREngUpdate_Input',
              'http://siebel.com/asi/',
              'SREngUpdate_Output',
              'siebelComAsi.SREngUpdate_Output_element'}
            );
        }
    }
}