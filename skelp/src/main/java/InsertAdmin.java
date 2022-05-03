import org.springframework.security.crypto.bcrypt.BCrypt;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class InsertAdmin {
    public static void main(String[] args) throws SQLException {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/skelp?noAccessToProcedureBodies=true", "root", "password");
        PreparedStatement statement = con.prepareStatement("call insertUser(?,?,?,?,?)");
        statement.setString(1, "Asia");
        statement.setString(2, "Asia");
        statement.setString(3, "ajzia");
        String password = BCrypt.hashpw("ummm", BCrypt.gensalt());
        statement.setString(4, password);
        statement.setString(5, "admin");
        statement.executeQuery();
    }
}