public class HttpRequestUrlBinder {

    public static String bind ( String url, Map<String,String> requestPayload ) {

        Matcher matcher = Pattern.compile('\\{!(\\w+)\\}').matcher(url);

        String bindedUrl = url;

        while (matcher.find()) {
            String key = matcher.group(1);
            if (requestPayload.containsKey(key)) {
                bindedUrl = url.replace('{!' + key + '}', requestPayload.get(key));
            }
        }

        return bindedUrl;

    }


}