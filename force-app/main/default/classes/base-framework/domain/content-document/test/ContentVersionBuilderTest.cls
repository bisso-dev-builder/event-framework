@isTest
public class ContentVersionBuilderTest {

    @isTest
    static void shouldBuildContentVersionWithFirstPublishLocation() {
        // Given
        Account account = CommonsFixtureFactory.save('TestAccount');
        Id locationId = account.Id;

        // When
        ContentVersion cv = ContentVersionBuilder.create()
            .withTitle('TestDocument')
            .withVersionData('file content')
            .withFirstPublishLocation(locationId)
            .build();

        // Then
        Assert.areEqual(locationId, cv.FirstPublishLocationId, 'FirstPublishLocationId should be set');
        Assert.areEqual('TestDocument', cv.Title, 'Title should be set');
    }

}
