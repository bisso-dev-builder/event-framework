
String value = '{!$Credential.forcecampext.clientId}';

System.debug( value.replace('forcecampext', 'forcecampext_DEV') );

System.debug(URL.getOrgDomainUrl().getHost());

System.debug(URL.getOrgDomainUrl().toExternalForm());


HttpRequest request = new HttpRequest();

request.setEndPoint ('callout:viacep/ws/01001000/json/');
request.setMethod ('GET');

HttpResponse response = new Http().send ( request );

System.debug(response.getStatusCode());
    
System.debug(JSON.serialize( response.getBody() ));

AbstractEventPublisher publisher = new AbstractEventPublisher();

publisher.publish( 'GetAddressOutbound' , new List<Lead> { new Lead (Id = '00QgK0000004oD4UAI') });
 


HttpRequest request = new HttpRequest();

request.setEndPoint ('callout:forcecamp/services/oauth2/token');
request.setMethod ('POST');
request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
request.setBody( 'client_id={!$Credential.forcecampext.clientId}&client_secret={!$Credential.forcecampext.clientSecret}&grant_type=client_credentials' );

HttpResponse response = new Http().send ( request );

System.debug(response.getStatusCode());
System.debug(response.getBody());


// ---------------------------


EventQueue event = new EventQueue('OAuthProject');

OAuthClientCredentialRequest request = new OutboundClientCredentialBuilder(event).build();
        
Callout callout = new Callout (event);

BaseAuthToken oauthToken = (BaseAuthToken) callout.send( request );

System.debug(oauthToken);

this.authentication = new HttpAuthentication (oauthToken.access_token);


https://devbuilder-e-dev-ed.develop.my.salesforce.com/services/apexrest/api/priceAvailability


//GetPriceAvailabilityOutbound

EventQueue event = new EventQueue('GetPriceAvailabilityOutbound');

CalloutWithOAuthFlow callout = new CalloutWithOAuthFlow (event);

System.debug(JSON.serialize( callout.send ( new Map<String,String> {
    'customerCode' => '1232131',
    'shippingCode' => '12321321',
    'sku' => 'GC1060',
    'quantity' => '1',
    'unitOfMeasure' => 'EA'
} ) ));






EventQueue event = new EventQueue('GetAddressOutbound');

///ws/{!zipcode}/json

Callout callout = new Callout(event);

/* String endpoint = callout.getRequestBuilder().getEndPoint();

endpoint += '12227660/json';

callout.getRequestBuilder().withEndPoint(endpoint);
 */
System.debug( JSON.serialize(callout.send( new Map<String,String> { 'zipcode' => '12227660' }) ) );



String template = 'Olá, {!nome}, você tem {!idade} anos.';
Map<String, String> variables = new Map<String, String>{
    'nome' => 'João',
    'idade' => '30'
};

Pattern pt = Pattern.compile('\\{!(\\w+)\\}');
Matcher matcher = pt.matcher(template);

while (matcher.find()) {
    String key = matcher.group(1);
    if (variables.containsKey(key)) {
        template = template.replace('{!' + key + '}', variables.get(key));
    }
}

System.debug(template);


