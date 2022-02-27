/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.sql.*;
import javax.sql.*;
import newSQLTemplate.sql;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tolugben
 */
public class Main {

    public static void main(String args[]) {
        try { 
            String db = "jdbc:mysql://131.202.14.241:3306/historiandb";
            Connection con = DriverManager.getConnection(db,"smartgrid","historian");
        } catch (SQLException ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
}
