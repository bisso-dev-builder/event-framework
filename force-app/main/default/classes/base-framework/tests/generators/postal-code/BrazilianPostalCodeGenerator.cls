@isTest
public class BrazilianPostalCodeGenerator {

    public static String postalCode () {
        return StringGenerator.numeric(8).toString().leftPad(8, '0');
    }

    @isTest
    static void shouldCreatePostalCodeWithExactlyEightChars() {
        String postalCode = postalCode();

        Assert.areEqual(8, postalCode.length());
    }

    @isTest
    static void shouldCreatePostalCodeWithOnlyDigits() {
        String postalCode = postalCode();

        Assert.isTrue(postalCode.isNumeric(), 'Expected only digits but got: ' + postalCode);
    }

    @isTest
    static void shouldCreatePostalCodeWithinValidRange() {
        
        String postalCode = postalCode();

        Assert.areEqual(8, postalCode.length() );

    }

    @isTest
    static void shouldCreateDifferentPostalCodesOnSubsequentCalls() {
        String first  = postalCode();
        String second = postalCode();

        Assert.areNotEqual(first, second);
    }

}