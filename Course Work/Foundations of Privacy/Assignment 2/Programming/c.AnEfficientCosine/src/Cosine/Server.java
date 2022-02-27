package Cosine;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Random;

import Cosine.Person.PersonalData;

public class Server {
    //
    public class DataofServer {
        BigInteger D;
        int B;
    }
    //
    private int q;
    private int n;
    private int k4;
    private int[] b;
    private BigInteger ri;
    private BigInteger[] D;
    private DataofServer dataofserver;
    //
    public DataofServer getDataFromServer() {
        return dataofserver;
    }
    //
    public int[] getB() {
        return b;
    }
    //
    public Server(int q, int n, int k4) {
        // TODO Auto-generated constructor stub
        this.q = q;
        this.n = n;
        this.k4 = k4;
    }
    //
    public void generate_vectors_b() {
        b = new int[n + 2];
        for (int i = 0; i < n; i++) {
            b[i] = new Random().nextInt(q);
        }
        b[n] = 0;
        b[n + 1] = 0;
    }
    //
    public void DataProcessing(PersonalData pdata) {
        dataofserver = new DataofServer();
        ri = new BigInteger(k4, new SecureRandom());
        D = new BigInteger[n + 2];
        for (int i = 0; i < n + 2; i++) {
            if (b[i] != 0) {
                D[i] = BigInteger.valueOf(b[i]).multiply(pdata.alpha).multiply(pdata.C[i]).mod(pdata.p);
            } else {
                D[i] = ri.multiply(pdata.C[i]).mod(pdata.p);
            }
        }
        dataofserver.B = 0;
        dataofserver.D = BigInteger.ZERO;
        //
        for (int i = 0; i < n; i++) {
            dataofserver.B += (b[i] * b[i]);
        }
        //
        for (int i = 0; i < n + 2; i++) {
            dataofserver.D = dataofserver.D.add(D[i]);
        }
        dataofserver.D = dataofserver.D.mod(pdata.p);
    }
}
