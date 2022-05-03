import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connections {

    public static Connection getAuthConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/skelp?noAccessToProcedureBodies=true", "auth", "thegreatcreator");
    }

    public static Connection getCustomerConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/skelp?noAccessToProcedureBodies=true", "client", "minion");
    }

    public static Connection getAuthorConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/skelp?noAccessToProcedureBodies=true", "author", "lessgreatcreator");
    }

    public static Connection getAdminConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/skelp?noAccessToProcedureBodies=true", "admin", "greatcreatorsslave");
    }
}