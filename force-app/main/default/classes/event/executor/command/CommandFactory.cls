public class CommandFactory {
    
    public static Command newInstance(String className) {

        if (String.isEmpty(className)) { return null; }

		Type commandType = Type.forName (className);

		if (commandType == null) return null;

		return  (Command) commandType.newInstance();
	}

}