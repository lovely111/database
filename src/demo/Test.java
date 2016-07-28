package demo;

import com.mysql.jdbc.Driver;

import java.sql.*;
import java.util.Scanner;


public class Test {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("input ip address: ");
        String ip = scanner.nextLine();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            new Driver();
            connection = DriverManager.getConnection(DumpIp.URL);
            String sql = "SELECT address FROM db_ip.ip WHERE ? BETWEEN start AND end";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setLong(1, DumpIp.convert(ip));
            resultSet = preparedStatement.executeQuery();
            resultSet.next();
            System.out.println("ip address: " + resultSet.getString("address"));
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
