System.debug(URL.getOrgDomainUrl().getHost());

System.debug(URL.getOrgDomainUrl().toExternalForm());


HttpRequest request = new HttpRequest();

request.setEndPoint ('callout:IntegrationFrameworkClient/services/oauth2/token');
request.setMethod ('POST');

HttpResponse response = new Http().send ( request );

System.debug(response.getStatusCode());
    
System.debug(JSON.serialize( response.getBody() ));
