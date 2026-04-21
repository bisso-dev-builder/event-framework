@isTest
public class ContentVersionFixtureFactory {
    public static ContentVersion newContentVersion() {
        return newContentVersion(StringGenerator.text(10));
    }

    public static ContentVersion newContentVersion(String title) {
        return new ContentVersion(
            Title = title,
            ContentLocation = 'S',
            PathOnClient = '/documents/' + title + '.txt',
            VersionData = Blob.valueOf('Test file content')
        );
    }

    public static ContentVersion createContentVersion() {
        return save(newContentVersion());
    }

    public static ContentVersion createContentVersion(String title) {
        return save ( newContentVersion(title) );
    }

    public static ContentVersion newContentVersionFor(Id firstPublishLocationId) {
        ContentVersion contentVersion = newContentVersion();
        contentVersion.FirstPublishLocationId = firstPublishLocationId;
        return contentVersion;
    }

    public static ContentVersion createContentVersionFor(Id firstPublishLocationId) {
        return save ( createContentVersionFor(firstPublishLocationId) );
    }

    public static ContentVersion save (ContentVersion contentVersion) {
        upsert contentVersion;
        return contentVersion;
    }

	public static List<ContentVersion> findById (List<String> ids) {
        return [
            SELECT Id, Title, ContentDocumentId
            FROM ContentVersion
            WHERE Id IN :ids
        ];
    }

}