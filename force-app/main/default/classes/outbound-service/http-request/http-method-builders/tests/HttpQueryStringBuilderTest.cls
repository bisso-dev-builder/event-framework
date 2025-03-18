@isTest
public class HttpQueryStringBuilderTest {

    @isTest
    public static void shouldInjectParametersIntoUrlQueryString () {
        
        HttpQueryStringBuilder builder = new HttpQueryStringBuilder();

        HttpRequest request = new HttpRequest();

        request.setEndpoint('https://api.com');


        builder.injectPayload( new Map<String,String>{ 'parameter1' =>'value 1',
                                                       'parameter2' =>'value 2' }, request);

        Assert.areEqual( 'https://api.com?parameter2=value+2&parameter1=value+1&' , request.getEndpoint());


        request.setEndpoint('https://api.com?');


        builder.injectPayload( new Map<String,String>{ 'parameter1' =>'value 1',
                                                       'parameter2' =>'value 2' }, request);

        Assert.areEqual( 'https://api.com?&parameter2=value+2&parameter1=value+1&' , request.getEndpoint());


        request.setEndpoint('https://api.com?value=value&');


        builder.injectPayload( new Map<String,String>{ 'parameter1' =>'value 1',
                                                       'parameter2' =>'value 2' }, request);

        Assert.areEqual( 'https://api.com?value=value&parameter2=value+2&parameter1=value+1&' , request.getEndpoint());

    }

}