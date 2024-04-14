/**
 * @author eduardo.bisso - dev-builder
 */
public class CharType {
    
    public static final String NUMERIC = '0123456789';
    public static final String ALPHA_LOWER = 'abcdefghijklmnopqrstuvwxyz';
    public static final String ALPHA_UPPER = ALPHA_LOWER.toUpperCase();
    public static final String ALPHA = ALPHA_LOWER + ALPHA_UPPER;
    public static final String ALPHA_NUMERIC = NUMERIC + ALPHA;
    public static final String SPECIAL = '!@#$%:_';
    public static final String ALPHA_SPECIAL = ALPHA + SPECIAL;

}