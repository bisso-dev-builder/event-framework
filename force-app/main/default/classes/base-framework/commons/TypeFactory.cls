public class TypeFactory {

    public static Object newInstance (String className, Type expectedType) {

        if (String.isEmpty(className)) return null;

        Type newType = Type.forName (className);

        if (newType == null || !newType.isAssignableFrom(expectedType)) return null;

		return newType.newInstance();

    }

}