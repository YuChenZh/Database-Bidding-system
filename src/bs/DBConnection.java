package bs;
// JDBC libraries

import javax.swing.plaf.nimbus.State;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// JDK libraries
import java.util.ArrayList;
import java.util.DoubleSummaryStatistics;

public class DBConnection {
    // DB connection properties
    private static final String driver = "oracle.jdbc.driver.OracleDriver";
    private static final String jdbc_url = "jdbc:oracle:thin:@apollo.vse.gmu.edu:1521:ite10g";

    // IMPORTANT: DO NOT PUT YOUR LOGIN INFORMATION HERE. INSTEAD, PROMPT USER FOR HIS/HER LOGIN/PASSWD
    private String username;
    private String password;
    private String schema;

    /**
     * Default constructor
     */
    public DBConnection(String name, String pwd) {
        this.username = name;
        this.password = pwd;
        this.schema = name.toUpperCase();
    }
    public boolean connected(){
        if (this.getConnection()==null) return false;
        return true;
    }

    /**
     * Method to get the connection for the database
     *
     * @return java.sql.Connection object
     */
    public Connection getConnection() {
        // register the JDBC driver
        boolean failed=false;
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection connection = null;
        try {
            connection = DriverManager.getConnection(jdbc_url, username, password);
        } catch (SQLException e) {
            failed=true;
        }
        if (failed) return null;
        return connection;
    }

    private boolean doesTableExist(Connection connection, String table) throws SQLException {
        boolean bTableExists = false;

        // check the meta data of the connection
        DatabaseMetaData dmd = connection.getMetaData();
        ResultSet rs = dmd.getTables(null, null, table.toUpperCase(), null);
        while (rs.next()) {
            bTableExists = true;
        }
        rs.close(); // close the result set
        return bTableExists;
    }
    /*
    public double getMaxBid(String listing_id,Connection c) throws SQLException {
        StringBuilder query=new StringBuilder();
        query.append("SELECT MAX(amount) AS M FROM BID WHERE listing_id='");
        query.append(listing_id);
        query.append("'");
        Statement statement=c.createStatement();
        ResultSet rs=statement.executeQuery(query.toString());
        rs.next();
        double maxbid=rs.getDouble("M");
        statement.close();
        rs.close();
        c.close();
        return maxbid;
    }
    public double getStartBid(String listing_id,Connection c) throws SQLException {
        StringBuilder query=new StringBuilder();
        query.append("SELECT start_bid FROM LISTING WHERE listing_id='");
        query.append(listing_id);
        query.append("'");
        Statement statement=c.createStatement();
        ResultSet rs=statement.executeQuery(query.toString());
        rs.next();
        double start_bid=rs.getDouble("start_bid");
        statement.close();
        rs.close();
        c.close();
        return start_bid;
    }
    public boolean isBidLegal(String bid, String listing_id) throws SQLException {
        double amount=Double.valueOf(bid);
        return amount>this.getStartBid(listing_id,this.getConnection())&&amount>this.getMaxBid(listing_id,this.getConnection());
    }*/
    public ArrayList<String> getTableNames(){
        ArrayList<String> result=new ArrayList<>();
        result.add("BELONGS_TO");
        result.add("CONTAINS");
        result.add("CATAGORY");
        result.add("PRODUCT");
        result.add("COMPLETED_TRANSACTION");
        result.add("LISTS");
        result.add("BID");
        result.add("USERS");
        result.add("LISTING");
        result.add("COMMENTS");
        return result;
    }

    public ArrayList<String> getColumnsName(String table,Connection c) throws SQLException {
        String name = table.toUpperCase();
        ArrayList<String> result = new ArrayList<String>();
        DatabaseMetaData dmd = c.getMetaData();
        if (!doesTableExist(c, name)) return null;
        ResultSet rs = dmd.getColumns("", schema, name, null);
        while (rs.next())
            result.add(rs.getString(4));
        c.close();
        rs.close();
        return result;
    }

