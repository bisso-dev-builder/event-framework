/**
 * @author eduardo.bisso - dev-builder
 */
@isTest
public class StringGeneratorTest {

    @isTest
    public static void shouldGenerateText () {
                      
        Test.startTest();
        
        String value = StringGenerator.text(10);

        String otherValue = StringGenerator.text(10);

        Assert.areEqual( 10 , value.length());

        Assert.areNotEqual( value , otherValue);
                
        Test.stopTest();

    }


    @isTest
    public static void shouldGenerateAlphaNumeric () {
                      
        Test.startTest();
        
        String value = StringGenerator.textWithNumbers(20);

        String otherValue = StringGenerator.textWithNumbers(20);

        System.debug( 'value = ' + value );
        System.debug( 'otherValue = ' + otherValue );
        
        Assert.areEqual( 20 , value.length());

        Assert.areNotEqual( value , otherValue);
                
        Test.stopTest();

    }


    @isTest
    public static void shouldGenerateNumber () {

        Test.startTest();
        
        Long value = StringGenerator.numeric(5);

        Long otherValue = StringGenerator.numeric(6);

        Assert.isTrue( value < otherValue );

        Test.stopTest();
        
    }

    @isTest
    public static void shouldGenerateDecimal () {

        Test.startTest();
        
        Decimal value = StringGenerator.numeric(5,2);

        Decimal otherValue = StringGenerator.numeric(6,2);

        Decimal valueWithoutDecimal = StringGenerator.numeric(6, null);

        Decimal otherValueWithoutDecimal = StringGenerator.numeric(6, -1);

        Assert.isTrue( value < otherValue );

        Test.stopTest();
    }

}