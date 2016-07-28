package demo;

import java.util.HashSet;
import java.util.Set;


public class SetDemo {

    public static void main(String[] args) {

        HashSet<Student> hs=new HashSet<Student>();
        Student  s1=new Student(20,"w");
        Student  s2=new Student(20,"y");
        Student  s3=new Student(20,"z");
        Student  s4=new Student(20,"w");

        hs.add(s1);
        hs.add(s2);
        hs.add(s3);
        hs.add(s4);



        for (Student  s  :hs){
            System.out.println(s);
        }
    }


}

