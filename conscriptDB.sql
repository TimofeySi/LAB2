DROP DATABASE IF EXISTS conscriptDB;
CREATE DATABASE conscriptDB;
USE conscriptDB;

############################################# Создание таблиц #############################################

######################################## Таблицы без зависимостей #########################################

#Военный билет
CREATE TABLE military_id (
	id INT UNSIGNED AUTO_INCREMENT,
    series VARCHAR(2) NOT NULL,
    num INT NOT NULL,
    PRIMARY KEY(id)
);

#Звание
CREATE TABLE title (
	id INT UNSIGNED AUTO_INCREMENT,
    rank_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

#Род войск
CREATE TABLE type_of_army (
	id INT UNSIGNED AUTO_INCREMENT,
    typename VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

#Образование
CREATE TABLE education (
	id INT UNSIGNED AUTO_INCREMENT,
    education_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

#ФИО
CREATE TABLE fullname (
	id INT UNSIGNED AUTO_INCREMENT,
    firstname VARCHAR(255) NOT NULL,
    secondname VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

#ФИО родственника
CREATE TABLE fullname_r (
	id INT UNSIGNED AUTO_INCREMENT,
    firstname VARCHAR(255) NOT NULL,
    secondname VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

#Родство
CREATE TABLE kinship (
	id INT UNSIGNED AUTO_INCREMENT,
	kinship_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

#Учреждение
CREATE TABLE institution (
	id INT UNSIGNED AUTO_INCREMENT,
    inst_name VARCHAR(255) NOT NULL,
    state_accreditation BOOLEAN,
	field_of_activity TEXT NOT NULL,
    PRIMARY KEY(id)
);

#Категория
CREATE TABLE category (
	id INT UNSIGNED AUTO_INCREMENT,
    category_name CHAR NOT NULL,
    PRIMARY KEY(id)
);

#Пол
CREATE TABLE sex (
	id INT UNSIGNED AUTO_INCREMENT,
    sex_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

#Национальность
CREATE TABLE nationality (
	id INT UNSIGNED AUTO_INCREMENT,
    nationality_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

#Тип службы
CREATE TABLE service_type (
	id INT UNSIGNED AUTO_INCREMENT,
    service_type_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

#Регион
CREATE TABLE region (
	id INT UNSIGNED AUTO_INCREMENT,
    region_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

#Сезон
CREATE TABLE season (
	id INT UNSIGNED AUTO_INCREMENT,
    season_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

#Воинская часть
CREATE TABLE military_unit (
	id INT UNSIGNED AUTO_INCREMENT,
    military_unit_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(id)
);

#Мед статус
CREATE TABLE medical_status (
	id INT UNSIGNED AUTO_INCREMENT,
    status_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

#Семейное положение
CREATE TABLE family_status (
	id INT UNSIGNED AUTO_INCREMENT,
    family_status_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

#Тип семьи
CREATE TABLE family_type (
	id INT UNSIGNED AUTO_INCREMENT,
    family_type_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

######################################## /Таблицы без зависимостей #########################################

####################################### Таблицы с 1-2 зависимостями ########################################

#Хирург
CREATE TABLE surgeon (
	id INT UNSIGNED AUTO_INCREMENT,
    conclusion_id INT UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY(id),
    FOREIGN KEY (conclusion_id) REFERENCES category (id) ON DELETE CASCADE
);

#Терапевт
CREATE TABLE therapist (
	id INT UNSIGNED AUTO_INCREMENT,
    conclusion_id INT UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY(id),
    FOREIGN KEY (conclusion_id) REFERENCES category (id) ON DELETE CASCADE
);

#Невролог
CREATE TABLE neurologist (
	id INT UNSIGNED AUTO_INCREMENT,
    conclusion_id INT UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY(id),
    FOREIGN KEY (conclusion_id) REFERENCES category (id) ON DELETE CASCADE
);

#Психиатр
CREATE TABLE psychiatrist (
	id INT UNSIGNED AUTO_INCREMENT,
    conclusion_id INT UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY(id),
    FOREIGN KEY (conclusion_id) REFERENCES category (id) ON DELETE CASCADE
);

#Офтальмолог
CREATE TABLE ophthalmologist (
	id INT UNSIGNED AUTO_INCREMENT,
    conclusion_id INT UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY(id),
    FOREIGN KEY (conclusion_id) REFERENCES category (id) ON DELETE CASCADE
);

#Стоматолог
CREATE TABLE dentist (
	id INT UNSIGNED AUTO_INCREMENT,
    conclusion_id INT UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY(id),
    FOREIGN KEY (conclusion_id) REFERENCES category (id) ON DELETE CASCADE
);

#ЛОР
CREATE TABLE otorhinolaryngologist (
	id INT UNSIGNED AUTO_INCREMENT,
    conclusion_id INT UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY(id),
    FOREIGN KEY (conclusion_id) REFERENCES category (id) ON DELETE CASCADE
);

#Занятость
CREATE TABLE employment (
	id INT UNSIGNED AUTO_INCREMENT,
    institution_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (institution_id) REFERENCES institution (id) ON DELETE CASCADE
);

#Адрес
CREATE TABLE address (
	id INT UNSIGNED AUTO_INCREMENT,
    region_id INT UNSIGNED NOT NULL,
    city VARCHAR(255) NOT NULL,
    street VARCHAR(255) NOT NULL,
    house_num SMALLINT UNSIGNED NOT NULL,
    apartment_num SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (region_id) REFERENCES region (id) ON DELETE CASCADE
);

#Семья
CREATE TABLE family (
	id INT UNSIGNED AUTO_INCREMENT,
    family_type_id INT UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY(id),
    FOREIGN KEY (family_type_id) REFERENCES family_type (id) ON DELETE CASCADE
);

#Призыв
CREATE TABLE conscription (
	id INT UNSIGNED AUTO_INCREMENT,
    military_unit_id INT UNSIGNED NOT NULL,
    season_id INT UNSIGNED NOT NULL,
    conscription_year SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (military_unit_id) REFERENCES military_unit (id) ON DELETE CASCADE,
    FOREIGN KEY (season_id) REFERENCES season (id) ON DELETE CASCADE
);

####################################### /Таблицы с 1-2 зависимостями #######################################

################################## Таблицы с множественными зависимостями ##################################

#Мед заключение
CREATE TABLE medical_report (
	id INT UNSIGNED AUTO_INCREMENT,
    surgeon_id INT UNSIGNED NOT NULL,
    therapist_id INT UNSIGNED NOT NULL,
    neurologist_id INT UNSIGNED NOT NULL,
    psychiatrist_id INT UNSIGNED NOT NULL,
    ophthalmologist_id INT UNSIGNED NOT NULL,
    dentist_id INT UNSIGNED NOT NULL,
    otorhinolaryngologist_id INT UNSIGNED NOT NULL,
    medical_status_id INT UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY(id),
    FOREIGN KEY (surgeon_id) REFERENCES surgeon (id) ON DELETE CASCADE,
    FOREIGN KEY (therapist_id) REFERENCES therapist (id) ON DELETE CASCADE,
    FOREIGN KEY (neurologist_id) REFERENCES neurologist (id) ON DELETE CASCADE,
    FOREIGN KEY (psychiatrist_id) REFERENCES psychiatrist (id) ON DELETE CASCADE,
    FOREIGN KEY (ophthalmologist_id) REFERENCES ophthalmologist (id) ON DELETE CASCADE,
    FOREIGN KEY (dentist_id) REFERENCES dentist (id) ON DELETE CASCADE,
    FOREIGN KEY (otorhinolaryngologist_id) REFERENCES otorhinolaryngologist (id) ON DELETE CASCADE,
    FOREIGN KEY (medical_status_id) REFERENCES medical_status (id) ON DELETE CASCADE
);

#Персональные данные
CREATE TABLE personal_information (
	id INT UNSIGNED AUTO_INCREMENT,
    fullname_id INT UNSIGNED NOT NULL,
    date_of_birth DATETIME NOT NULL,                                                        
    address_id INT UNSIGNED NOT NULL,
    family_status_id INT UNSIGNED NOT NULL,
    family_id INT UNSIGNED NOT NULL,
    sex_id INT UNSIGNED NOT NULL,
    nationality_id INT UNSIGNED NOT NULL,
    employment_id INT UNSIGNED NOT NULL,
    age SMALLINT UNSIGNED NOT NULL,
    criminal_record BOOLEAN NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (fullname_id) REFERENCES fullname (id) ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES address (id) ON DELETE CASCADE, 
    FOREIGN KEY (family_status_id) REFERENCES family_status (id) ON DELETE CASCADE,
    FOREIGN KEY (family_id) REFERENCES family (id) ON DELETE CASCADE,
    FOREIGN KEY (sex_id) REFERENCES sex (id) ON DELETE CASCADE,
    FOREIGN KEY (nationality_id) REFERENCES nationality (id) ON DELETE CASCADE,
    FOREIGN KEY (employment_id) REFERENCES employment (id) ON DELETE CASCADE
);

#Персональные данные родственника
CREATE TABLE personal_information_r (
	id INT UNSIGNED AUTO_INCREMENT,
    fullname_id INT UNSIGNED NOT NULL,
    date_of_birth DATETIME NOT NULL,                                                          
    address_id INT UNSIGNED NOT NULL,
    sex_id INT UNSIGNED NOT NULL,
    nationality_id INT UNSIGNED NOT NULL,
    education_id INT UNSIGNED NOT NULL,
    age SMALLINT UNSIGNED NOT NULL,
    criminal_record BOOLEAN NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (fullname_id) REFERENCES fullname_r (id) ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES address (id) ON DELETE CASCADE,
    FOREIGN KEY (sex_id) REFERENCES sex (id) ON DELETE CASCADE,
    FOREIGN KEY (nationality_id) REFERENCES nationality (id) ON DELETE CASCADE,
    FOREIGN KEY (education_id) REFERENCES education (id) ON DELETE CASCADE
);

#Состав семьи
CREATE TABLE family_composition (
    family_id INT UNSIGNED NOT NULL,
    kinship_id INT UNSIGNED NOT NULL,                                                      
    relative_id INT UNSIGNED NOT NULL,
    order_of_kinship TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (family_id) REFERENCES family (id) ON DELETE CASCADE,
    FOREIGN KEY (kinship_id) REFERENCES kinship (id) ON DELETE CASCADE,                      
    FOREIGN KEY (relative_id) REFERENCES personal_information_r (id) ON DELETE CASCADE
);

#Личное дело
CREATE TABLE private_bussiness (
	id INT UNSIGNED AUTO_INCREMENT,
    personal_information_id INT UNSIGNED NOT NULL,
    medical_report_id INT UNSIGNED NOT NULL,                                                      
    date_of_registration DATETIME NOT NULL,                                                    
    deregistration_date DATETIME NOT NULL,                                                      
    category_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (personal_information_id) REFERENCES personal_information (id) ON DELETE CASCADE,
    FOREIGN KEY (medical_report_id) REFERENCES medical_report (id) ON DELETE CASCADE,                                 
    FOREIGN KEY (category_id) REFERENCES category (id) ON DELETE CASCADE
);

#Призывник
CREATE TABLE conscript (
	id INT UNSIGNED AUTO_INCREMENT,
    private_bussiness_id INT UNSIGNED NOT NULL,                                                    
    title_id INT UNSIGNED NOT NULL,                                                
    type_of_army_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (private_bussiness_id) REFERENCES private_bussiness (id) ON DELETE CASCADE,                                   
    FOREIGN KEY (title_id) REFERENCES title (id) ON DELETE CASCADE,                     
    FOREIGN KEY (type_of_army_id) REFERENCES type_of_army (id) ON DELETE CASCADE
);

#Состав призыва
CREATE TABLE composition_of_conscription (
	id INT UNSIGNED AUTO_INCREMENT,
    service_type_id INT UNSIGNED NOT NULL,
	conscript_id INT UNSIGNED NOT NULL,                                                                                               
    date_of_enlistment DATE NOT NULL,          													                                               
    end_date_of_enlistment DATE NOT NULL,          													                                               
    PRIMARY KEY(id),
    FOREIGN KEY (service_type_id) REFERENCES service_type (id) ON DELETE CASCADE,
    FOREIGN KEY (conscript_id) REFERENCES conscript (id) ON DELETE CASCADE                                        
);
#Выданные билеты
CREATE TABLE issued_military_id (
	id INT UNSIGNED AUTO_INCREMENT,
    military_id INT UNSIGNED NOT NULL,
	conscript_id INT UNSIGNED NOT NULL,                                                                                                      													                                               
    PRIMARY KEY(id),
    FOREIGN KEY (military_id) REFERENCES military_id (id) ON DELETE CASCADE,
    FOREIGN KEY (conscript_id) REFERENCES conscript (id) ON DELETE CASCADE                                        
);
################################# /Таблицы с множественными зависимостями ##################################

############################################# /Создание таблиц #############################################

################################################# Триггеры #################################################

#Если прошло условно n лет с момента снятия с учета то, при следующем добавлении, удаляется данные об этом призывнике
DELIMITER //

CREATE TRIGGER conscription_INSERT
AFTER INSERT
ON conscription
FOR EACH ROW
BEGIN
	DELETE FROM fullname WHERE id IN (
		SELECT fullname_id FROM personal_information pi 
        INNER JOIN private_bussiness 
        ON pi.id=personal_information_id
        WHERE YEAR(deregistration_date) <= YEAR(NOW()) - 5
	);
END //

DELIMITER ;

# Ограничение на то, что дата постановки на учет не может быть больше или равна дате призыва
DELIMITER //
/*
CREATE TRIGGER private_bussiness_INSERT
BEFORE INSERT
ON private_bussiness
FOR EACH ROW
BEGIN
    IF NEW.date_of_registration >= NEW.deregistration_date THEN
        SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT  = 'date_of_registration must be less than deregistration_date';
    END IF;
END //
*/
DELIMITER ;

#«Проверка даты призыва» - триггер проверяет, что указанная дата призыва находится в допустимых пределах (например, не раньше 18-летнего возраста призывника и не позднее законной возрастной границы).
DELIMITER //
CREATE TRIGGER conscript_INSERT
BEFORE INSERT
ON conscript
FOR EACH ROW
BEGIN
	IF 18 > (
		SELECT YEAR(date_of_registration) - YEAR(date_of_birth) FROM personal_information pi
		INNER JOIN private_bussiness pb ON pi.id=personal_information_id
		WHERE pb.id=NEW.private_bussiness_id
    ) THEN
		SIGNAL SQLSTATE '45000' 
				SET MESSAGE_TEXT  = 'age at the time of registration must be over 18 years old';
	END IF;
	IF 27 < (
		SELECT YEAR(date_of_registration) - YEAR(date_of_birth) FROM personal_information pi
        INNER JOIN private_bussiness pb ON pi.id=personal_information_id
		WHERE pb.id=NEW.private_bussiness_id
    ) THEN
		SIGNAL SQLSTATE '45000' 
				SET MESSAGE_TEXT  = 'age at the time of registration must be less 27 years old';
	END IF;
END //

DELIMITER ;

#Случайное заполнение заключения докторов
DELIMITER //

CREATE TRIGGER surgeon_INSERT
BEFORE INSERT
ON surgeon
FOR EACH ROW
BEGIN
	DECLARE first_half INT;
	DECLARE second_half INT;
	SET first_half=FLOOR(RAND()*(11 -1) + 1);
    IF 0 < first_half AND first_half < 5 THEN SET second_half=(SELECT id FROM category WHERE category_name='А');
    ELSEIF 4 < first_half AND first_half < 7 THEN SET second_half=(SELECT id FROM category WHERE category_name='Б');
    ELSEIF 6 < first_half AND first_half < 9 THEN SET second_half=(SELECT id FROM category WHERE category_name='В');
    ELSEIF first_half=9 THEN SET second_half=(SELECT id FROM category WHERE category_name='Г');
    ELSEIF first_half=10 THEN SET second_half=(SELECT id FROM category WHERE category_name='Д');
    END IF;
	SET NEW.conclusion_id=second_half;
END;//

CREATE TRIGGER psychiatrist_INSERT
BEFORE INSERT
ON psychiatrist
FOR EACH ROW
BEGIN
	DECLARE first_half INT;
	DECLARE second_half INT;
	SET first_half=FLOOR(RAND()*(11 -1) + 1);
    IF 0 < first_half AND first_half < 5 THEN SET second_half=(SELECT id FROM category WHERE category_name='А');
    ELSEIF 4 < first_half AND first_half < 7 THEN SET second_half=(SELECT id FROM category WHERE category_name='Б');
    ELSEIF 6 < first_half AND first_half < 9 THEN SET second_half=(SELECT id FROM category WHERE category_name='В');
    ELSEIF first_half=9 THEN SET second_half=(SELECT id FROM category WHERE category_name='Г');
    ELSEIF first_half=10 THEN SET second_half=(SELECT id FROM category WHERE category_name='Д');
    END IF;
	SET NEW.conclusion_id=second_half;
END;//

CREATE TRIGGER therapist_INSERT
BEFORE INSERT
ON therapist
FOR EACH ROW
BEGIN
	DECLARE first_half INT;
	DECLARE second_half INT;
	SET first_half=FLOOR(RAND()*(11 -1) + 1);
    IF 0 < first_half AND first_half < 5 THEN SET second_half=(SELECT id FROM category WHERE category_name='А');
    ELSEIF 4 < first_half AND first_half < 7 THEN SET second_half=(SELECT id FROM category WHERE category_name='Б');
    ELSEIF 6 < first_half AND first_half < 9 THEN SET second_half=(SELECT id FROM category WHERE category_name='В');
    ELSEIF first_half=9 THEN SET second_half=(SELECT id FROM category WHERE category_name='Г');
    ELSEIF first_half=10 THEN SET second_half=(SELECT id FROM category WHERE category_name='Д');
    END IF;
	SET NEW.conclusion_id=second_half;
END;//

CREATE TRIGGER neurologist_INSERT
BEFORE INSERT
ON neurologist
FOR EACH ROW
BEGIN
	DECLARE first_half INT;
	DECLARE second_half INT;
	SET first_half=FLOOR(RAND()*(11 -1) + 1);
    IF 0 < first_half AND first_half < 5 THEN SET second_half=(SELECT id FROM category WHERE category_name='А');
    ELSEIF 4 < first_half AND first_half < 7 THEN SET second_half=(SELECT id FROM category WHERE category_name='Б');
    ELSEIF 6 < first_half AND first_half < 9 THEN SET second_half=(SELECT id FROM category WHERE category_name='В');
    ELSEIF first_half=9 THEN SET second_half=(SELECT id FROM category WHERE category_name='Г');
    ELSEIF first_half=10 THEN SET second_half=(SELECT id FROM category WHERE category_name='Д');
    END IF;
	SET NEW.conclusion_id=second_half;
END;//

CREATE TRIGGER dentist_INSERT
BEFORE INSERT
ON dentist
FOR EACH ROW
BEGIN
	DECLARE first_half INT;
	DECLARE second_half INT;
	SET first_half=FLOOR(RAND()*(11 -1) + 1);
    IF 0 < first_half AND first_half < 5 THEN SET second_half=(SELECT id FROM category WHERE category_name='А');
    ELSEIF 4 < first_half AND first_half < 7 THEN SET second_half=(SELECT id FROM category WHERE category_name='Б');
    ELSEIF 6 < first_half AND first_half < 9 THEN SET second_half=(SELECT id FROM category WHERE category_name='В');
    ELSEIF first_half=9 THEN SET second_half=(SELECT id FROM category WHERE category_name='Г');
    ELSEIF first_half=10 THEN SET second_half=(SELECT id FROM category WHERE category_name='Д');
    END IF;
	SET NEW.conclusion_id=second_half;
END;//

CREATE TRIGGER otorhinolaryngologist_INSERT
BEFORE INSERT
ON otorhinolaryngologist
FOR EACH ROW
BEGIN
	DECLARE first_half INT;
	DECLARE second_half INT;
	SET first_half=FLOOR(RAND()*(11 -1) + 1);
    IF 0 < first_half AND first_half < 5 THEN SET second_half=(SELECT id FROM category WHERE category_name='А');
    ELSEIF 4 < first_half AND first_half < 7 THEN SET second_half=(SELECT id FROM category WHERE category_name='Б');
    ELSEIF 6 < first_half AND first_half < 9 THEN SET second_half=(SELECT id FROM category WHERE category_name='В');
    ELSEIF first_half=9 THEN SET second_half=(SELECT id FROM category WHERE category_name='Г');
    ELSEIF first_half=10 THEN SET second_half=(SELECT id FROM category WHERE category_name='Д');
    END IF;
	SET NEW.conclusion_id=second_half;
END;//

CREATE TRIGGER ophthalmologist_INSERT
BEFORE INSERT
ON ophthalmologist
FOR EACH ROW
BEGIN
	DECLARE first_half INT;
	DECLARE second_half INT;
	SET first_half=FLOOR(RAND()*(11 -1) + 1);
    IF 0 < first_half AND first_half < 5 THEN SET second_half=(SELECT id FROM category WHERE category_name='А');
    ELSEIF 4 < first_half AND first_half < 7 THEN SET second_half=(SELECT id FROM category WHERE category_name='Б');
    ELSEIF 6 < first_half AND first_half < 9 THEN SET second_half=(SELECT id FROM category WHERE category_name='В');
    ELSEIF first_half=9 THEN SET second_half=(SELECT id FROM category WHERE category_name='Г');
    ELSEIF first_half=10 THEN SET second_half=(SELECT id FROM category WHERE category_name='Д');
    END IF;
	SET NEW.conclusion_id=second_half;
END;//

DELIMITER ;

#Выбор статуса 
DELIMITER //

CREATE TRIGGER medical_report_INSERT
BEFORE INSERT
ON medical_report
FOR EACH ROW
BEGIN
SET NEW.medical_status_id=(
	SELECT CEILING(GREATEST(sur.conclusion_id, psy.conclusion_id, ther.conclusion_id, neur.conclusion_id, ophtha.conclusion_id, dent.conclusion_id, otorh.conclusion_id) / 2) 
    FROM surgeon sur,  psychiatrist psy, therapist ther, neurologist neur, ophthalmologist ophtha, otorhinolaryngologist otorh, dentist dent
    WHERE sur.id=NEW.surgeon_id AND psy.id=NEW.psychiatrist_id AND ther.id=NEW.therapist_id AND neur.id=NEW.neurologist_id AND ophtha.id=NEW.ophthalmologist_id AND dent.id=NEW.dentist_id AND otorh.id=NEW.otorhinolaryngologist_id
    );
END//

DELIMITER ;

#Выбор наименьшей категории 
DELIMITER //

CREATE TRIGGER private_bussiness_INSERT
BEFORE INSERT
ON private_bussiness
FOR EACH ROW
BEGIN
	SET NEW.category_id=(
		SELECT GREATEST(sur.conclusion_id, psy.conclusion_id, ther.conclusion_id, neur.conclusion_id, ophtha.conclusion_id, dent.conclusion_id, otorh.conclusion_id)
		FROM medical_report mr 
		INNER JOIN surgeon sur
		ON mr.surgeon_id=sur.id
		INNER JOIN psychiatrist psy
		ON mr.psychiatrist_id=psy.id
		INNER JOIN therapist ther
		ON ther.id=therapist_id
		INNER JOIN neurologist neur
		ON neur.id=neurologist_id
		INNER JOIN ophthalmologist ophtha
		ON ophtha.id=ophthalmologist_id
		INNER JOIN dentist dent
		ON dent.id=dentist_id
		INNER JOIN otorhinolaryngologist otorh
		ON otorh.id=otorhinolaryngologist_id
		WHERE mr.id=NEW.medical_report_id
	);
	IF NEW.date_of_registration >= NEW.deregistration_date THEN
        SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT  = 'date_of_registration must be less than deregistration_date';
    END IF;
END//

DELIMITER ;


#Автоматическое заполнение поля «Тип семьи» 
DELIMITER //

CREATE TRIGGER family_composition_INSERT
AFTER INSERT
ON family_composition
FOR EACH ROW
BEGIN
	DECLARE adults_count TINYINT;
	DECLARE kids_count TINYINT;
	SET adults_count=(
	SELECT COUNT(*) FROM family_composition 
	INNER JOIN family ON family_id=family.id 
	INNER JOIN personal_information_r ON relative_id=personal_information_r.id 
	WHERE family_id=NEW.family_id AND order_of_kinship=1 AND age >= 18
	);
	SET kids_count=(
	SELECT COUNT(*) FROM family_composition 
	INNER JOIN family ON family_id=family.id 
	INNER JOIN personal_information_r ON relative_id=personal_information_r.id 
	WHERE family_id=NEW.family_id AND order_of_kinship=1 AND age < 18
	);
	IF (adults_count=1 AND kids_count=0) OR (adults_count=0 AND kids_count=1) THEN UPDATE family SET family_type_id=1 WHERE id=NEW.family_id;
	ELSEIF adults_count>1 AND kids_count>0 THEN UPDATE family SET family_type_id=3 WHERE id=NEW.family_id;
	ELSE UPDATE family SET family_type_id=2 WHERE id=NEW.family_id;
	END IF;
END //

DELIMITER ;

################################################# /Триггеры ################################################

################################################## Функции #################################################

# Вывести количество призывников, проходивших призыв в определенной военной части
DELIMITER //
CREATE FUNCTION  conscripts_number_in_military_unit(militaryUnitId INT UNSIGNED)
RETURNS INT UNSIGNED
READS SQL DATA
DETERMINISTIC
BEGIN
	DECLARE count INT UNSIGNED;
    SET count = (
    SELECT COUNT(conscript.id) FROM conscript
    INNER JOIN composition_of_conscription
    ON composition_of_conscription.conscript_id = conscript.id
    INNER JOIN conscription
    ON composition_of_conscription.id = conscription.id 
	WHERE conscription.military_unit_id = militaryUnitId
    );
    RETURN count;
END//
DELIMITER ;

# Рассчитайте скользящее значение полностью прошедших военную службу призывников в мотострелковых войсках к 2021 году
DELIMITER //
CREATE FUNCTION  sliding_value()
RETURNS FLOAT
READS SQL DATA
DETERMINISTIC
BEGIN
    RETURN (SELECT AVG((
    SELECT COUNT(*) FROM conscript
    INNER JOIN composition_of_conscription
    ON composition_of_conscription.conscript_id = conscript.id
	WHERE YEAR(composition_of_conscription.end_date_of_enlistment) < 2021
    GROUP BY YEAR(composition_of_conscription.date_of_enlistment)
    )));
END//
DELIMITER ;

# Рассчитайте процент полностью здоровых призывников для каждого региона
DELIMITER //
CREATE PROCEDURE percentage_healthy_people_regions()
BEGIN
SELECT region.region_name region, (COUNT(IF(private_bussiness.category_id = 1, 1, NULL)) * 100 / COUNT(*)) healthy_conscripts_in_percents FROM private_bussiness
    INNER JOIN personal_information
    ON private_bussiness.personal_information_id = personal_information.id
    INNER JOIN address
    ON address.id = personal_information.address_id
    INNER JOIN region
    ON address.region_id = region.id
    GROUP BY region_id;
END //
DELIMITER ;

# Установите порядок призыва призывников в зависимости от их медицинского здоровья и судимостей их родственников.
DELIMITER //
CREATE PROCEDURE correct_calling_order()
BEGIN
    SELECT id, private_bussiness_id, military_id, title_id, type_of_army_id FROM (SELECT DISTINCT conscript.*, private_bussiness.category_id AS hidden_column1, personal_information_r.criminal_record AS hidden_column2 FROM conscript
    INNER JOIN private_bussiness
    ON private_bussiness.id = conscript.private_bussiness_id
    INNER JOIN personal_information
    ON private_bussiness.personal_information_id = personal_information.id
    INNER JOIN family_composition
    ON family_composition.family_id = personal_information.family_id
    INNER JOIN personal_information_r
    ON family_composition.relative_id = personal_information_r.id
    ORDER BY private_bussiness.category_id ASC, personal_information_r.criminal_record ASC) AS T;
END //
DELIMITER ;

################################################# /Функции #################################################

######################################## Заполнение базовых таблиц #########################################

#Заполнение табицы типов семей
INSERT INTO family_type (family_type_name) VALUES ('Одиночка'), ('Неполная семья'), ('Полная семья');

#Заполнение табицы категорий 
INSERT INTO category (category_name) VALUES ('А'), ('Б'), ('В'), ('Г'), ('Д');

#Заполнение табицы пола
INSERT INTO sex (sex_name) VALUES ('МУЖ'), ('ЖЕН');

#Заполнение табицы званий
INSERT INTO title (rank_name) VALUES 	('Нет'), ('Рядовой'), ('Ефрейтор') , ('Младший сержант'), ('Сержант'), ('Старший сержант'), ('Старшина'), ('Прапорщик'), 
										('Старший прапорщик'), ('Младший лейтинант'), ('Лейтинант'), ('Старший лейтинант'), ('Капитан'), ('Майор'), ('Подполковник'), ('Полковник'), ('Генерал майор'), 
										('Генерал лейтинант'), ('Генерал лейтинант'), ('Генерал полковник'), ('Генерал армии'), ('Маршал России');
 
 #Заполнение табицы сезон
INSERT INTO season (season_name) VALUES ('Зима'), ('Весна'), ('Лето'), ('Осень');

#Заполнение табицы национальность
INSERT INTO nationality (nationality_name) VALUES ('Русский'), ('Казах'), ('Грузин'), ('Чеченец'), ('Украинец'), ('Дагестанец'), ('Осетин'), ('Татар'), ('Бурят'), ('Башкир'), ('Чуваш'), ('Армян');

#Заполнение табицы родство
INSERT INTO kinship (kinship_name) VALUES ('Кровное'), ('Не кровное');

#Заполнение табицы образование
INSERT INTO education (education_name) VALUES ('Дошкольное'), ('Начальное общее'), ('Основное общее'), ('Среднее общее'), ('Высшее');

#Заполнение табицы род войск
INSERT INTO type_of_army (typename) VALUES ('ВМФ'), ('ВВС'), ('ВКС'), ('Ракетные войска'), ('Сухопутные войска'), ('ПВО');

#Заполнение табицы СП
INSERT INTO family_status (family_status_name) VALUES ('Женат(замужем)'), ('Одинок(-а)'), ('Вдова(вдовец)'), ('Разведён(-а)');

#Заполнение табицы тип службы
INSERT INTO service_type (service_type_name) VALUES ('Срочная'), ('Контрактная');

#Заполнение табицы мед статус
INSERT INTO medical_status (status_name) VALUES ('Годен'), ('Ограниченно годен'), ('Не годен');

#Заполнение табицы регионов
INSERT INTO region (region_name) VALUES ('Свердловская обл.'), ('Новосибирская обл'), ('Московская обл.'), ('Свердловская обл.'), ('Тюменская обл.'), ('Самарская обл.');

######################################## /Заполнение базовых таблиц ########################################

##################################### Шаблон для добавления призывника #####################################

# Заполнение военного билета
INSERT INTO military_id (series, num) VALUES ('АБ', 1111111);

# Добавление врачей с заключениями
INSERT INTO surgeon (conclusion_id) VALUES (DEFAULT);
INSERT INTO psychiatrist (conclusion_id) VALUES (DEFAULT);
INSERT INTO therapist (conclusion_id) VALUES (DEFAULT);
INSERT INTO neurologist (conclusion_id) VALUES (DEFAULT);
INSERT INTO dentist (conclusion_id) VALUES (DEFAULT);
INSERT INTO otorhinolaryngologist (conclusion_id) VALUES (DEFAULT);
INSERT INTO ophthalmologist (conclusion_id) VALUES (DEFAULT);

# Формирование мед заключения
INSERT INTO medical_report (surgeon_id, psychiatrist_id, therapist_id, neurologist_id, dentist_id, otorhinolaryngologist_id, ophthalmologist_id)
VALUES (
(SELECT id FROM surgeon ORDER BY id DESC LIMIT 1), 											# Вместо запроса можно вставить id желаемого врача
(SELECT id FROM psychiatrist ORDER BY id DESC LIMIT 1),
(SELECT id FROM therapist ORDER BY id DESC LIMIT 1),
(SELECT id FROM neurologist ORDER BY id DESC LIMIT 1),
(SELECT id FROM dentist ORDER BY id DESC LIMIT 1),
(SELECT id FROM otorhinolaryngologist ORDER BY id DESC LIMIT 1),
(SELECT id FROM ophthalmologist ORDER BY id DESC LIMIT 1)
);

# Добавление рабочего(образовательного) учреждения 
INSERT INTO institution (inst_name, state_accreditation, field_of_activity) VALUES ('МОУ СОШ №9', TRUE, 'Образование');

# Создание строки занятости призывника
INSERT INTO employment (institution_id) VALUES ((SELECT id FROM institution WHERE inst_name='МОУ СОШ №9' ORDER BY id DESC LIMIT 1));

# Добавление воинской части по номеру
INSERT INTO military_unit (military_unit_id) VALUES (41614);

# Добавление имён родственников
INSERT INTO fullname_r (firstname, secondname, surname) VALUES ('Аркадий', 'Дмитиев(-а)', 'Витальевич'), ('Алиса', 'Дмитиев(-а)', 'Юрьевна'), ('Виталий', 'Дмитиев(-а)', 'Аркадьевич');

# Добавление имени призывника
INSERT INTO fullname (firstname, secondname, surname) VALUES ('Андрей', 'Дмитиев(-а)', 'Аркадьевич');

# Добавление адресов проживания
INSERT INTO address (region_id, city, street, house_num, apartment_num) VALUES (1,'Екатеринбург','Горького', 67, 104), (2,'Новосибирск','Гоголя', 6, 14);

# Добавление персональных данных родственников
INSERT INTO personal_information_r (fullname_id, date_of_birth, address_id, sex_id, nationality_id, education_id, age, criminal_record)
VALUES 
(
	(SELECT id FROM fullname_r WHERE firstname='Аркадий' AND secondname='Дмитиев(-а)' AND surname='Витальевич' ORDER BY id DESC LIMIT 1),
	'1975-04-04',
	(SELECT id FROM address WHERE city='Новосибирск' AND street='Гоголя' AND house_num=6 AND apartment_num=14 ORDER BY id DESC LIMIT 1),
	(SELECT id FROM sex WHERE sex_name='МУЖ'),
	(SELECT id FROM nationality WHERE nationality_name='Русский'),
	(SELECT id FROM education WHERE education_name='Высшее'),
	48,
	FALSE
),
(
	(SELECT id FROM fullname_r WHERE firstname='Виталий' AND secondname='Дмитиев(-а)' AND surname='Аркадьевич' ORDER BY id DESC LIMIT 1),
	'2003-04-09',
	(SELECT id FROM address WHERE city='Екатеринбург' AND street='Горького' AND house_num=67 AND apartment_num=104 ORDER BY id DESC LIMIT 1),
	(SELECT id FROM sex WHERE sex_name='МУЖ'),
	(SELECT id FROM nationality WHERE nationality_name='Русский'),
	(SELECT id FROM education WHERE education_name='Среднее общее'),
	20,
	FALSE
),
(
	(SELECT id FROM fullname_r WHERE firstname='Алиса' AND secondname='Дмитиев(-а)' AND surname='Юрьевна' ORDER BY id DESC LIMIT 1),
	'1980-04-21',
	(SELECT id FROM address WHERE city='Новосибирск' AND street='Гоголя' AND house_num=6 AND apartment_num=14 ORDER BY id DESC LIMIT 1),
	(SELECT id FROM sex WHERE sex_name='ЖЕН'),
	(SELECT id FROM nationality WHERE nationality_name='Русский'),
	(SELECT id FROM education WHERE education_name='Высшее'),
	43,
	FALSE
);

# Заполнение таблицы семья
INSERT INTO family (family_type_id) VALUES (DEFAULT);

#
INSERT INTO family_composition (family_id, kinship_id, relative_id, order_of_kinship)
VALUES 
(
	1, -- (SELECT id FROM family ORDER BY id DESC LIMIT 1)
	(SELECT id FROM kinship WHERE kinship_name='Не кровное'),
	(SELECT pi.id FROM personal_information_r pi INNER JOIN fullname_r fn ON fn.id=pi.fullname_id WHERE firstname='Аркадий' AND secondname='Дмитиев(-а)' AND surname='Витальевич' ORDER BY pi.id DESC LIMIT 1),
    1
),
(
	1, -- (SELECT id FROM family ORDER BY id DESC LIMIT 1)
	(SELECT id FROM kinship WHERE kinship_name='Кровное'),
	(SELECT pi.id FROM personal_information_r pi INNER JOIN fullname_r fn ON fn.id=pi.fullname_id WHERE firstname='Алиса' AND secondname='Дмитиев(-а)' AND surname='Юрьевна' ORDER BY pi.id DESC LIMIT 1),
    1
),
(
	1, -- (SELECT id FROM family ORDER BY id DESC LIMIT 1)
	(SELECT id FROM kinship WHERE kinship_name='Кровное'),
	(SELECT pi.id FROM personal_information_r pi INNER JOIN fullname_r fn ON fn.id=pi.fullname_id WHERE firstname='Виталий' AND secondname='Дмитиев(-а)' AND surname='Аркадьевич' ORDER BY pi.id DESC LIMIT 1),
    2
);

# Персональные данные призывника
INSERT INTO personal_information (fullname_id, date_of_birth, address_id, family_status_id, family_id, sex_id, nationality_id, employment_id, age, criminal_record)
VALUES 
(

	(SELECT id FROM fullname WHERE firstname='Андрей' AND secondname='Дмитиев(-а)' AND surname='Аркадьевич' ORDER BY id DESC LIMIT 1),
	'1999-04-01',
	(SELECT id FROM address WHERE city='Новосибирск' AND street='Гоголя' AND house_num=6 AND apartment_num=14 ORDER BY id DESC LIMIT 1),
    (SELECT id FROM family_status WHERE family_status_name='Одинок(-а)'),
	(SELECT id FROM family ORDER BY id DESC LIMIT 1),
	(SELECT id FROM sex WHERE sex_name='МУЖ'),
	(SELECT id FROM nationality WHERE nationality_name='Русский'),
	(SELECT id FROM employment ORDER BY id DESC LIMIT 1),
	24,
	FALSE
);


# Личное дело призыника
INSERT INTO private_bussiness (personal_information_id, medical_report_id, date_of_registration, deregistration_date)
VALUES 
(
		(SELECT id FROM personal_information ORDER BY id DESC LIMIT 1),
		(SELECT id FROM medical_report ORDER BY id DESC LIMIT 1),
        '2022-04-01',
        '2023-05-01'
);

# Призывник
INSERT INTO conscript (private_bussiness_id, title_id, type_of_army_id) 
VALUES (
	(SELECT pb.id FROM private_bussiness pb INNER JOIN personal_information pi ON pi.id=personal_information_id INNER JOIN fullname ON fullname.id=fullname_id WHERE firstname='Андрей' AND secondname='Дмитиев(-а)' AND surname='Аркадьевич' ORDER BY id DESC LIMIT 1),
    (SELECT id FROM title WHERE rank_name='Рядовой'),
    (SELECT id FROM type_of_army WHERE typename='ВВС')
);

INSERT INTO conscription (military_unit_id, season_id, conscription_year) 
VALUES (
	(SELECT id FROM military_unit WHERE military_unit_id=41614),
    (SELECT id FROM season WHERE season_name='Весна'),
    2022
);
INSERT INTO composition_of_conscription (service_type_id, conscript_id, date_of_enlistment, end_date_of_enlistment) 
VALUES (
	(SELECT id FROM conscript WHERE id=1),
    (SELECT id FROM service_type WHERE service_type_name='Срочная'),
    '2022-09-20', 
    '2023-09-20'
);
INSERT INTO issued_military_id (military_id, conscript_id) 
VALUES (
	(SELECT id FROM conscript WHERE id=1),
    (SELECT id FROM military_id WHERE id = 1)
);
##################################### /Шаблон для добавления призывника ####################################

# Добавление врачей с заключениями
INSERT INTO surgeon (conclusion_id) VALUES (DEFAULT);
INSERT INTO psychiatrist (conclusion_id) VALUES (DEFAULT);
INSERT INTO therapist (conclusion_id) VALUES (DEFAULT);
INSERT INTO neurologist (conclusion_id) VALUES (DEFAULT);
INSERT INTO dentist (conclusion_id) VALUES (DEFAULT);
INSERT INTO otorhinolaryngologist (conclusion_id) VALUES (DEFAULT);
INSERT INTO ophthalmologist (conclusion_id) VALUES (DEFAULT);

# Формирование мед заключения
INSERT INTO medical_report (surgeon_id, psychiatrist_id, therapist_id, neurologist_id, dentist_id, otorhinolaryngologist_id, ophthalmologist_id)
VALUES (
(SELECT id FROM surgeon ORDER BY id DESC LIMIT 1), 											# Вместо запроса можно вставить id желаемого врача
(SELECT id FROM psychiatrist ORDER BY id DESC LIMIT 1),
(SELECT id FROM therapist ORDER BY id DESC LIMIT 1),
(SELECT id FROM neurologist ORDER BY id DESC LIMIT 1),
(SELECT id FROM dentist ORDER BY id DESC LIMIT 1),
(SELECT id FROM otorhinolaryngologist ORDER BY id DESC LIMIT 1),
(SELECT id FROM ophthalmologist ORDER BY id DESC LIMIT 1)
);

# Добавление рабочего(образовательного) учреждения 
INSERT INTO institution (inst_name, state_accreditation, field_of_activity) VALUES ('Yagle', False, 'IT');

# Создание строки занятости призывника
INSERT INTO employment (institution_id) VALUES ((SELECT id FROM institution WHERE inst_name='Yagle' ORDER BY id DESC LIMIT 1));

# Добавление имён родственников
INSERT INTO fullname_r (firstname, secondname, surname) VALUES ('Петр', 'Коробков(-а)', 'Витальевич'), ('Татьяна', 'Коробков(-а)', 'Юрьевна'), ('Ксения', 'Коробков(-а)', 'Петровна'), ('Юлия', 'Коробков(-а)', 'Петровна');

# Добавление имени призывника
INSERT INTO fullname (firstname, secondname, surname) VALUES ('Михаил', 'Коробков(-а)', 'Петрович');

# Добавление адресов проживания
INSERT INTO address (region_id, city, street, house_num, apartment_num) VALUES (2,'Новосибирск','Ленина', 6, 14);

# Добавление персональных данных родственников
INSERT INTO personal_information_r (fullname_id, date_of_birth, address_id, sex_id, nationality_id, education_id, age, criminal_record)
VALUES 
(
	(SELECT id FROM fullname_r WHERE firstname='Петр' AND secondname='Коробков(-а)' AND surname='Витальевич' ORDER BY id DESC LIMIT 1),
	'1983-04-04',
	(SELECT id FROM address WHERE city='Новосибирск' AND street='Ленина' AND house_num=6 AND apartment_num=14 ORDER BY id DESC LIMIT 1),
	(SELECT id FROM sex WHERE sex_name='МУЖ'),
	(SELECT id FROM nationality WHERE nationality_name='Казах'),
	(SELECT id FROM education WHERE education_name='Высшее'),
	40,
	FALSE
),
(
	(SELECT id FROM fullname_r WHERE firstname='Ксения' AND secondname='Коробков(-а)' AND surname='Петровна' ORDER BY id DESC LIMIT 1),
	'2005-04-09',
	(SELECT id FROM address WHERE city='Новосибирск' AND street='Ленина' AND house_num=6 AND apartment_num=14 ORDER BY id DESC LIMIT 1),
	(SELECT id FROM sex WHERE sex_name='ЖЕН'),
	(SELECT id FROM nationality WHERE nationality_name='Русский'),
	(SELECT id FROM education WHERE education_name='Основное общее'),
	18,
	FALSE
),
(
	(SELECT id FROM fullname_r WHERE firstname='Юлия' AND secondname='Коробков(-а)' AND surname='Петровна' ORDER BY id DESC LIMIT 1),
	'2005-04-09',
	(SELECT id FROM address WHERE city='Новосибирск' AND street='Ленина' AND house_num=6 AND apartment_num=14 ORDER BY id DESC LIMIT 1),
	(SELECT id FROM sex WHERE sex_name='ЖЕН'),
	(SELECT id FROM nationality WHERE nationality_name='Русский'),
	(SELECT id FROM education WHERE education_name='Основное общее'),
	18,
	FALSE
),
(
	(SELECT id FROM fullname_r WHERE firstname='Татьяна' AND secondname='Коробков(-а)' AND surname='Юрьевна' ORDER BY id DESC LIMIT 1),
	'1984-04-21',
	(SELECT id FROM address WHERE city='Новосибирск' AND street='Ленина' AND house_num=6 AND apartment_num=14 ORDER BY id DESC LIMIT 1),
	(SELECT id FROM sex WHERE sex_name='ЖЕН'),
	(SELECT id FROM nationality WHERE nationality_name='Русский'),
	(SELECT id FROM education WHERE education_name='Среднее общее'),
	39,
	FALSE
);

# Заполнение таблицы семья
INSERT INTO family (family_type_id) VALUES (DEFAULT);

#
INSERT INTO family_composition (family_id, kinship_id, relative_id, order_of_kinship)
VALUES 
(
	2, -- (SELECT id FROM family ORDER BY id DESC LIMIT 1)
	(SELECT id FROM kinship WHERE kinship_name='Кровное'),
	(SELECT pi.id FROM personal_information_r pi INNER JOIN fullname_r fn ON fn.id=pi.fullname_id WHERE firstname='Петр' AND secondname='Коробков(-а)' AND surname='Витальевич' ORDER BY pi.id DESC LIMIT 1),
    1
),
(
	2, -- (SELECT id FROM family ORDER BY id DESC LIMIT 1)
	(SELECT id FROM kinship WHERE kinship_name='Кровное'),
	(SELECT pi.id FROM personal_information_r pi INNER JOIN fullname_r fn ON fn.id=pi.fullname_id WHERE firstname='Татьяна' AND secondname='Коробков(-а)' AND surname='Юрьевна' ORDER BY pi.id DESC LIMIT 1),
    1
),
(
	2, -- (SELECT id FROM family ORDER BY id DESC LIMIT 1)
	(SELECT id FROM kinship WHERE kinship_name='Кровное'),
	(SELECT pi.id FROM personal_information_r pi INNER JOIN fullname_r fn ON fn.id=pi.fullname_id WHERE firstname='Ксения' AND secondname='Коробков(-а)' AND surname='Петровна' ORDER BY pi.id DESC LIMIT 1),
    2
),
(
	2, -- (SELECT id FROM family ORDER BY id DESC LIMIT 1)
	(SELECT id FROM kinship WHERE kinship_name='Кровное'),
	(SELECT pi.id FROM personal_information_r pi INNER JOIN fullname_r fn ON fn.id=pi.fullname_id WHERE firstname='Юлия' AND secondname='Коробков(-а)' AND surname='Петровна' ORDER BY pi.id DESC LIMIT 1),
    2
);

# Персональные данные призывника
INSERT INTO personal_information (fullname_id, date_of_birth, address_id, family_status_id, family_id, sex_id, nationality_id, employment_id, age, criminal_record)
VALUES 
(

	(SELECT id FROM fullname WHERE firstname='Михаил' AND secondname='Коробков(-а)' AND surname='Петрович' ORDER BY id DESC LIMIT 1),
	'1999-04-01',
	(SELECT id FROM address WHERE city='Новосибирск' AND street='Ленина' AND house_num=6 AND apartment_num=14 ORDER BY id DESC LIMIT 1),
    (SELECT id FROM family_status WHERE family_status_name='Одинок(-а)'),
	(SELECT id FROM family ORDER BY id DESC LIMIT 1),
	(SELECT id FROM sex WHERE sex_name='МУЖ'),
	(SELECT id FROM nationality WHERE nationality_name='Русский'),
	(SELECT id FROM employment ORDER BY id DESC LIMIT 1),
	24,
	FALSE
);


# Личное дело призыника
INSERT INTO private_bussiness (personal_information_id, medical_report_id, date_of_registration, deregistration_date)
VALUES 
(
		(SELECT id FROM personal_information ORDER BY id DESC LIMIT 1),
		(SELECT id FROM medical_report ORDER BY id DESC LIMIT 1),
        '2022-04-01',
        '2023-05-01'
);

# Призывник
INSERT INTO conscript (private_bussiness_id, title_id, type_of_army_id) 
VALUES (
	(SELECT pb.id FROM private_bussiness pb INNER JOIN personal_information pi ON pi.id=personal_information_id INNER JOIN fullname ON fullname.id=fullname_id WHERE firstname='Михаил' AND secondname='Коробков(-а)' AND surname='Петрович' ORDER BY id DESC LIMIT 1),
    (SELECT id FROM title WHERE rank_name='Нет'),
    (SELECT id FROM type_of_army WHERE typename='ВВС')
);

INSERT INTO conscription (military_unit_id, season_id, conscription_year) 
VALUES (
	(SELECT id FROM military_unit WHERE military_unit_id=41614),
    (SELECT id FROM season WHERE season_name='Весна'),
    2022
);
INSERT INTO composition_of_conscription (service_type_id, conscript_id, date_of_enlistment, end_date_of_enlistment) 
VALUES (
	(SELECT id FROM conscript WHERE id=1),
    (SELECT id FROM service_type WHERE service_type_name='Срочная'),
    '2022-09-20',
    '2023-09-20'
);
##################################### /Шаблон для добавления призывника ####################################

#список всех призывников#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, sex.sex_name, personal_information.age, region.region_name, address.city, address.street, address.house_num, address.apartment_num
FROM conscript, private_bussiness, personal_information, fullname, address, sex, region
WHERE personal_information.fullname_id = fullname.id
AND personal_information.address_id = address.id
AND address.region_id = region.id
AND personal_information.sex_id = sex.id
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id;

#статус службы - негоден#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, category.category_name
FROM personal_information, private_bussiness, fullname, conscript, category
WHERE personal_information.fullname_id = fullname.id
AND personal_information.id = private_bussiness.personal_information_id
AND private_bussiness.category_id = category.id
AND category.category_name = "Д"
AND conscript.private_bussiness_id = private_bussiness.id;

#список родственников определенного призывника#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, personal_information_r.id, fullname_r.firstname, fullname_r.secondname, fullname_r.surname
FROM personal_information, personal_information_r, family_composition, fullname_r, fullname, conscript, private_bussiness
WHERE personal_information.id = 1
AND personal_information.fullname_id = fullname.id
AND personal_information.family_id = family_composition.family_id
AND family_composition.relative_id = personal_information_r.id
AND personal_information_r.fullname_id = fullname_r.id
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id;

#призывники в определенном городе#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, address.city
FROM personal_information, address, fullname, conscript, private_bussiness
WHERE personal_information.fullname_id = fullname.id
AND personal_information.address_id = address.id
AND address.city = "Новосибирск"
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id;

#список служащих сейчас призывников#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, composition_of_conscription.date_of_enlistment
FROM personal_information, fullname, conscript, private_bussiness, composition_of_conscription
WHERE personal_information.fullname_id = fullname.id
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id
AND conscript.id = composition_of_conscription.conscript_id
AND composition_of_conscription.end_date_of_enlistment > CURDATE();
#AND DATEDIFF(composition_of_conscription.date_of_enlistment, CURDATE()) < 365;

#мед. заключение - ограниченно годен#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, medical_status.status_name
FROM personal_information, fullname, conscript, private_bussiness, medical_report, medical_status
WHERE personal_information.fullname_id = fullname.id
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id
AND medical_report.medical_status_id = medical_status.id
AND medical_status.status_name = "Ограниченно годен";

#список призывников определенной возрастной группы#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, personal_information.age
FROM personal_information, fullname, conscript, private_bussiness
WHERE personal_information.fullname_id = fullname.id
AND personal_information.age BETWEEN 21 AND 25
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id;

#родители определенного призывника#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, personal_information_r.id, fullname_r.firstname, fullname_r.secondname, fullname_r.surname
FROM personal_information, personal_information_r, family_composition, fullname_r, fullname, conscript, private_bussiness
WHERE personal_information.id = 1
AND personal_information.fullname_id = fullname.id
AND personal_information.family_id = family_composition.family_id
AND family_composition.relative_id = personal_information_r.id
AND personal_information_r.fullname_id = fullname_r.id
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id
AND family_composition.order_of_kinship = 1;

#призывники с одинаковой датой рождения#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname,  personal_information.date_of_birth FROM personal_information, conscript, fullname, private_bussiness
 WHERE personal_information.date_of_birth IN (
    SELECT personal_information.date_of_birth FROM personal_information
    GROUP BY date_of_birth HAVING count(*) > 1
)
AND personal_information.fullname_id = fullname.id
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id;

#все призывники из определенной военной части#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, military_unit.military_unit_id
FROM personal_information, fullname, conscript, private_bussiness, conscription, composition_of_conscription, military_unit
WHERE personal_information.fullname_id = fullname.id
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id
AND conscript.id = composition_of_conscription.conscript_id
AND conscription.id = composition_of_conscription.conscript_id
AND conscription.military_unit_id = military_unit.id
AND military_unit.military_unit_id = 41614;

#родственники с одинаковыми фамилиями#
SELECT personal_information_r.id, fullname_r.firstname, fullname_r.secondname, fullname_r.surname FROM personal_information_r, fullname_r
 WHERE fullname_r.secondname IN (
    SELECT fullname_r.secondname FROM fullname_r
    GROUP BY fullname_r.secondname HAVING count(*) > 1
)
AND personal_information_r.fullname_id = fullname_r.id;

#список призывников из определенного областного центра#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, region.region_name
FROM conscript, private_bussiness, personal_information, fullname, address, region
WHERE personal_information.fullname_id = fullname.id
AND personal_information.address_id = address.id
AND address.region_id = region.id
AND region.region_name = "Новосибирская обл"
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id;


#список родственников определенного призывника с одинаковой датой рождения#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, personal_information_r.id, fullname_r.firstname, fullname_r.secondname, fullname_r.surname, personal_information_r.date_of_birth
FROM personal_information, personal_information_r, family_composition, fullname_r, fullname, conscript, private_bussiness
 WHERE personal_information_r.date_of_birth IN (
    SELECT personal_information_r.date_of_birth FROM personal_information_r
    GROUP BY personal_information_r.date_of_birth HAVING count(*) > 1
)
AND personal_information.id = 2
AND personal_information.fullname_id = fullname.id
AND personal_information.family_id = family_composition.family_id
AND family_composition.relative_id = personal_information_r.id
AND personal_information_r.fullname_id = fullname_r.id
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id;

#призывники срочной военной службы в определенном году#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, conscription.conscription_year, service_type.service_type_name
FROM personal_information, fullname, conscript, private_bussiness, composition_of_conscription, conscription, service_type
WHERE personal_information.fullname_id = fullname.id
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id
AND conscript.id = composition_of_conscription.conscript_id
AND conscription.id = composition_of_conscription.conscript_id
AND composition_of_conscription.service_type_id = service_type.id
AND service_type.service_type_name = "Срочная"
AND conscription.conscription_year = 2022;

#список родственников с одинаковым адресом проживания#
SELECT personal_information_r.id, fullname_r.firstname, fullname_r.secondname, fullname_r.surname, region.region_name, address.city, address.street, address.house_num, address.apartment_num FROM personal_information_r, fullname_r, address, region
 WHERE personal_information_r.address_id IN (
    SELECT personal_information_r.address_id FROM personal_information_r
    GROUP BY personal_information_r.address_id HAVING count(*) > 1
)
AND personal_information_r.fullname_id = fullname_r.id
AND address.region_id = region.id
AND personal_information_r.address_id = address.id;

#все призывники с военным билетом#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, military_id.id, military_id.series, military_id.num
FROM personal_information, fullname, conscript, private_bussiness, military_id, issued_military_id
WHERE issued_military_id.military_id = military_id.id
AND issued_military_id.conscript_id = conscript.id
AND personal_information.fullname_id = fullname.id
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id;

#все родственники с одинаковой национальностью#
SELECT personal_information_r.id, fullname_r.firstname, fullname_r.secondname, fullname_r.surname, nationality.nationality_name FROM personal_information_r, fullname_r, nationality
 WHERE personal_information_r.nationality_id IN (
    SELECT personal_information_r.nationality_id FROM personal_information_r
    GROUP BY personal_information_r.nationality_id HAVING count(*) > 1
)
AND personal_information_r.fullname_id = fullname_r.id
AND personal_information_r.nationality_id = nationality.id;

#призывники - усыновленные дети#
#DISTINCT после SELECT для уникального выбора#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, kinship.kinship_name, family_composition.order_of_kinship, personal_information_r.id, fullname_r.firstname, fullname_r.secondname, fullname_r.surname
FROM personal_information, personal_information_r, family_composition, fullname_r, fullname, conscript, private_bussiness, kinship
WHERE personal_information.id = 1
AND personal_information.fullname_id = fullname.id
AND personal_information.family_id = family_composition.family_id
AND family_composition.relative_id = personal_information_r.id
AND personal_information_r.fullname_id = fullname_r.id
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id
AND family_composition.order_of_kinship = 1
AND family_composition.kinship_id = kinship.id
AND kinship.kinship_name = "Не кровное";

#родственники с высшим образованием#
SELECT personal_information_r.id, fullname_r.firstname, fullname_r.secondname, fullname_r.surname, education.education_name
FROM personal_information_r, fullname_r, education
WHERE personal_information_r.fullname_id = fullname_r.id
AND personal_information_r.education_id = education.id
AND education.education_name = "Высшее";

#Призывники со званиями#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, title.rank_name
FROM personal_information, fullname, conscript, private_bussiness, title
WHERE personal_information.fullname_id = fullname.id
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id
AND conscript.title_id = title.id
AND title.rank_name != 'Нет';

#призывники из сибирского региона, не имеющие родственников с судимостями до 3 колена родства#
SELECT DISTINCT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, region.region_name
FROM conscript, private_bussiness, personal_information, fullname, address, region, family_composition, personal_information_r
WHERE personal_information.fullname_id = fullname.id
AND personal_information.address_id = address.id
AND address.region_id = region.id
AND region.region_name = "Новосибирская обл"
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id
AND personal_information.family_id = family_composition.family_id
AND family_composition.relative_id = personal_information_r.id
AND personal_information_r.criminal_record = FALSE
AND family_composition.order_of_kinship <= 3;

#призывники в IT без аккредитации#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, institution.inst_name, institution.field_of_activity, institution.state_accreditation
FROM conscript, private_bussiness, personal_information, fullname, institution, employment
WHERE personal_information.fullname_id = fullname.id
AND personal_information.employment_id = employment.id
AND employment.institution_id = institution.id
AND institution.state_accreditation = FALSE
AND institution.field_of_activity = "IT"
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id;

#снятые с учета призывники в 2017 году по причине психического нездоровья#
SELECT conscript.id, fullname.firstname, fullname.secondname, fullname.surname, medical_status.status_name
FROM personal_information, fullname, conscript, private_bussiness, medical_report, medical_status, psychiatrist, category
WHERE personal_information.fullname_id = fullname.id
AND personal_information.id = private_bussiness.personal_information_id
AND conscript.private_bussiness_id = private_bussiness.id
AND medical_report.medical_status_id = medical_status.id
AND YEAR(private_bussiness.deregistration_date) = 2017
AND medical_report.psychiatrist_id = psychiatrist.id
AND psychiatrist.conclusion_id = category.id
AND category.category_name = "Д";


CALL percentage_healthy_people_regions();

SELECT sliding_value();

CALL correct_calling_order();
