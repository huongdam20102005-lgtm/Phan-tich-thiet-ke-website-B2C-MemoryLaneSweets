package com.webbanbanh.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBUtils {
    
    // Tên của lớp driver SQL Server
    private static final String DRIVER_CLASS = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    
    // Logger để ghi lại lỗi chi tiết
    private static final Logger LOGGER = Logger.getLogger(DBUtils.class.getName());

    /**
     * Lấy giá trị cấu hình từ biến môi trường (Environment Variable) hoặc System Property.
     * @param envKey Tên biến môi trường (ví dụ: DB_HOST)
     * @param sysKey Tên thuộc tính hệ thống (ví dụ: db.host)
     * @param defaultValue Giá trị mặc định nếu không được thiết lập
     * @return Giá trị cấu hình
     */
    private static String getConfig(String envKey, String sysKey, String defaultValue) {
        String envVal = System.getenv(envKey);
        if (envVal != null && !envVal.trim().isEmpty()) {
            return envVal.trim();
        }
        String sysVal = System.getProperty(sysKey);
        if (sysVal != null && !sysVal.trim().isEmpty()) {
            return sysVal.trim();
        }
        return defaultValue;
    }

    /**
     * Xây dựng chuỗi URL kết nối CSDL từ các biến cấu hình.
     * @return JDBC URL string
     */
    public static String getDbUrl() {
        String host = getConfig("DB_HOST", "db.host", "localhost");
        String port = getConfig("DB_PORT", "db.port", "1433");
        String dbName = getConfig("DB_NAME", "db.name", "WebBanBanhDB");
        return "jdbc:sqlserver://" + host + ":" + port + ";databaseName=" + dbName + ";encrypt=false;trustServerCertificate=true;";
    }

    /**
     * Lấy tài khoản đăng nhập CSDL.
     * @return Database Username
     */
    public static String getDbUser() {
        return getConfig("DB_USER", "db.user", "sa");
    }

    /**
     * Lấy mật khẩu kết nối CSDL (mặc định để rỗng nếu chưa cấu hình).
     * @return Database Password
     */
    public static String getDbPassword() {
        return getConfig("DB_PASSWORD", "db.password", "");
    }

    /**
     * Phương thức lấy kết nối đến cơ sở dữ liệu.
     * @return Connection object
     * @throws SQLException nếu có lỗi kết nối
     */
    public static Connection getConnection() throws SQLException {
        Connection conn = null;
        
        try {
            // 1. Load Driver
            Class.forName(DRIVER_CLASS);
            
            // 2. Tạo kết nối từ cấu hình động
            String url = getDbUrl();
            String user = getDbUser();
            String pass = getDbPassword();
            
            conn = DriverManager.getConnection(url, user, pass);
            
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Lỗi: Không tìm thấy Driver JDBC.", e);
            throw new SQLException("Lỗi: Không tìm thấy Driver JDBC: " + e.getMessage());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "LỖI KẾT NỐI CSDL: Kiểm tra thông số kết nối CSDL trong biến môi trường (DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASSWORD).", e);
            throw e;
        }
        
        return conn;
    }
}