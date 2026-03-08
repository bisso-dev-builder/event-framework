public inherited sharing class EventQueueContentVersionAdapter extends DefaultLoggerAdapter {

    List<ContentVersion> contentVersions;

    ContentDocumentRepository contentRepository;
    
    public EventQueueContentVersionAdapter() {
        contentVersions = new List<ContentVersion>();
        contentRepository = new ContentDocumentRepository();
    }

    override
	public void log (Log log) {
        contentVersions.add ( buildContent(log) );
    }

    private ContentVersion buildContent (Log log) {

        return ContentVersionBuilder.create()
                        .withTitle (log.getTag())
                        .withVersionData (log.getMessage())
                        .build();                    

    }

    public List<ContentVersion> getContentVersions() {
        return this.contentVersions;
    }
}