public class CompanyDocumentValidator {

    private Integer MAX_SIZE = 14;

    public Boolean isCNPJ(String cnpj) {

        if (String.isEmpty(cnpj)) return false;

        cnpj = keepOnlyValidDigits (cnpj.toUpperCase());

        if (isAllowedStream(cnpj) 
            || isGreaterThanMaxSize(cnpj)
            || isSameDigits(cnpj)) {
            return false;
        }

        cnpj = paddingLeftWithZero(cnpj);

        List<Integer> cnpjAscii = toAsciiList(cnpj);

        Integer digit13 = calculateDigitCNPJ(cnpjAscii, 5, 12);
        Integer digit14 = calculateDigitCNPJ(cnpjAscii, 6, 13);

        if (digit13 != cnpjAscii.get(12) || digit14 != cnpjAscii.get(13)) {
            return false;
        }

        return true;
    }

    private Integer calculateDigitCNPJ(List<Integer> cnpj, Integer weight, Integer iteration) {
        Integer sum = 0;
        for (Integer i = 0; i < iteration; i++) {
            sum += (cnpj.get(i) * weight);
            weight--;
            if (weight < 2) weight = 9;
        }
        Integer rest = Math.mod(sum, 11);
        if (rest < 2) return 0;
        return 11 - rest;
    }

    public Integer getMaxSize() {
        return MAX_SIZE;
    }

    Boolean isAllowedStream (String value) {
        return !Pattern.matches('^[0-9A-Z]+$', value);
    }

    String keepOnlyValidDigits (String value) {

        if (String.isEmpty(value)) return value;

        return value.replaceAll('[^0-9A-Z]', '');
    }

    Boolean isGreaterThanMaxSize(String value) {
        return value.length() > getMaxSize();
    }

    Boolean isSameDigits(String value) {
        // Faz o teste considerando a conversão ASCII - todos os caracteres iguais
        String firstChar = value.left(1);
        return value.replaceAll(firstChar, '').length() == 0;
    }

    String paddingLeftWithZero(String value) {
        return value.leftPad(getMaxSize(), '0');
    }

    List<Integer> toAsciiList(String value) {

        List<Integer> asciiValues = new List<Integer>();
        for (Integer i = 0; i < value.length(); i++) {
            asciiValues.add(((Integer)value.charAt(i)) - 48);
        }
        return asciiValues;
    }
    
}