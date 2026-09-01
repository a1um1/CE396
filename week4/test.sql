-- พยายาม ลบ Owner ที่มี Animal
DELETE FROM owner WHERE owner_id = 1;

-- พยายาม ลบ Vet ที่มี Visit
DELETE FROM vet WHERE vet_id = 1;

-- พยายาม ลบ Visit ที่มี Recipt
DELETE FROM visit WHERE animal_id = 1 AND visit_no = 1;