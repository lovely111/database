package demo;

import com.mysql.jdbc.Driver;

import java.sql.*;


//JDBC Java DataBase Connectivity
public class DBTest {

    private static  final  String URL = "jdbc:mysql://localhost:3306/scott";
    private static  final  String USER = "root";
    private static  final  String PASSWORD = "system";

    public static void main(String[] args) { // CRUD
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            new Driver(); // 加载驱动
            connection = DriverManager.getConnection(URL, USER, PASSWORD); // 连接数据库
            String sqlInsert = "INSERT INTO scott.emp(EMPNO, ENAME) VALUES (?, ?)"; // SQL语句
            String sqlUpdate = "UPDATE scott.emp SET ename = ? WHERE empno = ?"; // SQL语句
            String sqlDelete = "DELETE FROM scott.emp WHERE empno = ?"; // SQL语句
            String sqlSelect = "SELECT * FROM scott.emp"; // SQL语句
            preparedStatement = connection.prepareStatement(sqlSelect); // 预编译语句
//            preparedStatement.setString(1, "李四 new");
//            preparedStatement.setString(1, "22222");
//            preparedStatement.executeUpdate(); // 执行一次更新
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                System.out.println(resultSet.getString("ename") + ", " + resultSet.getDouble("sal"));
            }
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
