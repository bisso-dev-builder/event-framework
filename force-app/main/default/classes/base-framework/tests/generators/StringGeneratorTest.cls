/**
 * @author eduardo.bisso - dev-builder
 */
@isTest(isParallel=true)
public class StringGeneratorTest {

    // ── text ──────────────────────────────────────────────────────────────────

    @isTest
    static void shouldGenerateTextWithCorrectLength() {

        String value = StringGenerator.text(10);

        Assert.areEqual(10, value.length());
    }

    @isTest
    static void shouldGenerateTextWithOnlyAlphaChars() {
        Test.startTest();
        String value = StringGenerator.text(50);
        Test.stopTest();

        Assert.isTrue(value.containsOnly(CharType.ALPHA), 'Expected only alpha characters, got: ' + value);
    }

    @isTest
    static void shouldGenerateTextWithRandomness() {
        Test.startTest();
        String first = StringGenerator.text(10);
        String second = StringGenerator.text(10);
        Test.stopTest();

        Assert.areNotEqual(first, second);
    }

    @isTest
    static void shouldReturnOneCharWhenTextLengthIsZeroOrNegative() {
        Test.startTest();
        String zeroLength    = StringGenerator.text(0);
        String negativeLength = StringGenerator.text(-5);
        Test.stopTest();

        Assert.areEqual(1, zeroLength.length());
        Assert.areEqual(1, negativeLength.length());
    }

    // ── textWithNumbers ───────────────────────────────────────────────────────

    @isTest
    static void shouldGenerateAlphaNumericWithCorrectLength() {
        Test.startTest();
        String value = StringGenerator.textWithNumbers(20);
        Test.stopTest();

        Assert.areEqual(20, value.length());
    }

    @isTest
    static void shouldGenerateAlphaNumericWithOnlyAlphaNumericChars() {
        Test.startTest();
        String value = StringGenerator.textWithNumbers(50);
        Test.stopTest();

        Assert.isTrue(value.containsOnly(CharType.ALPHA_NUMERIC), 'Expected only alphanumeric characters, got: ' + value);
    }

    @isTest
    static void shouldGenerateAlphaNumericWithRandomness() {
        Test.startTest();
        String first  = StringGenerator.textWithNumbers(20);
        String second = StringGenerator.textWithNumbers(20);
        Test.stopTest();

        Assert.areNotEqual(first, second);
    }

    @isTest
    static void shouldReturnOneCharWhenTextWithNumbersLengthIsZeroOrNegative() {
        Test.startTest();
        String zeroLength     = StringGenerator.textWithNumbers(0);
        String negativeLength = StringGenerator.textWithNumbers(-3);
        Test.stopTest();

        Assert.areEqual(1, zeroLength.length());
        Assert.areEqual(1, negativeLength.length());
    }

    // ── numeric(Integer) ─────────────────────────────────────────────────────

    @isTest
    static void shouldReturnZeroWhenNumericLengthIsZeroOrNegative() {
        Test.startTest();
        Long zeroLength     = StringGenerator.numeric(0);
        Long negativeLength = StringGenerator.numeric(-3);
        Test.stopTest();

        Assert.areEqual(0L, zeroLength);
        Assert.areEqual(0L, negativeLength);
    }

    @isTest
    static void shouldGenerateNumericWithNoLeadingZeroAndCorrectMagnitude() {
        Test.startTest();
        Long value = StringGenerator.numeric(5);
        Test.stopTest();

        Assert.isTrue(value >= 10000L, 'Expected 5-digit number (>= 10000) but got: ' + value);
        Assert.isTrue(value <= 99999L, 'Expected 5-digit number (<= 99999) but got: ' + value);
    }

    // ── numeric(Integer, Integer) ────────────────────────────────────────────

    @isTest
    static void shouldReturnZeroWhenDecimalTotalLengthIsZeroOrNegative() {
        Test.startTest();
        Decimal zeroLength     = StringGenerator.numeric(0, 2);
        Decimal negativeLength = StringGenerator.numeric(-1, 2);
        Test.stopTest();

        Assert.areEqual(0, zeroLength);
        Assert.areEqual(0, negativeLength);
    }

    @isTest
    static void shouldGenerateDecimalWithCorrectIntegerAndDecimalPartLengths() {
        Test.startTest();
        Decimal value = StringGenerator.numeric(5, 2);
        Test.stopTest();

        List<String> parts = String.valueOf(value).split('\\.');
        Assert.areEqual(3, parts[0].length(), 'Expected 3 integer digits but got: ' + parts[0]);
        Assert.areEqual(2, parts[1].length(), 'Expected 2 decimal places but got: ' + parts[1]);
    }

    @isTest
    static void shouldGenerateDecimalWithNoLeadingZeroInIntegerPart() {
        Test.startTest();
        Decimal value = StringGenerator.numeric(5, 2);
        Test.stopTest();

        String integerPart = String.valueOf(value).split('\\.')[0];
        Assert.areNotEqual('0', integerPart.substring(0, 1), 'Integer part must not start with zero');
    }

    @isTest
    static void shouldGenerateSingleDigitDecimalWhenLengthIsOneAndNoDecimalPlaces() {
        Test.startTest();
        Decimal value = StringGenerator.numeric(1, 0);
        Test.stopTest();

        Assert.isTrue(value >= 1, 'Expected value >= 1 but got: ' + value);
        Assert.isTrue(value <= 9, 'Expected value <= 9 but got: ' + value);
    }

    @isTest
    static void shouldTreatNullAndNegativeDecimalPlacesAsZero() {
        Test.startTest();
        Decimal withNull     = StringGenerator.numeric(5, null);
        Decimal withNegative = StringGenerator.numeric(5, -1);
        Test.stopTest();

        Assert.isTrue(withNull     >= 10000, 'Expected 5-digit result for null decimalPlaces, got: '     + withNull);
        Assert.isTrue(withNegative >= 10000, 'Expected 5-digit result for negative decimalPlaces, got: ' + withNegative);
    }

    @isTest
    static void shouldCapIntegerLengthAtOneWhenDecimalPlacesExceedTotalLength() {
        Test.startTest();
        Decimal value = StringGenerator.numeric(2, 5);
        Test.stopTest();

        // integerLength = Math.max(2 - 5, 1) = 1
        List<String> parts = String.valueOf(value).split('\\.');
        Assert.areEqual(1, parts[0].length(), 'Expected 1 integer digit but got: ' + parts[0]);
        Assert.areEqual(5, parts[1].length(), 'Expected 5 decimal places but got: ' + parts[1]);
    }

    // ── generate ─────────────────────────────────────────────────────────────

    @isTest
    static void shouldReturnOneCharWhenGenerateLengthIsZeroOrNegative() {
        Test.startTest();
        String zeroLength     = StringGenerator.generate(0, CharType.ALPHA);
        String negativeLength = StringGenerator.generate(-5, CharType.ALPHA);
        Test.stopTest();

        Assert.areEqual(1, zeroLength.length());
        Assert.areEqual(1, negativeLength.length());
    }

    @isTest
    static void shouldGenerateOnlyCharsFromProvidedCharSet() {
        String customChars = 'ABC123';
        Test.startTest();
        String value = StringGenerator.generate(30, customChars);
        Test.stopTest();

        Assert.areEqual(30, value.length());
        Assert.isTrue(value.containsOnly(customChars), 'Expected only chars from "' + customChars + '" but got: ' + value);
    }

}
