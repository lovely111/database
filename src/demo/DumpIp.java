package demo;

import com.mysql.jdbc.Driver;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class DumpIp {

    private static final String FILE = "data/ip.txt";
    public static final java.lang.String URL = "jdbc:mysql:///db_ip?user=root&password=123456";
    private static final java.lang.String SQL = "INSERT INTO db_ip.ip VALUES(NULL, ?, ?, ?)";
    private static List<Ip> ips;

    private static void parse() {
        ips = new ArrayList<>();
        try (BufferedReader bufferedReader = new BufferedReader(new FileReader(FILE))) {
            String line, start, end, address;
            while ((line = bufferedReader.readLine()) != null) {
                start = line.split("\\s+")[0];
                end = line.split("\\s+")[1];
                address = line.replaceAll(start + "\\s+" + end, "").trim();
                Ip ip = new Ip(convert(start), convert(end), address);
                ips.add(ip);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static long convert(String ip) {
        // 6.2.55.177
        String[] strings = ip.split("\\.");
        ip = strings[0]; // 6
        for (int i=1; i<strings.length;i++) {
            if (strings[i].length() == 1) {
                ip += "00" + strings[i];
            }
            if (strings[i].length() == 2) {
                ip += "0" + strings[i];
            }
            if (strings[i].length() == 3) {
                ip += strings[i];
            }
        }
        return Long.parseLong(ip);
    }

    private static void dump() {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            new Driver();
            connection = DriverManager.getConnection(URL);
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(SQL);
            for (Ip ip : ips) {
                preparedStatement.setLong(1, ip.getStart());
                preparedStatement.setLong(2, ip.getEnd());
                preparedStatement.setString(3, ip.getAddress());
                preparedStatement.addBatch();
            }
            preparedStatement.executeBatch();
            connection.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
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

    public static void main(String[] args) {
        parse();
        long start = System.currentTimeMillis();
        dump();
        System.out.println((System.currentTimeMillis() - start) / 1000 + " seconds.");
    }
}

class Ip {
    private long start;
    private long end;
    private String address;

    public Ip(long start, long end, String address) {
        this.start = start;
        this.end = end;
        this.address = address;
    }

    public long getStart() {
        return start;
    }

    public void setStart(long start) {
        this.start = start;
    }

    public long getEnd() {
        return end;
    }

    public void setEnd(long end) {
        this.end = end;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}


