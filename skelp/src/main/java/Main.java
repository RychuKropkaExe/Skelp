import org.springframework.security.crypto.bcrypt.BCrypt;

import java.sql.*;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) throws SQLException {
        Connection con = Connections.getAuthConnection();
        Scanner scanner = new Scanner(System.in);

        while (true) {
            try {
                System.out.println("\nWhat do you want to do?");
                System.out.println("1 - Register, 2 - Log in, 3 - Change your password, 4 - Exit");

                int choice = Integer.parseInt(scanner.nextLine());

                switch (choice) {
                    case 1 -> {
                        System.out.print("\nName: ");
                        String name = scanner.nextLine();

                        System.out.print("Surname: ");
                        String surname = scanner.nextLine();

                        System.out.print("Login: ");
                        String login = scanner.nextLine();

                        System.out.print("Password: ");
                        String password = scanner.nextLine();

                        System.out.println("""
                            Choose account type:
                            1 - user, other - author
                            Your choice:\040""");

                        String type = Integer.parseInt(scanner.nextLine()) == 1 ? "user" : "author";

                        PreparedStatement command = con.prepareStatement("call checkLogin(?)");
                        command.setString(1, login);
                        ResultSet result = command.executeQuery();
                        result.next();

                        if (Boolean.parseBoolean(result.getString("result"))) {
                            System.out.println("Username is already taken");

                        } else {
                            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                            command = con.prepareStatement("call insertUser(?,?,?,?,?)");
                            command.setString(1, name);
                            command.setString(2, surname);
                            command.setString(3, login);
                            command.setString(4, hashedPassword);
                            command.setString(5, type);
                            command.executeQuery();
                        }
                    }
                    case 2 -> {
                        System.out.print("\nLogin: ");
                        String login = scanner.nextLine();

                        System.out.print("Password: ");
                        String password = scanner.nextLine();

                        PreparedStatement command = con.prepareStatement("call checkLogin(?)");
                        command.setString(1, login);
                        ResultSet result = command.executeQuery();
                        result.next();

                        int flag = Integer.parseInt(result.getString("result"));

                        if (flag == 1) {
                            command = con.prepareStatement("call getUserPassword(?)");
                            command.setString(1, login);
                            result = command.executeQuery();
                            result.next();
                            String returnedPassword = result.getString("password");

                            if (BCrypt.checkpw(password, returnedPassword)) {
                                command = con.prepareStatement("call getUserID(?)");
                                command.setString(1, login);
                                result = command.executeQuery();
                                result.next();

                                int id = Integer.parseInt(result.getString("id"));
                                command = con.prepareStatement("call getUserType(?)");
                                command.setInt(1, id);
                                result = command.executeQuery();
                                result.next();
                                String type = result.getString("type");

                                switch (type) {
                                    case "user" -> new Client(id);
                                    case "author" -> new Author(id);
                                    case "admin" -> new Admin(id);
                                }

                            } else {
                                System.out.println("Username or password is incorrect :(");
                            }
                        } else {
                            System.out.println("Username or password is incorrect :(");
                        }
                    }
                    case 3 -> {
                        System.out.print("\nLogin: ");
                        String login = scanner.nextLine();

                        System.out.print("Password: ");
                        String password = scanner.nextLine();

                        System.out.print("New password: ");
                        String newPassword = scanner.nextLine();

                        PreparedStatement command = con.prepareStatement("call getUserId(?)");
                        command.setString(1, login);

                        ResultSet result = command.executeQuery();

                        if(result.next()) {
                            command = con.prepareStatement("call getUserPassword(?)");
                            command.setString(1,login);
                            result = command.executeQuery();
                            result.next();

                            String returnedPassword = result.getString("password");

                            if (BCrypt.checkpw(password, returnedPassword)) {

                                String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
                                command = con.prepareStatement("call getUserID(?)");
                                command.setString(1, login);
                                result = command.executeQuery();
                                result.next();

                                int userID = Integer.parseInt(result.getString("id"));

                                command = con.prepareStatement("call changeUserPassword(?,?)");
                                command.setInt(1, userID);
                                command.setString(2, hashedPassword);
                                command.executeQuery();

                                System.out.println("Password changed successfully");

                            } else {
                                System.out.println("Wrong login or password provided");
                            }

                        } else {
                            System.out.println("Wrong login or password provided");
                        }
                    }
                    case 4 -> System.exit(0);
                    default -> System.out.println("Wrong command");
                }
            } catch (Exception ignored) {
            }
        }
    }
}