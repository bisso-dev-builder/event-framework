public inherited sharing virtual class ContentDocumentRepository extends AbstractRepository {
    
    public ContentDocumentRepository() {
    }

    virtual
	public List<ContentVersion> findVersionsById (List<String> ids) {
        return [
            SELECT Id, Title, ContentDocumentId, PathOnClient, VersionData
            FROM ContentVersion
            WHERE Id IN :ids
        ];
    }

    virtual
    public ContentVersion findVersionId (String id) {	
        return (ContentVersion) Lists.getFirstOrNull ( findVersionsById (new List<String> {id}) );
    }
    
}