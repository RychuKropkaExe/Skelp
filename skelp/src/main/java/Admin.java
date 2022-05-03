import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;

public class Admin {

    private final int id;
    private int authorID;

    String name, surname;
    Connection con;
    Scanner in;

    public Admin(int id) throws SQLException {
        this.id = id;

        con = Connections.getAdminConnection();

        PreparedStatement com = con.prepareStatement("call displayUserData(?)");
        com.setInt(1, id);
        ResultSet res = com.executeQuery();

        res.next();
        name = res.getString("name");
        surname = res.getString("surname");

        in = new Scanner(System.in);
        run();
    }

    private void run() throws SQLException {
        System.out.println("Welcome to admin console!");
        while (true) {
            System.out.println("\nWhat do you want to do?");
            System.out.println("1 - Display all books, 2 - Display author's books, 3 - Display publisher's books");
            System.out.println("4 - Display your data, 5 - Make new order, 6 - Display your orders");
            System.out.println("7 - Display content of your order, 8 - Add your book to shop");
            System.out.println("9 - Remove one of your books from shop, 10 - Remove author from database 11 - Remove book from database");
            System.out.println("12 - Remove genre from database, 13 - Remove publisher from database, 14 - Add author to database");
            System.out.println("15 - Add genre to database, 16 - Add publisher to database, 17 - Raise prices");
            System.out.println("18 - Lower prices, 19 - log out");

            int input = Integer.parseInt(in.nextLine());
            System.out.println();

            switch (input) {
                case 1 -> displayAllBooks();
                case 2 -> displayAuthorsBooks();
                case 3 -> displayPublishersBooks();
                case 4 -> displayUserData();
                case 5 -> insertOrder();
                case 6 -> displayUserOrders();
                case 7 -> displayOrderContent();
                case 8 -> addBook();
                case 9 -> removeAuthorsBook();
                case 10 -> deleteAuthor();
                case 11 -> deleteBook();
                case 12 -> deleteGenre();
                case 13 -> deletePublisher();
                case 14 -> addAuthor();
                case 15 -> addGenre();
                case 16 -> addPublisher();
                case 17 -> raise();
                case 18 -> sale();
                case 19 -> {
                    return;
                }
                default -> System.out.println("Wrong command!");
            } // switch
        }// while(true)
    } // run()

    public void displayAllBooks() throws SQLException {
        PreparedStatement command = con.prepareStatement("call displayAllBooks");
        ResultSet result = command.executeQuery();

        while (result.next()) {
            String id = result.getString("b.id");
            String title = result.getString("title");
            String genre = result.getString("genre");
            String author = result.getString("author");
            String publisher = result.getString("publisher");
            String price = result.getString("price");

            System.out.println(id + "      " + title + "      " + genre + "      " + author + "      " + publisher + "      " + price);
            System.out.println("********************************************************************" +
                "********************************************************************" +
                "********************************************************************");
        }
    }

    public void displayAuthorsBooks() throws SQLException {
        System.out.print("Choose author (ex. 'Jane Austen'): ");
        String[] info = in.nextLine().split(" ");
        int noa = info.length;

        if (noa == 2) {
            PreparedStatement command1 = con.prepareStatement("call getAuthorId(?,?)");
            command1.setString(1, info[0]);
            command1.setString(2, info[1]);
            ResultSet result = command1.executeQuery(); // id

            if (result.next()) {
                int id = Integer.parseInt(result.getString("id"));
                PreparedStatement command2 = con.prepareStatement("call displayAuthorsBooks(?)");
                command2.setInt(1, id);
                result = command2.executeQuery();

                while (result.next()) {
                    String book_id = result.getString("b.id");
                    String title = result.getString("title");
                    String genre = result.getString("genre");
                    String publisher = result.getString("publisher");
                    String price = result.getString("price");

                    System.out.println(book_id + "      " + title + "      " + genre + "      " + publisher + "      " + price);
                    System.out.println("********************************************************************" +
                        "********************************************************************" +
                        "********************************************************************");
                }
            } else {
                System.out.println("There is no such author");
            }

        } else {
            System.out.println("Failed attempt at displaying author's books");
        }
    }

