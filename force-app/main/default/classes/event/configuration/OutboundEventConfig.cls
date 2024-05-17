/**
 * @author eduardo.bisso - dev-builder
 */
public class OutboundEventConfig {

    String endPointUrl;

    Integer timeout;
   
    String certificateName;

    String httpMethod;

    String httpHeaders;

    String namedCredencial;

    String responseClassName;

    public OutboundEventConfig() {
        this.timeout = 12000;
    }

    public OutboundEventConfig(EventOutboundConfig__mdt config) {

        this();

        endPointUrl(config.EndPoint__c)
            .timeout(config?.Timeout__c?.intValue() ?? 120000)
            .certificateName(config.CertificateName__c)
            .httpMethod(config.HttpMethod__c)
            .httpHeaders(config.HttpHeaders__c)
            .namedCredencial(config.NamedCredencial__c)
            .responseClassName(config.ResponseClassName__c);
    }

    public OutboundEventConfig endPointUrl(String endPointUrl) {
        this.endPointUrl = endPointUrl;
        return this;
    }

    public OutboundEventConfig timeout(Integer timeout) {
        this.timeout = timeout;

        return this;
    }

    public OutboundEventConfig certificateName(String certificateName) {
        this.certificateName = certificateName;
        return this;
    }

    public OutboundEventConfig httpMethod(String httpMethod) {
        this.httpMethod = httpMethod;
        return this;
    }

    public OutboundEventConfig httpHeaders( String httpHeaders ) {
        this.httpHeaders = httpHeaders;
        return this;
    }

    public OutboundEventConfig namedCredencial(String namedCredencial) {
        this.namedCredencial = namedCredencial;
        return this;
    }

    public OutboundEventConfig responseClassName(String responseClassName) {
        this.responseClassName = responseClassName;
        return this;
    }

    public String getEndPointUrl() {
        return this.endPointUrl;
    }

    public Integer getTimeout() {
        return this.timeout;
    }

    public String getCertificateName() {
        return this.certificateName;
    }

    public String getHttpMethod() {
        return this.httpMethod;
    }

    public String getHttpHeaders() { 
        return this.httpHeaders;
    }

    public String getNamedCredencial() {
        return this.namedCredencial;
    }

    public String getResponseClassName() {
        return this.responseClassName;
    }

}