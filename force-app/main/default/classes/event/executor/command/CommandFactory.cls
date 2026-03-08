public class CommandFactory {
    
    public static Command newInstance(String className) {

		return (Command) TypeFactory.newInstance(className, Command.class);

	}

}