    public void displayPublishersBooks() throws SQLException {
        System.out.print("Choose publisher (ex. 'Pearson'): ");
        String name = in.nextLine();

        PreparedStatement command1 = con.prepareStatement("call getPublisherId(?)");
        command1.setString(1, name);
        ResultSet result = command1.executeQuery(); // id

        if (result.next()) {
            int id = Integer.parseInt(result.getString("id"));
            PreparedStatement command2 = con.prepareStatement("call displayPublishersBooks(?)");
            command2.setInt(1, id);
            result = command2.executeQuery();

            while (result.next()) {
                String book_id = result.getString("b.id");
                String title = result.getString("title");
                String genre = result.getString("genre");
                String author = result.getString("author");
                String price = result.getString("price");

                System.out.println(book_id + "      " + title + "      " + genre + "      " + author + "      " + price);
                System.out.println("********************************************************************" +
                    "********************************************************************" +
                    "********************************************************************");
            }
        } else {
            System.out.println("There is no such publisher");
        }
    }

    public void displayUserData() throws SQLException {
        PreparedStatement command = con.prepareStatement("call displayUserData(?)");
        command.setInt(1, id);
        ResultSet result = command.executeQuery();
        result.next();

        String id = result.getString("id");
        String name = result.getString("name");
        String surname = result.getString("surname");
        String login = result.getString("login");
        String type = result.getString("type");

        System.out.println("id ---- name ---- surname ---- login ---- type");
        System.out.println(id + "      " + name + "      " + surname + "      " + login + "      " + type);
    }

    public void insertOrder() throws SQLException {
        boolean ordering = true;

        final ArrayList<Integer> books = new ArrayList<>();

        while (ordering) {
            System.out.print("1 - Add book to your order (by id), 2 - Finish your order");
            System.out.print("\nYour choice: ");
            switch (Integer.parseInt(in.nextLine())) {
                case 1 -> {
                    System.out.print("Book id: ");
                    int book = Integer.parseInt(in.nextLine());
                    books.add(book);
                }
                case 2 -> {
                    if (books.size() != 0) {
                        int value = 0;
                        for (Integer b : books) {
                            PreparedStatement command = con.prepareStatement("call getBookPrice(?)");
                            command.setInt(1, b);
                            ResultSet result1 = command.executeQuery();
                            result1.next();
                            value += Integer.parseInt(result1.getString("price"));
                        }

                        PreparedStatement command2 = con.prepareStatement("call insertOrder(?,?)");
                        command2.setInt(1, id);
                        command2.setInt(2, value);
                        ResultSet result2 = command2.executeQuery();
                        result2.next();
                        int order_id = Integer.parseInt(result2.getString("id"));

                        PreparedStatement command3 = con.prepareStatement("call insertBookOrder(?,?)");
                        command3.setInt(1, order_id);
                        for (Integer b : books) {
                            command3.setInt(2, b);
                            command3.executeQuery();
                        }

                        ordering = false;
                    } else {
                        System.out.println("Your order was empty!");
                        ordering = false;
                    }
                }
                default -> {
                }
            } // switch
        } // while
    }

    public void displayUserOrders() throws SQLException {
        PreparedStatement command = con.prepareStatement("call displayUserOrders(?)");
        command.setInt(1, id);
        ResultSet result = command.executeQuery();

        while (result.next()) {
            String id = result.getString("id");
            String date = result.getString("order_date");
            String value = result.getString("value");

            System.out.println("id: " + id + "      " + "value: " + value + "      " + "date: " + date);
        }
    }

    public void displayOrderContent() throws SQLException {
        System.out.print("Order id: ");
        int order_id = Integer.parseInt(in.nextLine());
        PreparedStatement command = con.prepareStatement("call displayOrderContent(?,?)");
        command.setInt(1, id);
        command.setInt(2, order_id);
        ResultSet result = command.executeQuery();

        while (result.next()) {
            String title = result.getString("title");
            String publisher = result.getString("publisher");
            String quantity = result.getString("quantity");

            System.out.println("title: " + title + "      " + "publisher: " + publisher + "      " + "quantity: " + quantity);
        }
    }

