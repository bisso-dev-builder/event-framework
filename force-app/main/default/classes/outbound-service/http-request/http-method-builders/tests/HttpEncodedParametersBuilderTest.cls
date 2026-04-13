@isTest
public class HttpEncodedParametersBuilderTest {

    @isTest
    public static void shouldInjectEncodedParameterInRequestPayloadBody () {

        HttpEncodedParametersBuilder builder = new HttpEncodedParametersBuilder();

        HttpRequest request = new HttpRequest();

        builder.injectPayload( new Map<String,String>{ 'parameter1' =>'value 1',
                                                       'parameter2' =>'value 2' }, request);

        Assert.areEqual( 'parameter2=value+2&parameter1=value+1&' , request.getBody());

    }

    @isTest
    static void shouldReturnRequestUnchangedWhenPayloadIsNull() {
        // Covers line 11: early return when payload is null
        HttpEncodedParametersBuilder builder = new HttpEncodedParametersBuilder();
        HttpRequest request = new HttpRequest();

        HttpRequest result = builder.injectPayload(null, request);

        System.debug(result.getBody());

        String responseBody = result.getBody();

        Assert.areEqual(request, result, 'Should return the same request when payload is null');
        Assert.isTrue( String.isEmpty(responseBody) , 'Body should remain empty when payload is null');
    }

    @isTest
    static void shouldSkipNullValuesInParameters() {
        // Covers line 37: continue when parameter value is null
        HttpEncodedParametersBuilder builder = new HttpEncodedParametersBuilder();
        HttpRequest request = new HttpRequest();

        Map<String,String> params = new Map<String,String>{
            'key1' => 'value1',
            'key2' => null
        };

        builder.injectPayload(params, request);

        Assert.isTrue(request.getBody().contains('key1=value1'), 'Should include non-null parameter');
        Assert.isFalse(request.getBody().contains('key2'), 'Should skip null parameter');
    }

    @isTest
    static void shouldNotEncodeCredentialBindVariables() {
        // Covers line 50: bind variable ($Credential) is returned as-is without URL encoding
        HttpEncodedParametersBuilder builder = new HttpEncodedParametersBuilder();
        HttpRequest request = new HttpRequest();

        Map<String,String> params = new Map<String,String>{
            'client_secret' => 'prefix$Credentialsuffix'
        };

        builder.injectPayload(params, request);

        Assert.isTrue(request.getBody().contains('prefix$Credentialsuffix'),
            'Credential bind variables should not be URL encoded');
    }

}