//Generated by wsdl2apex

public class AsyncTestpaymetric {
    public class SoapOpResponse_elementFuture extends System.WebServiceCalloutFuture {
        public testpaymetric.IPackets getValue() {
            testpaymetric.SoapOpResponse_element response = (testpaymetric.SoapOpResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.SoapOpResult;
        }
    }
}