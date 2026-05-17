# PhamMinhTai_IT202_Session13_bai4

# [Vận dụng cơ bản 1] - Sự cố "Thất thoát tài chính" và "Tràn bộ nhớ"

# 1. Mô tả vấn đề

Hệ thống thương mại điện tử đang gặp 2 vấn đề:

- Tổng tiền đơn hàng bị lệch vài đồng lẻ.
- Bộ nhớ máy chủ đầy nhanh bất thường.

Đây là đoạn mã cũ của hệ thống:

```sql id="u4m8qp"
CREATE TABLE PRODUCTS (
    ID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Price DECIMAL(18, 2),
    Description TEXT
);
