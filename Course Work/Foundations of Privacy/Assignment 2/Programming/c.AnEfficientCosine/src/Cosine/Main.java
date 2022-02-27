package Cosine;

import Cosine.Server.DataofServer;
import Cosine.Person.PersonalData;
import java.util.Scanner;

public class Main {
    //
    public static void main(String[] args) throws Exception {
        int k1=512, k2=200, k3=128, k4=128;
        Scanner sc = new Scanner(System.in);
        System.out.print("Input values of q, n(with spaces):- ");
        Person p = new Person(sc.nextInt(), sc.nextInt(), k1, k2, k3);    //Person(int q, int n, int k1, int k2, int k3)
        Server server = new Server(p.getQ(), p.getN(), k4);   //Server(int q, int n, int k4)
        //
        p.generate_vectors_a();
        server.generate_vectors_b();
        Main main = new Main();
        //
        System.out.println("Message:- " + main.real_execution(p.getA(), server.getB()));
        System.out.println("Computation:- "+main.demo(p, server));
    }
    //
    private void one(Person p) {
        p.process_p_data();
    }
    //
    private void two(PersonalData pdata, Server server) {
        server.DataProcessing(pdata);
    }
    //
    private double three(DataofServer data, Person p) {
        return p.calc(data);
    }
    //
    public double demo(Person p, Server server) {
        one(p);
        two(p.getPdata(), server);
        double num = three(server.getDataFromServer(), p);
        return num;
    }
    //
    public double real_execution(int[] a, int[] b) {
        int A = 0,B = 0;
        for (int i = 0; i < a.length; i++) {
            A += (a[i] * a[i]);
            B += (b[i] * b[i]);
        }
        //
        double amultb = 0;
        for (int i = 0; i < a.length; i++) {
            amultb = amultb + a[i] * b[i];
        }
        double result = amultb / (Math.sqrt(A) * Math.sqrt(B));
        return result;
    }
}
