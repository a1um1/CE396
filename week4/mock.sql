INSERT INTO owner (
	owner_id, first_name, last_name, address
) VALUES (1, 'John', 'Doe', '111/11 Apartment');

INSERT INTO animal (
	animal_id, owner_id, name, species
) VALUES (1, 1, 'Cat', 'Cat');

INSERT INTO vet (
	vet_id, license_no, name, start_date
) VALUES (1, '11111', 'Jane Doe', '2/9/2026');


INSERT INTO visit (
	animal_id, visit_no, visit_date, weight, temperature, symptom, diagnosis, vet_id
) VALUES (1, 1, '2/9/2026', 6.32, 32.1, 'Test', 'Test', 1);


INSERT INTO receipt (
	receipt_id, animal_id, visit_no, paid_at
) VALUES (1, 1, 1, '2/9/2026');