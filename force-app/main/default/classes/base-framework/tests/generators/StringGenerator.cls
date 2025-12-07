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

    public static Decimal numeric (Integer length, Integer decimalPlaces) {
        
        if ( decimalPlaces == null || decimalPlaces < 0 ) {
            decimalPlaces = 0;
        }

        String decimalPlacesValue = (decimalPlaces == 0) ? '0' : generate (decimalPlaces, CharType.NUMERIC);
        String integerValue = generate(length - decimalPlaces, CharType.NUMERIC);

        return Decimal.valueOf(integerValue + '.' + decimalPlacesValue);

    }

    public static String generate (Integer length, String chars ) {

        String result = '';

        for ( Integer index = 0; index < length; index++ ) {

            Integer chr = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());

            result += chars.substring(chr, chr + 1);
        }

        return result;
    }

}