public interface Command {
    
    void callout (EventQueue event);

    void executeUpdate (EventQueue event);

}