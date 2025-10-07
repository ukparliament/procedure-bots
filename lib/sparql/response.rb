# We include the code required.
require 'net/http'

# We set the request URI and headers for the SPARQL query.
$SPARQL_REQUEST_URI = URI( 'https://api.parliament.uk/sparql' )
$SPARQL_REQUEST_HEADERS = { 'Content-Type': 'application/sparql-query' }

module Sparql::Response
  
  # A method to get a response from SPARQL as a CSV.
  def get_sparql_response_as_csv( request_body )
  
    # We get the response from the SPARQL query.
    response = Net::HTTP.post( $SPARQL_REQUEST_URI, request_body, $SPARQL_REQUEST_HEADERS )
    
    # We parse the body of the response as CSV.
    CSV.parse( response.body, headers: true )
  end
end