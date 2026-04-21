/**
 * @author eduardo.bisso - dev-builder
 */
public class StringGenerator {

    public static String text (Integer length)  {
        return generate (length, CharType.ALPHA);
    }

    public static String textWithNumbers (Integer length) {
        return generate (length, CharType.ALPHA_NUMERIC);
    }

    public static Long numeric (Integer length) {
        return numeric (length, 0).longValue();
    }

    public static Decimal numeric(Integer totalLength, Integer decimalPlaces) {
        if (totalLength <= 0) return 0;

        if (decimalPlaces == null || decimalPlaces < 0) {
            decimalPlaces = 0;
        }

        Integer integerLength = Math.max(totalLength - decimalPlaces, 1);

        String integerPart = generate(1, CharType.NUMERIC_WITHOUT_ZERO);
        
        if (integerLength > 1) {
            integerPart += generate(integerLength - 1, CharType.NUMERIC);
        }

        String decimalPart = decimalPlaces > 0
                                ? generate(decimalPlaces, CharType.NUMERIC)
                                : '0';

        return Decimal.valueOf(integerPart + '.' + decimalPart);

    }

    public static String generate (Integer length, String chars ) {

        if (length <= 0) length = 1;

        String result = '';

        for ( Integer index = 0; index < length; index++ ) {

            Integer chr = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());

            result += chars.substring(chr, chr + 1);
        }

        return result;
    }

}