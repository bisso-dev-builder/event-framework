public class ContentVersionBuilder {
    private ContentVersion contentVersion;

    public ContentVersionBuilder() {
        this.contentVersion = new ContentVersion();
        withContentLocation('S');
    }

    public static ContentVersionBuilder create() {
        return new ContentVersionBuilder();
    }

    public ContentVersionBuilder withTitle(String title) {        
        return withTitleAndExtension (title, '.txt');
    }

    public ContentVersionBuilder withTitleAndExtension(String title, String extension) {
        contentVersion.Title = title;
        return withPathOnClient(title + extension);
    }

    public ContentVersionBuilder withPathOnClient(String pathOnClient) {
        contentVersion.PathOnClient = pathOnClient;
        return this;
    }

    public ContentVersionBuilder withVersionData(String versionData) {
        return withVersionData ( Blob.valueOf(versionData) );
    }

    public ContentVersionBuilder withVersionData(Blob versionData) {
        contentVersion.VersionData = versionData;
        return this;
    }

    public ContentVersionBuilder withContentLocation(String contentLocation) {
        contentVersion.ContentLocation = contentLocation;
        return this;
    }

    public ContentVersionBuilder withFirstPublishLocation(Id firstPublishLocationId) {
        contentVersion.FirstPublishLocationId = firstPublishLocationId;
        return this;
    }

    public ContentVersion build() {
        return contentVersion;
    }
}