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
 


EventQueue event = new EventQueue('GetAddressOutbound');

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


