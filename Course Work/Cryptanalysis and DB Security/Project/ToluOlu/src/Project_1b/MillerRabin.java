/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Project_1b;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Random;
import java.util.Scanner;

/**
 *
 * @author tolugben
 */
public class MillerRabin {

    public static void main(String[] args) {
        // TODO code application logic here
        Scanner sc = new Scanner(System.in);
        System.out.println("Miller Rabin Primality Algorithm Test\n");
        /**
         * Make an object of MillerRabin class *
         */
        MillerRabin mr = new MillerRabin();

        System.out.print("Insert the number of bits to be considered:- ");
        int numOfBits = sc.nextInt();

        SecureRandom secureRand = new SecureRandom();

        BigInteger n = BigInteger.valueOf(secureRand.nextInt((int) Math.pow(2, numOfBits)));
//        n = BigInteger.valueOf(1039);

        System.out.println("The large positive random number is:- " + n);

        BigInteger N = n.subtract(BigInteger.ONE);

        BigInteger q = N;
        BigInteger k = BigInteger.ZERO;
        while (q.mod(BigInteger.valueOf(2)).equals(BigInteger.ZERO)) {
            q = q.shiftRight(1);
            k = k.add(BigInteger.ONE);
        }

        /**
         * check if prime
         */
        boolean prime = mr.isPrime(n.longValue(), k.intValue());
        if (prime) {
            System.out.println("\n" + n + " is prime, returned " + prime);
        } else {
            System.out.println("\n" + n + " is composite, returned " + prime);
        }

    }

    /**
     * Function to check if prime or not *
     */
    public boolean isPrime(long n, int iteration) {
        /**
         * base case *
         */
        if (n == 0 || n == 1) {
            return false;
        }
        /**
         * base case - 2 is prime *
         */
        if (n == 2) {
            return true;
        }
        /**
         * an even number other than 2 is composite *
         */
        if (n % 2 == 0) {
            return false;
        }

        long s = n - 1;
        while (s % 2 == 0) {
            s /= 2;
        }

        Random rand = new Random();
        for (int i = 0; i < iteration; i++) {
            long r = Math.abs(rand.nextLong());
            long a = r % (n - 1) + 1, temp = s;
            long mod = modPow(a, temp, n);
            while (temp != n - 1 && mod != 1 && mod != n - 1) {
                mod = mulMod(mod, mod, n);
                temp *= 2;
            }
            if (mod != n - 1 && temp % 2 == 0) {
                return false;
            }
        }
        return true;
    }

    /**
     * Function to calculate (a ^ b) % c *
     */
    public long modPow(long a, long b, long c) {
        long res = 1;
        for (int i = 0; i < b; i++) {
            res *= a;
            res %= c;
        }
        return res % c;
    }

    /**
     * Function to calculate (a * b) % c *
     */
    public long mulMod(long a, long b, long mod) {
        return BigInteger.valueOf(a).multiply(BigInteger.valueOf(b)).mod(BigInteger.valueOf(mod)).longValue();
    }
}
