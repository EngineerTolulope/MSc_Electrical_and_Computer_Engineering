/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Project_1a;

import static java.lang.Math.abs;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Random;
import java.util.Scanner;


/**
 *
 * @author tolugben
 */
public class EEA_Inverse {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Scanner sc = new Scanner(System.in);
        System.out.print("Insert a value for a: ");
        int a = sc.nextInt();

        System.out.print("Insert a value for b: ");
        int b = sc.nextInt();
        
        System.out.println("The value of a is :- " + a);
        System.out.println("The value of b is :- " + b);
        
        int[] values;
        values = gcd(a, b);

        if (values[0] == 1) {
            int d = (values[2] % a + a) % a;
            int c = (values[1] % b + b) % b;

            System.out.println(" ( "+c+", "+ d +" )");
            System.out.println("The inverse of " + a + " with modulus " + b + " is:- " + c);
            System.out.println("The inverse of " + b + " with modulus " + a + " is:- " + d);
        } else {
            System.out.println("An inverse does not exist");
        }
    }

    static int[] gcd(int p, int q) {
        if (q == 0) {
            return new int[]{p, 1, 0};
        }

        int[] values = gcd(q, p % q);
        int d = values[0];
        int a = values[2];
        int b = values[1] - (p / q) * values[2];
        return new int[]{d, a, b};
    }
}
