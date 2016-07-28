package demo;

import java.util.Calendar;
import java.util.Scanner;


// 输入某年某月某日，判断这一天是这一年的第几天
// 闰年： 西元年份除以400余数为0的，或者除以4为余数0且除以100余数不为0的，为闰年
public class E14 {

    private static int year;
    private static int month;
    private static int day;

    private static void getDate() {
        Scanner scanner = new Scanner(System.in);
        System.out.println("input year: ");
        year = scanner.nextInt();
        System.out.println("input month: ");
        month = scanner.nextInt();
        System.out.println("input day: ");
        day = scanner.nextInt();
    }

    private static boolean isLeapYear() {
        return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0);
    }

    private static int getDays() {
        int[] ints = {31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        ints[1] = isLeapYear() ? 29 : 28;
        int days = 0;
        for (int i = 0; i < month - 1; i++) {
            days += ints[i];
        }
        return days + day;
    }

    public static void main(String[] args) {
        getDate();
        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month - 1, day);
        System.out.println(calendar.get(Calendar.DAY_OF_YEAR));

        System.out.println(getDays());
    }
}
