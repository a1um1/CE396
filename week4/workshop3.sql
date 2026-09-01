CREATE TABLE owner (
	-- ให้ Owner id เป็น Primary Key
	owner_id		serial				PRIMARY KEY,  
	first_name	varchar(30)		NOT NULL,
	last_name		varchar(30)		NOT NULL,
	address			varchar(255)	NOT NULL
);

CREATE TABLE owner_phone (
	owner_id		int						NOT NULL,
	phone_no		varchar(11)		NOT NULL,
	is_primary	boolean				NOT NULL,

	-- Primary Key จาก compound key ของ owner_id, phone_no
	CONSTRAINT pk_owner_phone PRIMARY KEY (owner_id, phone_no),	

	-- Foriegn Key เชื่อม owner ด้วย column owner_id
	-- และลบเบอร์ออกถ้าหากผู้ใช้ถูกบ
	CONSTRAINT	fk_owner_id FOREIGN KEY (owner_id) 
		REFERENCES owner(owner_id) ON DELETE CASCADE 
);

CREATE TABLE animal (
	--  ให้ animal_id เป็น Pirmary Key
	animal_id		serial				PRIMARY KEY, 					
	owner_id		int						NOT NULL,
	name				varchar(255)	NOT NULL,
	species			varchar(30)		NOT NULL,
	sex					varchar(30),		
	color				varchar(30),		
	birth_date	date,

	-- Foriegn Key เชื่อม owner ด้วย column owner_id
	-- ห้ามลบ owner ถ้าหากมีสัตว์เลี้ยงอยู่
	CONSTRAINT	fk_owner_id FOREIGN KEY (owner_id)
		REFERENCES owner(owner_id) ON DELETE RESTRICT
);

CREATE TABLE vet(
	vet_id			serial 				PRIMARY KEY,
	license_no	varchar(30) 	UNIQUE,
	name				varchar(255)	NOT NULL,
	start_date	date					NOT NULL
);

CREATE TABLE vet_specialty(
	specialty_id	serial		PRIMARY KEY,
	name				varchar(255)	NOT NULL
);

CREATE TABLE vet_to_specialty(
	vet_id				int	NOT NULL,
	specialty_id	int	NOT NULL,

	-- สร้าง Primary key, แบบ Compound key ของ Column vet_id, specialty_id
	CONSTRAINT pk_vet_specialty PRIMARY KEY (vet_id, specialty_id),
	
	-- สร้าง Foreign key เชื่อมไปที่ vet
	-- และถ้าหาก ข้อมูลใน vet ถูกลบจะลบข้อมูลนี้่ด้วย
	CONSTRAINT fk_vet_id FOREIGN KEY (vet_id)
		REFERENCES vet(vet_id) ON DELETE CASCADE,

	-- สร้าง Foreign key เชื่อมไปที่ Specialty
	-- และถ้าหาก ข้อมูลใน Specialty ถูกลบจะลบข้อมูลนี้่ด้วย
	CONSTRAINT fk_specialty_id FOREIGN KEY (specialty_id)
		REFERENCES vet_specialty(specialty_id) ON DELETE CASCADE
);

CREATE TABLE visit(
	animal_id		int						NOT NULL,
	visit_no		int						NOT NULL,
	visit_date	timestamptz		NOT NULL,
	
	-- คิดว่าน้ำหนักก็ต้องอยู่ในช่วง 0.00 - 999.99
	weight			numeric(5,2)	NOT NULL,	

	-- คิดว่าอุณหภูมิต้องอยู่ในช่วง 0.00 - 99.99
	temperature	numeric(4,2)	NOT NULL,	
	symptom			varchar(255)	NOT NULL,
	diagnosis		text					NOT NULL,

	-- ต้องมีเพื่อให้ทุกการตรวจต้องมีหมอแน่นอน
	vet_id			int						NOT NULL,	

	-- Primary Key, จาก Compound key ของ animal_id และ visit_no
	CONSTRAINT pk_animal_visit_no PRIMARY KEY (animal_id, visit_no), 

	-- Foriegn Key เชื่อม Vet ด้วย column vet_id
	-- และ ห้ามลบถ้าหากหมอเคยมีการรักษา
	CONSTRAINT fk_vet_id FOREIGN KEY (vet_id)	
		REFERENCES vet(vet_id) ON DELETE RESTRICT
);

CREATE TABLE medicine(
	medicine_id	serial				PRIMARY KEY,
	name				varchar(255)	NOT NULL,
	unit				varchar(30)		NOT NULL,
	unit_price	numeric(12,2) NOT NULL
);

CREATE TABLE visit_medicine(
	animal_id		int NOT NULL,
	visit_no		int NOT NULL,
	medicine_id	int NOT NULL,
	dosage			int NOT NULL,
	day					int NOT NULL,

	-- สร้าง Primary key จาก compound key ของ animal_id, visit_no, medicine_id
	CONSTRAINT	pk_visit_med PRIMARY KEY (animal_id, visit_no, medicine_id),

	-- FOREIGN KEY เชื่อมไปที่ visit โดยใช้ compund key ของ animal_id และ visit_no
	-- ห้ามลบ visit ถ้าหากมีข้อมูลยา
	CONSTRAINT fk_visit FOREIGN KEY (animal_id, visit_no)
		REFERENCES visit(animal_id, visit_no) ON DELETE RESTRICT,

	-- FOREIGN KEY เชื่อมไปที่ medicine โดย key medicine_id
	-- ห้ามลบ medicine ถ้าหากมีข้อมูลใน visit_medicine
	CONSTRAINT fk_medicine FOREIGN KEY (medicine_id)
		REFERENCES medicine(medicine_id) ON DELETE RESTRICT
);

CREATE TABLE receipt(
	receipt_id		serial				PRIMARY KEY,
	animal_id			int						NOT NULL,
	visit_no			int						NOT NULL,
	paid_at				timestamptz,

	-- FOREIGN KEY เชื่อมไปที่ medicine โดย key animal_id, visit_no
	-- ห้ามลบ medicine ถ้าหากมีข้อมูลใน visit_medicine
	CONSTRAINT fk_visit FOREIGN KEY (animal_id, visit_no)
		REFERENCES visit(animal_id, visit_no) ON DELETE RESTRICT
);
