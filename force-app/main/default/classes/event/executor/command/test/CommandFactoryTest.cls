@isTest
public class CommandFactoryTest {

    @isTest
    static void shouldReturnNullWhenClassNameIsEmpty() {

        // Dado (Given)
        String emptyClassName = '';

        // Quando (When)
        Command result = CommandFactory.newInstance(emptyClassName);

        // Então (Then)
        Assert.isTrue(result == null, 'Deveria retornar null quando o nome da classe está vazio.');

    }

    @isTest
    static void shouldReturnNullWhenClassNameIsNull() {
        // Dado (Given)
        String nullClassName = null;

        // Quando (When)
        Command result = CommandFactory.newInstance(nullClassName);

        // Então (Then)
        Assert.isTrue(result == null, 'Deveria retornar null quando o nome da classe é null.');
    }

    @isTest
    static void shouldCreateInstanceOfValidCommandClass() {
        // Dado (Given)
        String validClassName = 'CommandFixtureFactory.FakeCommand';

        // Quando (When)
        Command result = CommandFactory.newInstance(validClassName);

        // Então (Then)
        System.assert(result != null, 'Deveria criar uma instância válida para uma classe de comando válida.');
        System.assert(result instanceof CommandFixtureFactory.FakeCommand, 'A instância criada deveria ser do tipo TestCommand.');
    }

    @isTest
    static void shouldThrowExceptionForInvalidClassName() {
        // Dado (Given)
        String invalidClassName = 'InvalidCommandClass';

        Command command = CommandFactory.newInstance(invalidClassName);

        Assert.isNull( command , 'Deveria retornar null para uma tipo inválido' );

    }

}

