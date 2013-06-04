module Sepa
  class Client
    def initialize(params)
      check_params(params)
      # Initialize savon client with params and construct soap message
      wsdl = params.fetch(:wsdl)
      @client = Savon.client(wsdl: wsdl)
      @soap = SoapRequest.new(params).to_xml
      @command = params.fetch(:command)
    end

    # Call savon to make the soap request with the correct command and the
    # the constructed soap. The returned object will be a savon response.
    def send
      @client.call(@command, xml: @soap)
    end

    private

      def check_params(params)
        unless params.respond_to?(:each_pair)
          fail ArgumentError, "You didn't provide a proper hash"
        end
      end
  end
end
