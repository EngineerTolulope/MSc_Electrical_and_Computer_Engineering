/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Project_2;

/**
 *
 * @author tolugben
 */
public class Vigenere {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        int len_of_message = Message.length();
        char[] encoded = new char[len_of_message];
        char[] key = new char[len_of_message];

        Message.getChars(0, len_of_message, encoded, 0);
        int[] text = new int[len_of_message];
        int len = 0, j;

        double fit;

        for (j = 0; j < len_of_message; j++) {
            if (Character.isUpperCase(encoded[j])) {
                text[len++] = encoded[j] - 'A';
            }
        }

        fit = freq_every_nth(text, len, 4, key);
        System.out.printf("%f, key length: %2d, and ", fit, 4);
        System.out.println("The key is: " + new String(key));
        System.out.println("The Decrypted message is: " + decrypt(new String(encoded), new String(key).trim()));

    }

    static String Message = "OOFWGTXYE - FKVY MHIULX WTOGLE TH AMBELFS MV XAIAAPL, KQSDAAPL, ZQROLD AGK YUVO YOKL - FONJT NXHDLR LHEKF MSILOT HM PABSK LBMQ IG AADTF’E MHKQRG DAREK. FEVOZOEVSY BZ BOPLDEW UAT CBET UF EIEPOOG JTIIZ MNW LXEVADIVPFY, UBF BR ATE VYQAMPHIMF MNW PZGXUGIMF AF VVYPNAQR LJUEGAUSMZ IHH ADAGZXAML EOVPQTR’Z ZEXKE AGK IAGAE IGAA PKVPUVAE TAHF CTU UMIYAVX IATA ZACBLFY TUP TAL QCHUAMR.";

    final static double freq[] = {
        0.082, 0.015, 0.028, 0.043, 0.127, 0.022, 0.02,
        0.061, 0.07, 0.002, 0.008, 0.04, 0.024, 0.067,
        0.075, 0.019, 0.001, 0.06, 0.063, 0.091, 0.028,
        0.01, 0.024, 0.002, 0.02, 0.001
    };

    static String decrypt(String text, final String key) {
        String res = "";
        text = text.toUpperCase();
        for (int i = 0, j = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            if (c < 'A' || c > 'Z') {
                res += c;
                continue;
            }
            res += (char) ((c - key.charAt(j) + 26) % 26 + 'A');
            j = ++j % key.length();
        }
        return res;
    }

    static int BestMatch(final double[] a, final double[] b) {
        double sum = 0, fit, d, BestFit = 1e100;
        int i, rotate, BestRotate = 0;
        for (i = 0; i < 26; i++) {
            sum += a[i];
        }

        for (rotate = 0; rotate < 26; rotate++) {
            fit = 0;
            for (i = 0; i < 26; i++) {
                d = a[(i + rotate) % 26] / sum - b[i];
                fit += d * d / b[i];
            }

            if (fit < BestFit) {
                BestFit = fit;
                BestRotate = rotate;
            }
        }
        return BestRotate;
    }

    static double freq_every_nth(final int[] msg, int len, int interval, char[] key) {
        double sum, d, ret;
        double[] accu = new double[26];
        double[] out = new double[26];
        int i, j, rot;

        for (j = 0; j < interval; j++) {
            for (i = 0; i < 26; i++) {
                out[i] = 0;
            }

            for (i = j; i < len; i += interval) {
                out[msg[i]]++;
            }

            rot = BestMatch(out, freq);
            try {
                key[j] = (char) (rot + 'A');
            } catch (Exception e) {
                System.out.print(e.getMessage());
            }
            for (i = 0; i < 26; i++) {
                accu[i] += out[(i + rot) % 26];
            }
        }

        for (i = 0, sum = 0; i < 26; i++) {
            sum += accu[i];
        }

        for (i = 0, ret = 0; i < 26; i++) {
            d = accu[i] / sum - freq[i];
            ret += d * d / freq[i];
            System.out.println("The Fit is " + ret);
        }

        key[interval] = '\0';
        return ret;
    }
}
