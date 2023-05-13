DROP DATABASE IF EXISTS conscriptDB;
CREATE DATABASE conscriptDB;
USE conscriptDB;

############################################# Создание таблиц #############################################

######################################## Таблицы без зависимостей #########################################

#Военный билет
CREATE TABLE military_id (
	id INT UNSIGNED AUTO_INCREMENT,
    series VARCHAR(2) NOT NULL,
    num TINYINT NOT NULL,
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
    typename TEXT NOT NULL,
    PRIMARY KEY(id)
);

#Образование
CREATE TABLE education (
	id INT UNSIGNED AUTO_INCREMENT,
    education_name TEXT NOT NULL,
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

#Адрес
CREATE TABLE address (
	id INT UNSIGNED AUTO_INCREMENT,
    region VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    street VARCHAR(255) NOT NULL,
    house_num SMALLINT UNSIGNED NOT NULL,
    apartment_num SMALLINT UNSIGNED NOT NULL,
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
    military_unit_name VARCHAR(255) NOT NULL,
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

-- #Дата
-- CREATE TABLE date_tb (
-- 	id INT UNSIGNED AUTO_INCREMENT,
--     dt DATETIME NOT NULL,
--     PRIMARY KEY(id)
-- );

#Дата призыва
-- CREATE TABLE date_of_enlistment (
-- 	id INT UNSIGNED AUTO_INCREMENT,
--     dt DATETIME NOT NULL,
--     PRIMARY KEY(id)
-- );

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
    conclusion_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (conclusion_id) REFERENCES category (id) ON DELETE CASCADE
);

#Терапевт
CREATE TABLE therapist (
	id INT UNSIGNED AUTO_INCREMENT,
    conclusion_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (conclusion_id) REFERENCES category (id) ON DELETE CASCADE
);

#Невролог
CREATE TABLE neurologist (
	id INT UNSIGNED AUTO_INCREMENT,
    conclusion_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (conclusion_id) REFERENCES category (id) ON DELETE CASCADE
);

#Психиатр
CREATE TABLE psychiatrist (
	id INT UNSIGNED AUTO_INCREMENT,
    conclusion_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (conclusion_id) REFERENCES category (id) ON DELETE CASCADE
);

#Офтальмолог
CREATE TABLE ophthalmologist (
	id INT UNSIGNED AUTO_INCREMENT,
    conclusion_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (conclusion_id) REFERENCES category (id) ON DELETE CASCADE
);

#Стоматолог
CREATE TABLE dentist (
	id INT UNSIGNED AUTO_INCREMENT,
    conclusion_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (conclusion_id) REFERENCES category (id) ON DELETE CASCADE
);

#ЛОР
CREATE TABLE otorhinolaryngologist (
	id INT UNSIGNED AUTO_INCREMENT,
    conclusion_id INT UNSIGNED NOT NULL,
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

#Семья
CREATE TABLE family (
	id INT UNSIGNED AUTO_INCREMENT,
    family_status_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (family_status_id) REFERENCES family_status (id) ON DELETE CASCADE
);

#Призыв
CREATE TABLE conscription (
	id INT UNSIGNED AUTO_INCREMENT,
    military_unit_id INT UNSIGNED NOT NULL,
    season_id INT UNSIGNED NOT NULL,
    conscription_year TINYINT UNSIGNED NOT NULL,
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
    medical_status_id INT UNSIGNED NOT NULL,
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
-- 	date_of_birth_id INT UNSIGNED NOT NULL,                                                          # убрать этот тип
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
-- 	FOREIGN KEY (date_of_birth_id) REFERENCES date_tb (id) ON DELETE CASCADE,                         # убрать этот тип
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
-- 	date_of_birth_id INT UNSIGNED NOT NULL,                                                          # убрать этот тип
    date_of_birth DATETIME NOT NULL,                                                          
    address_id INT UNSIGNED NOT NULL,
    sex_id INT UNSIGNED NOT NULL,
    nationality_id INT UNSIGNED NOT NULL,
    education_id INT UNSIGNED NOT NULL,
    age SMALLINT UNSIGNED NOT NULL,
    criminal_record BOOLEAN NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (fullname_id) REFERENCES fullname_r (id) ON DELETE CASCADE,
-- 	FOREIGN KEY (date_of_birth_id) REFERENCES date_tb (id) ON DELETE CASCADE,                        # убрать этот тип
    FOREIGN KEY (address_id) REFERENCES address (id) ON DELETE CASCADE,
    FOREIGN KEY (sex_id) REFERENCES sex (id) ON DELETE CASCADE,
    FOREIGN KEY (nationality_id) REFERENCES nationality (id) ON DELETE CASCADE,
    FOREIGN KEY (education_id) REFERENCES education (id) ON DELETE CASCADE
);

#Состав семьи
CREATE TABLE family_composition (
	id INT UNSIGNED AUTO_INCREMENT,
    family_id INT UNSIGNED NOT NULL,
    kinship_id INT UNSIGNED NOT NULL,                                                      
    relative_id INT UNSIGNED NOT NULL,
    order_of_kinship TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (family_id) REFERENCES family (id) ON DELETE CASCADE,
    FOREIGN KEY (kinship_id) REFERENCES kinship (id) ON DELETE CASCADE,                      
    FOREIGN KEY (relative_id) REFERENCES personal_information_r (id) ON DELETE CASCADE
);

#Личное дело
CREATE TABLE private_bussiness (
	id INT UNSIGNED AUTO_INCREMENT,
    personal_information_id INT UNSIGNED NOT NULL,
    medical_report_id INT UNSIGNED NOT NULL,                                                      
--     date_of_registration_id INT UNSIGNED NOT NULL,                                                  # убрать этот тип
    date_of_registration DATETIME NOT NULL,                                                    
-- 	deregistration_date_id INT UNSIGNED NOT NULL,                                                      # убрать этот тип
    deregistration_date DATETIME NOT NULL,                                                      
    category_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (personal_information_id) REFERENCES personal_information (id) ON DELETE CASCADE,
    FOREIGN KEY (medical_report_id) REFERENCES medical_report (id) ON DELETE CASCADE,                      
-- 	FOREIGN KEY (date_of_registration_id) REFERENCES date_tb (id) ON DELETE CASCADE,                  # убрать этот тип          
-- 	FOREIGN KEY (deregistration_date_id) REFERENCES date_tb (id) ON DELETE CASCADE,                   # убрать этот тип               
    FOREIGN KEY (category_id) REFERENCES category (id) ON DELETE CASCADE
);

#Призывник
CREATE TABLE conscript (
	id INT UNSIGNED AUTO_INCREMENT,
    private_bussiness_id INT UNSIGNED NOT NULL,
	military_id INT UNSIGNED NOT NULL,                                                      
    title_id INT UNSIGNED NOT NULL,                                                
    type_of_army_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (private_bussiness_id) REFERENCES private_bussiness (id) ON DELETE CASCADE,
    FOREIGN KEY (military_id) REFERENCES military_id (id) ON DELETE CASCADE,                                     
    FOREIGN KEY (title_id) REFERENCES title (id) ON DELETE CASCADE,                     
    FOREIGN KEY (type_of_army_id) REFERENCES type_of_army (id) ON DELETE CASCADE
);

#Состав призыва
CREATE TABLE composition_of_conscription (
	id INT UNSIGNED AUTO_INCREMENT,
    service_type_id INT UNSIGNED NOT NULL,
	conscript_id INT UNSIGNED NOT NULL,                                                      
--     date_of_enlistment_id INT UNSIGNED NOT NULL,          													# убрать этот тип                                                
    date_of_enlistment DATETIME NOT NULL,          													                                               
    PRIMARY KEY(id),
    FOREIGN KEY (service_type_id) REFERENCES service_type (id) ON DELETE CASCADE,
    FOREIGN KEY (conscript_id) REFERENCES conscript (id) ON DELETE CASCADE                                     
--     FOREIGN KEY (date_of_enlistment_id) REFERENCES date_tb (id) ON DELETE CASCADE						   # убрать этот тип          
);

################################# /Таблицы с множественными зависимостями ##################################

############################################# /Создание таблиц #############################################

######################################## Заполнение базовых таблиц #########################################

#Заполнение табицы типов семей
INSERT INTO family_type (family_type_name) VALUES ('одиночка'), ('полная семья'), ('неполная семья');

#Заполнение табицы категорий 
INSERT INTO category (category_name) VALUES ('А'), ('Б'), ('В'), ('Г'), ('Д');

#Заполнение табицы пола
INSERT INTO sex (sex_name) VALUES ('МУЖ'), ('ЖЕН');

#Заполнение табицы званий
INSERT INTO title (rank_name) VALUES 	('Рядовой'), ('Ефрейтор') , ('Младший сержант'), ('Сержант'), ('Старший сержант'), ('Старшина'), ('Прапорщик'), 
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

######################################## /Заполнение базовых таблиц ########################################

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
-- 		SELECT fullname_id FROM personal_information WHERE id IN (
-- 			SELECT personal_information_id FROM private_bussiness WHERE YEAR(deregistration_date) <= YEAR(NOW()) - 5
-- 		)
	);
END //

DELIMITER ;

# Ограничение на то, что дата постановки на учет не может быть больше или равна дате призыва
DELIMITER //

CREATE TRIGGER private_bussiness_INSERT_UPDATE 
BEFORE INSERT
ON private_bussiness
FOR EACH ROW
BEGIN
    IF NEW.date_of_registration >= NEW.deregistration_date THEN
        SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT  = 'date_of_registration must be less than deregistration_date';
    END IF;
END //

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
		WHERE pb.id=NEW.id
    ) THEN
		SIGNAL SQLSTATE '45000' 
				SET MESSAGE_TEXT  = 'age at the time of registration must be over 18 years old';
	END IF;
	IF 27 < (
		SELECT YEAR(date_of_registration) - YEAR(date_of_birth) FROM personal_information pi
        INNER JOIN private_bussiness pb ON pi.id=personal_information_id
		WHERE pb.id=NEW.id
    ) THEN
		SIGNAL SQLSTATE '45000' 
				SET MESSAGE_TEXT  = 'age at the time of registration must be less 27 years old';
	END IF;
