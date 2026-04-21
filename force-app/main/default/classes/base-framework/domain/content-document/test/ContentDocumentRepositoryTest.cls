@isTest
public class ContentDocumentRepositoryTest {
    
    @isTest
    static void shouldSaveContentVersionAndGenerateContentDocument() {

        ContentVersion contentVersion = ContentVersionFixtureFactory.newContentVersion();
        ContentDocumentRepository repository = new ContentDocumentRepository();

        repository.save(contentVersion);

        Assert.isNotNull(contentVersion.Id, 'ContentVersion Id should not be null');
        
        ContentVersion stored = repository.findVersionId (contentVersion.Id);

        Assert.isNotNull(stored.ContentDocumentId, 'ContentDocumentId should not be null');
    }

    @isTest
    static void shouldSaveContentVersionRelatedToRecordAndCreateContentDocumentLink() {

        Account account = CommonsFixtureFactory.save('Account With File');
        ContentVersion contentVersion = ContentVersionFixtureFactory.newContentVersion();
        ContentDocumentRepository repository = new ContentDocumentRepository();

        repository.saveRelated(
            account,
            'FirstPublishLocationId',
            new List<SObject>{ contentVersion }
        );

        Assert.isNotNull(contentVersion.Id, 'ContentVersion Id should not be null');

        ContentVersion stored = repository.findVersionId (contentVersion.Id);
        
        Assert.isNotNull(stored.ContentDocumentId, 'ContentDocumentId should not be null');
        
        List<ContentDocumentLink> links = [
            SELECT Id, ContentDocumentId, LinkedEntityId
            FROM ContentDocumentLink
            WHERE ContentDocumentId = :stored.ContentDocumentId
            AND LinkedEntityId = :account.Id
        ];

        System.assertEquals(1, links.size(), 'Should create one ContentDocumentLink');
    }



}