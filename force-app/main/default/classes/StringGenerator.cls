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

    public static Integer numeric (Integer length) {
        return Integer.valueOf( generate (length, CharType.NUMERIC) );
    }

    public static Integer numeric (Integer length, Integer decimalPlaces) {
        return Integer.valueOf( generate (length, CharType.NUMERIC) );
    }

    public static Decimal generateDecimal(Integer length, Integer decimalPlaces) {

        if ( decimalPlaces == null || decimalPlaces < 0 ) {
            decimalPlaces = 0;
        }

        String decimalPlacesValue = (decimalPlaces == 0) ? '0' : generate (decimalPlaces, CharType.NUMERIC);
        String integerValue = generate(length - decimalPlaces, CharType.NUMERIC);

        return Decimal.valueOf(integerValue + '.' + decimalPlacesValue);
    }

    public static String generate (Integer length, String chars ) {

        String[] result = new String[length];

        Integer index = 0;

        while (index < length) {

            Integer chr = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            result[index++] = chars.substring(chr, chr + 1);
        }

        return String.join(result, '');
    }

}