END //

DELIMITER ;

#Случайное заполнение заключения докторов
-- DELIMITER //

-- CREATE TRIGGER surgeon_UPDATE_INSERT
-- BEFORE INSERT
-- ON surgeon-- , psychiatrist, therapist, neurologist, ophthalmologist, dentist, otorhinolaryngologist
-- FOR EACH ROW
-- BEGIN
-- SET NEW.conclusion_id=(SELECT id FROM category ORDER BY RAND() LIMIT 1);
-- END;//

-- CREATE TRIGGER psychiatrist_UPDATE_INSERT
-- BEFORE INSERT
-- ON psychiatrist
-- FOR EACH ROW
-- BEGIN
-- SET NEW.conclusion_id=(SELECT id FROM category ORDER BY RAND() LIMIT 1);
-- END;//

-- CREATE TRIGGER therapist_UPDATE_INSERT
-- BEFORE INSERT
-- ON therapist-- , psychiatrist, therapist, neurologist, ophthalmologist, dentist, otorhinolaryngologist
-- FOR EACH ROW
-- BEGIN
-- SET NEW.conclusion_id=(SELECT id FROM category ORDER BY RAND() LIMIT 1);
-- END;//

-- CREATE TRIGGER neurologist_UPDATE_INSERT
-- BEFORE INSERT
-- ON neurologist
-- FOR EACH ROW
-- BEGIN
-- SET NEW.conclusion_id=(SELECT id FROM category ORDER BY RAND() LIMIT 1);
-- END;//

-- CREATE TRIGGER dentist_UPDATE_INSERT
-- BEFORE INSERT
-- ON dentist
-- FOR EACH ROW
-- BEGIN
-- SET NEW.conclusion_id=(SELECT id FROM category ORDER BY RAND() LIMIT 1);
-- END;//

-- CREATE TRIGGER otorhinolaryngologist_UPDATE_INSERT
-- BEFORE INSERT
-- ON otorhinolaryngologist-- , psychiatrist, therapist, neurologist, ophthalmologist, dentist, otorhinolaryngologist
-- FOR EACH ROW
-- BEGIN
-- SET NEW.conclusion_id=(SELECT id FROM category ORDER BY RAND() LIMIT 1);
-- END;//

-- CREATE TRIGGER ophthalmologist_UPDATE_INSERT
-- BEFORE INSERT
-- ON ophthalmologist
-- FOR EACH ROW
-- BEGIN
-- SET NEW.conclusion_id=(SELECT id FROM category ORDER BY RAND() LIMIT 1);
-- END;//

-- DELIMITER ;

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
END//

DELIMITER ;

################################################# /Триггеры ################################################
