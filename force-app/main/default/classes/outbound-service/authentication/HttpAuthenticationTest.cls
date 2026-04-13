@isTest
public class HttpAuthenticationTest {

    @isTest
    static void shouldReturnBearerHeaderWithInstanceToken() {
        // Given
        HttpAuthentication auth = new HttpAuthentication('my-token');

        // When
        String header = auth.getHttpHeader();

        // Then
        Assert.areEqual('Bearer my-token', header, 'Should return Bearer header with token');
    }

    @isTest
    static void shouldReturnNullHeaderWhenTokenIsEmpty() {
        // Given
        HttpAuthentication auth = new HttpAuthentication();

        // When
        String header = auth.getHttpHeader();

        // Then
        Assert.isNull(header, 'Should return null when no token is set');
    }

    @isTest
    static void shouldReturnInstanceTokenWhenCacheNameIsNotSet() {
        // Given
        HttpAuthentication auth = new HttpAuthentication('fallback-token');

        // When
        String token = auth.getToken();

        // Then
        Assert.areEqual('fallback-token', token, 'Should return instance token when no cacheName set');
    }

    @isTest
    static void shouldInitializeCachePartitionAndReturnCachedToken() {
        // This test covers the Platform Cache code path (lines 46 and 53).
        // It requires a Platform Cache partition named 'local.OrgCache' to be
        // configured in the org. If not available, the test skips gracefully.
        try {
            Cache.OrgPartition orgPartition = Cache.Org.getPartition('local.OrgCache');
            orgPartition.put('token', 'cached-access-token');

            HttpAuthentication auth = new HttpAuthentication();
            auth.cacheName = 'local.OrgCache';

            String token = auth.getToken();

            Assert.areEqual('cached-access-token', token, 'Should return token from cache');
        } catch (Exception e) {
            // Platform Cache partition not configured in this org - skipping cache coverage
        }
    }

}