    public ArrayList<String> viewTable(String table, ArrayList<String> col,Connection c) throws SQLException {
        String name = table.toUpperCase();
        StringBuffer sb = new StringBuffer();
        sb.append("SELECT * FROM ");
        sb.append(name);
        if (!doesTableExist(c, name)) return null;
        ArrayList<String> result = new ArrayList<>();
        ResultSet rs;
        Statement statement = c.createStatement();
        System.out.println(sb.toString());
        rs = statement.executeQuery(sb.toString());
        if (rs != null) {
            while (rs.next()) {
                for (int i = 0; i < col.size(); i++) {
                    result.add(rs.getString(col.get(i)));
                }
            }

        }
        rs.close();
        statement.close();
        c.close();
        return result;
    }
    public ArrayList<String> viewTableWithCond(String table, ArrayList<String> col,String lcond,String rcond,Connection c) throws SQLException {
        String name = table.toUpperCase();
        StringBuffer sb = new StringBuffer();
        sb.append("SELECT * FROM ");
        sb.append(name);
        sb.append(" WHERE ");
        sb.append(lcond);
        sb.append("=");
        sb.append(rcond);
        if (!doesTableExist(c, name)) return null;
        ArrayList<String> result = new ArrayList<>();
        ResultSet rs;
        Statement statement = c.createStatement();
        System.out.println(sb.toString());
        rs = statement.executeQuery(sb.toString());

        if (rs != null) {
            while (rs.next()) {
                for (int i = 0; i < col.size(); i++) {
                    result.add(rs.getString(col.get(i)));
                }
            }

        }
        rs.close();
        statement.close();
        c.close();
        return result;
    }
    public ArrayList<String> viewTableWithQuery(String table, ArrayList<String> col,String query,Connection c) throws SQLException {
        String name = table.toUpperCase();
        if (!doesTableExist(c, name)) return null;
        ArrayList<String> result = new ArrayList<>();
        ResultSet rs;
        Statement statement = c.createStatement();
        System.out.println(query);
        rs = statement.executeQuery(query);
        if (rs != null) {
            while (rs.next()) {
                for (int i = 0; i < col.size(); i++) {
                    result.add(rs.getString(col.get(i)));
                }
            }

        }
        rs.close();
        statement.close();
        c.close();
        return result;
    }

    public static final String insertStatementBuilder(String table, ArrayList<String> elements){
        StringBuilder sb=new StringBuilder();
            sb.append("INSERT INTO ");
            sb.append(table.toUpperCase());
            sb.append(" VALUES (");
            for (int i=0;i<elements.size()-1;i++){
                sb.append(elements.get(i));
                sb.append(", ");
            }
            sb.append(elements.get(elements.size()-1));
            sb.append(")");
        return sb.toString();
    }
    public static final String updateStatementBuilder(String table, String setAttrs,String value, String leftCond, String rightCond){
        StringBuilder sb=new StringBuilder();
        sb.append("UPDATE ");
        sb.append(table.toUpperCase());
        sb.append(" SET ");
        sb.append(setAttrs);
        sb.append("=");
        sb.append(value);
        sb.append(" WHERE ");
        sb.append(leftCond);
        sb.append(" = ");
        sb.append(rightCond);
        return sb.toString();
    }
    public static final String deleteStatementBuilder(String table, String leftCond,String rightCond){
        StringBuilder sb=new StringBuilder();
        sb.append("DELETE FROM ");
        sb.append(table);
        sb.append("WHERE ");
        sb.append(leftCond);
        sb.append(" = ");
        sb.append(rightCond);
        return sb.toString();
    }
    public ResultSet exec(String statement,Connection c) throws SQLException {
        if (statement==null) return null;
        ResultSet rs;
        Statement s=c.createStatement();
        rs=s.executeQuery(statement);
        c.close();
        s.close();
        return rs;
    }
    public static final String strToDate(String date){
        StringBuilder sb=new StringBuilder();
        String fmt="'YYYY-MM-DD'";
        sb.append("TO_DATE( '");
        sb.append(date);
        sb.append("', ");
        sb.append(fmt);
        sb.append(")");
        return sb.toString();
    }
    public static final String strToStr(String str){
        StringBuilder sb=new StringBuilder();
        sb.append("'");
        sb.append(str);
        sb.append("'");
        return sb.toString();
    }
    public static final String doubleToStr(String str){
        double d=Double.valueOf(str);
        return String.format("%.2f",d);
    }
    public static final void updateOnUser(Connection c) throws SQLException {
        String query="select * from USERS";
        Statement st=c.createStatement();
        ResultSet rs=st.executeQuery(query);
        while (rs.next()){
            Statement s;
            String id=rs.getString("ID");
            String q="select AVG(rate) as A from COMMENTS WHERE RATEE='"+id+"'";
            s=c.createStatement();
            ResultSet r=s.executeQuery(q);
            r.next();
            double avg=r.getDouble("A");
            q="update USERS SET AVG_RATING="+avg+"WHERE ID='"+id+"'";
            s.close();
            s=c.createStatement();
            r=s.executeQuery(q);
            r.close();
        }
        st.close();
        rs.close();
        c.close();
    }

    public boolean delete(String pk,String spk,String table,Connection c) throws SQLException {
        StringBuilder sb=new StringBuilder();
        sb.append("DELETE FROM ");
        sb.append(table);
        sb.append(" WHERE ");
        if (table.toUpperCase().equals("USERS")){
            sb.append("ID=");
            sb.append(strToStr(pk));
        }
        if (table.toUpperCase().equals("LISTING")){
            sb.append("LISTING_ID=");
            sb.append(strToStr(pk));
        }
        if (table.toUpperCase().equals("BID")){
            sb.append("LISTING_ID=");
            sb.append(strToStr(pk));
            sb.append(" AND AMOUNT=");
            sb.append(spk);
        }
        Statement st=c.createStatement();
        System.out.println(sb.toString());
        ResultSet rs=st.executeQuery(sb.toString());

        st.close();
        rs.close();
        c.close();
        return true;
    }

}
