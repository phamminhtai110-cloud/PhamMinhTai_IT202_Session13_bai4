
USE RikkeiClinicDB;

DROP TRIGGER IF EXISTS PreventDoctorDoubleBooking_Insert;

DROP TRIGGER IF EXISTS PreventDoctorDoubleBooking_Update;

DELIMITER //

CREATE TRIGGER PreventDoctorDoubleBooking_Insert
BEFORE INSERT ON Appointments
FOR EACH ROW
BEGIN

    DECLARE total_conflict INT;

    -- Đếm số lịch bị trùng

    SELECT COUNT(*)
    INTO total_conflict
    FROM Appointments
    WHERE doctor_id = NEW.doctor_id
        AND appointment_date = NEW.appointment_date
        AND status <> 'Cancelled';

    -- Nếu có lịch trùng thì chặn

    IF total_conflict > 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Loi: Bac si da co lich hen vao khung gio nay';

    END IF;

END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER PreventDoctorDoubleBooking_Update
BEFORE UPDATE ON Appointments
FOR EACH ROW
BEGIN

    DECLARE total_conflict INT;

    -- Đếm lịch bị trùng
    -- loại chính nó ra khỏi kiểm tra

    SELECT COUNT(*)
    INTO total_conflict
    FROM Appointments
    WHERE doctor_id = NEW.doctor_id
        AND appointment_date = NEW.appointment_date
        AND status <> 'Cancelled'
        AND appointment_id <> NEW.appointment_id;

    -- Nếu có lịch trùng thì báo lỗi

    IF total_conflict > 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Loi: Bac si da co lich hen vao khung gio nay';

    END IF;

END //

DELIMITER ;

INSERT INTO Appointments (
    appointment_id,
    patient_id,
    doctor_id,
    appointment_date,
    status
)
VALUES (
    200,
    1,
    101,
    '2026-08-01 09:00:00',
    'Pending'
);


INSERT INTO Appointments (
    appointment_id,
    patient_id,
    doctor_id,
    appointment_date,
    status
)
VALUES (
    201,
    2,
    101,
    '2026-08-01 09:00:00',
    'Pending'
);

INSERT INTO Appointments (
    appointment_id,
    patient_id,
    doctor_id,
    appointment_date,
    status
)
VALUES (
    202,
    2,
    102,
    '2026-05-02 10:00:00',
    'Pending'
);


UPDATE Appointments
SET status = 'Completed'
WHERE appointment_id = 200;


SELECT *
FROM Appointments;