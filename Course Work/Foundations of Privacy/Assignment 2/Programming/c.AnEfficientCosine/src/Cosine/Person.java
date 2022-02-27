package Cosine;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Random;

import Cosine.Server.DataofServer;

public class Person {
    //
    private final static int CERTAINTY = 80;
    //
    public class PersonalData {
        BigInteger alpha, p;    //large primes
        BigInteger[] C; 	//C1 C2 ... Cn 

        public PersonalData(int n) {
            // TODO Auto-generated constructor stub
            C = new BigInteger[n + 2];
        }
    }
    private int q, n, k1, k2, k3,A;
    private int[] a;    //vector a
    private BigInteger[] c; //generated random number
    private PersonalData pdata;
    private BigInteger s, inverseofs; 

    public int getQ() {
        return q;
    }

    public int getN() {
        return n;
    }

    public PersonalData getPdata() {
        return pdata;
    }

    public int[] getA() {
        return a;
    }

    public Person(int q, int n, int k1, int k2, int k3) {
        // TODO Auto-generated constructor stub
        this.q = q;
        this.n = n;
        this.k1 = k1;
        this.k2 = k2;
        this.k3 = k3;
    }
    //
    public void generate_vectors_a() { //vector generation for a
        a = new int[n + 2];
        for (int i = 0; i < n; i++) {
            a[i] = new Random().nextInt(q);
        }
        a[n] = 0;
        a[n + 1] = 0;
    }
    //
    public void process_p_data() {
        pdata = new PersonalData(n);
        pdata.p = new BigInteger(k1, CERTAINTY, new SecureRandom());
        pdata.alpha = new BigInteger(k2, CERTAINTY, new SecureRandom());
        //
        do {
            s = new BigInteger(pdata.p.bitLength(), new SecureRandom());
        } while (s.compareTo(pdata.p) >= 0 || s.gcd(pdata.p).intValue() != 1);
        //
        c = new BigInteger[n + 2];
        for (int i = 0; i < n + 2; i++) {
            c[i] = new BigInteger(k3, new SecureRandom());
        }
        //
        for (int i = 0; i < n + 2; i++) {
            if (a[i] != 0) {
                pdata.C[i] = s.multiply(BigInteger.valueOf(a[i]).multiply(pdata.alpha).add(c[i])).mod(pdata.p);                
            } else {
                pdata.C[i] = s.multiply(c[i]).mod(pdata.p);
            }
        }
        //
        A = 0;
        for (int i = 0; i < n; i++) {
            A += (a[i] * a[i]);
        }
        inverseofs = s.modInverse(pdata.p);
    }
    //
    public double calc(DataofServer data) {
        BigInteger E = inverseofs.multiply(data.D).mod(pdata.p);
        BigInteger alphasquared = pdata.alpha.multiply(pdata.alpha);
        double amultb = E.subtract(E.mod(alphasquared)).divide(alphasquared).doubleValue();
        return amultb / (Math.sqrt(A) * Math.sqrt(data.B));
    }
}
