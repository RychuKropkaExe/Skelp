import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;

public class Author {

    private final int id;
    private int authorID;

    String name, surname;
    Connection con;
    Scanner in;

    public Author(int id) throws SQLException {
        this.id = id;

        con = Connections.getAuthorConnection();

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
        System.out.println("Hello, author!");
        while (true) {
            System.out.println("\nWhat do you want to do?");
            System.out.println("1 - Display all books, 2 - Display author's books, 3 - Display publisher's books");
            System.out.println("4 - Display your data, 5 - Make new order, 6 - Display your orders");
            System.out.println("7 - Display content of your order, 8 - Add your book to the shop");
            System.out.println("9 - Remove one of your books from the shop, 10 - Log out");

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
                case 8 -> addAuthorsBook();
                case 9 -> removeAuthorsBook();
                case 10 -> {
                    return;
                }
                default -> System.out.println("Wrong command!");
            } // switch
        } // while(true)
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

    private void addAuthorsBook() {
        try {
            System.out.print("Choose your books title (max 100 characters): ");

            String title = in.nextLine();

            if (title.length() > 100) {
                System.out.println("Too long title...");
                return;
            }

            System.out.println("Choose your book's genres");
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

            System.out.println("Add your book's authors (if necessary, you're the default author of your own book");

            ArrayList<String> authorsNames = new ArrayList<>();
            ArrayList<String> authorsSurnames = new ArrayList<>();

            authorsNames.add(name);
            authorsSurnames.add(surname);

            while (true) {
                System.out.println("1 - Add another author, 2 - Finish");
                int choice = Integer.parseInt(in.nextLine());

                if (choice == 1) {
                    System.out.print("Author's name: ");
                    authorsNames.add(in.nextLine());

                    System.out.print("Author's surname: ");
                    authorsSurnames.add(in.nextLine());

                } else if (choice == 2) {
                    break;
                }
            }

            System.out.print("Choose your book's publisher: ");
            String publisher = in.nextLine();

            System.out.print("Choose your book's price (note that it has to be between 13 and 2137): ");
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

}