    private void addBook() {
        try {
            System.out.print("Choose book title (max 100 characters): ");
            String title = in.nextLine();
            if (title.length() > 100) {
                System.out.println("Too long title...");
                return;
            }

            System.out.println("Choose the book's genres");
            ArrayList<String> genres = new ArrayList<>();

            while (true) {
                System.out.println("1 - Add genre, 2 - Finish");
                int choice = Integer.parseInt(in.nextLine());

                if (choice == 1) {
                    System.out.print("Genre name: ");
                    genres.add(in.nextLine());

                } else if (choice == 2) {
                    break;
                }
            }

            System.out.print("Choose the book's authors: ");
            ArrayList<String> authorsNames = new ArrayList<>();
            ArrayList<String> authorsSurnames = new ArrayList<>();

            while (true) {
                System.out.println("1: Add author, 2:finish");
                int choice = Integer.parseInt(in.nextLine());

                if (choice == 1) {
                    System.out.print("Author's name:");
                    authorsNames.add(in.nextLine());

                    System.out.print("Author's surname");
                    authorsSurnames.add(in.nextLine());

                } else if (choice == 2) {
                    break;
                }
            }

            if (authorsNames.size() == 0) {
                System.out.println("You didn't add any author!");
                return;
            }

            System.out.print("Choose the book's publisher: ");
            String publisher = in.nextLine();

            System.out.print("Choose the book's price (note that it has to be between 13 and 2137): ");
            int price = Integer.parseInt(in.nextLine());

            if (!(price > 13 && price < 2137)) {
                System.out.println("Value out of range");
                return;
            }

            PreparedStatement command = con.prepareStatement("call insertBook(?,?,?)");
            command.setString(1, title);
            command.setString(2, publisher);
            command.setInt(3, price);
            ResultSet result = command.executeQuery();

            result.next();
            int returnedID = Integer.parseInt(result.getString("result"));

            for (int i = 0; i < authorsNames.size(); i++) {
                command = con.prepareStatement("call insertBookAuthor(?,?,?)");
                command.setInt(1, returnedID);
                command.setString(2, authorsNames.get(i));
                command.setString(3, authorsSurnames.get(i));
                command.executeQuery();
            }

            for (String genre : genres) {
                command = con.prepareStatement("call insertBookGenre(?,?)");
                command.setInt(1, returnedID);
                command.setString(2, genre);
                command.executeQuery();
            }
            System.out.println("Book successfully inserted!");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void removeAuthorsBook() throws SQLException {
        PreparedStatement command1;
        ResultSet result;

        int counter = 0;

        command1 = con.prepareStatement("call getAuthorId(?,?)");
        command1.setString(1, name);
        command1.setString(2, surname);
        result = command1.executeQuery(); // id

        if (result.next()) {
            authorID = Integer.parseInt(result.getString("id"));

            PreparedStatement command2 = con.prepareStatement("call displayAuthorsBooks(?)");
            command2.setInt(1, authorID);
            result = command2.executeQuery();

            while (result.next()) {
                counter++;

                String book_id = result.getString("b.id");
                String title = result.getString("title");
                String genre = result.getString("genre");
                String publisher = result.getString("publisher");
                String price = result.getString("price");

                System.out.println(book_id + "      " + title + "      " + genre + "      " + publisher + "      " + price);
                System.out.println("********************************************************************" +
                    "********************************************************************" +
                    "********************************************************************");
            }
        }
        if (counter == 0) {
            System.out.println("You have no books in our shop :(");
        } else {
            System.out.print("\nChoose book you'd like to delete (by id): ");
            try {
                int bookID = Integer.parseInt(in.nextLine());

                PreparedStatement command3 = con.prepareStatement("call deleteAuthorsBook(?,?)");
                command3.setInt(1, bookID);
                command3.setInt(2, authorID);
                result = command3.executeQuery();
                result.next();

                if (Integer.parseInt(result.getString("result")) == 1) {
                    System.out.println("Book successfully deleted");
                } else {
                    System.out.println("Wrong book id");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void deleteAuthor() throws SQLException {
        PreparedStatement command;
        ResultSet result;

        System.out.print("Author's name: ");
        String authorsName = in.nextLine();

        System.out.print("Authors surname: ");
        String authorsSurname = in.nextLine();

        command = con.prepareStatement("call getAuthorId(?,?)");
        command.setString(1, authorsName);
        command.setString(2, authorsSurname);
        result = command.executeQuery(); // id

        if (result.next()) {
            int returnedID = Integer.parseInt(result.getString("id"));
            command = con.prepareStatement("call deleteAuthor(?)");
            command.setInt(1, returnedID);
            command.executeQuery();

            System.out.println("Author successfully deleted!");

        } else {
            System.out.println("No such author in the database");
        }

    }

    private void deleteBook() throws SQLException {
        PreparedStatement command;
        ResultSet result;

        displayAllBooks();

        System.out.print("\nChoose book to delete (by id): ");
        int bookID = Integer.parseInt(in.nextLine());

        command = con.prepareStatement("call deleteBook(?)");
        command.setInt(1, bookID);
        result = command.executeQuery(); // id
        result.next();

        if (Integer.parseInt(result.getString("result")) == 1) {
            System.out.println("Book successfully deleted!");
        } else {
            System.out.println("No such book in the database");
        }

    }

    private void deleteGenre() throws SQLException {
        PreparedStatement command;
        ResultSet result;

        System.out.print("Genre name: ");
        String genreName = in.nextLine();

        command = con.prepareStatement("call getGenreId(?)");
        command.setString(1, genreName);
        result = command.executeQuery(); // id

        if (result.next()) {
            int returnedID = Integer.parseInt(result.getString("id"));
            command = con.prepareStatement("call deleteGenre(?)");
            command.setInt(1, returnedID);
            command.executeQuery();

            System.out.println("Genre successfully deleted!");

        } else {
            System.out.println("No such genre in the database");
        }
    }

    private void deletePublisher() throws SQLException {
        PreparedStatement command;
        ResultSet result;

        System.out.print("Publisher's name: ");
        String publisherName = in.nextLine();

        command = con.prepareStatement("call getPublisherId(?)");
        command.setString(1, publisherName);
        result = command.executeQuery(); // id

        if (result.next()) {
            int returnedID = Integer.parseInt(result.getString("id"));
            command = con.prepareStatement("call deletePublisher(?)");
            command.setInt(1, returnedID);
            command.executeQuery();

            System.out.println("Publisher successfully deleted!");
        } else {
            System.out.println("No such publisher in database");
        }

    }

    private void addAuthor() throws SQLException {
        PreparedStatement command1;
        ResultSet result;

        System.out.print("Authors name: ");
        String Aname = in.nextLine();

        System.out.print("Author's surname: ");
        String Asurname = in.nextLine();

        command1 = con.prepareStatement("call insertAuthor(?,?)");
        command1.setString(1, Aname);
        command1.setString(2, Asurname);
        result = command1.executeQuery(); // id
        result.next();

        if (Integer.parseInt(result.getString("result")) == 1) {
            System.out.println("Author added successfully!");
        } else {
            System.out.println("Author already exists");
        }

    }

    private void addGenre() throws SQLException {
        PreparedStatement command1;
        ResultSet result;

        System.out.print("Genre name: ");
        String genreName = in.nextLine();

        command1 = con.prepareStatement("call insertGenre(?)");
        command1.setString(1, genreName);
        result = command1.executeQuery(); // id
        result.next();

        if (Integer.parseInt(result.getString("result")) == 1) {
            System.out.println("Genre added successfully!");
        } else {
            System.out.println("Genre already exists");
        }

    }

    private void addPublisher() {
        try {
            PreparedStatement command1;

            System.out.print("Publisher's name: ");
            String publisherName = in.nextLine();

            command1 = con.prepareStatement("call insertPublisher(?)");
            command1.setString(1, publisherName);
            command1.executeQuery(); // id

            System.out.println("Publisher successfully added");

        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    private void raise() throws SQLException {
        PreparedStatement command1;
        ResultSet result;

        System.out.print("Percent value of raise: ");
        int percent = Integer.parseInt(in.nextLine());

        System.out.println("Publisher's name: ");
        String publisher = in.nextLine();

        command1 = con.prepareStatement("call getPublisherId(?)");
        command1.setString(1, publisher);
        result = command1.executeQuery();

        if (result.next()) {
            int publisherID = Integer.parseInt(result.getString("id"));
            command1 = con.prepareStatement("call raise(?,?)");
            command1.setInt(1, percent);
            command1.setInt(2, publisherID);
            result = command1.executeQuery();
            result.next();

            if (Integer.parseInt(result.getString("result")) == 1) {
                System.out.println("Operation was successful");
            } else {
                System.out.println("Prices were too high. Abort!");
            }

        } else {
            System.out.println("No such publisher");
        }
    }

    private void sale() throws SQLException {
        PreparedStatement command1;
        ResultSet result;

        System.out.print("Percent value of sale: ");
        int percent = Integer.parseInt(in.nextLine());
        if (percent > 100 || percent < 0) {
            System.out.println("value out of range");
            return;
        }

        System.out.print("Publisher's name: ");
        String publisher = in.nextLine();

        command1 = con.prepareStatement("call getPublisherId(?)");
        command1.setString(1, publisher);
        result = command1.executeQuery();

        if (result.next()) {
            int publisherID = Integer.parseInt(result.getString("id"));
            command1 = con.prepareStatement("call sale(?,?)");
            command1.setInt(1, percent);
            command1.setInt(2, publisherID);
            result = command1.executeQuery();
            result.next();

            if (Integer.parseInt(result.getString("result")) == 1) {
                System.out.println("Operation was successful");
            } else {
                System.out.println("Prices were too low. Abort!");
            }

        } else {
            System.out.println("No such publisher");
        }
    }

}
