BEGIN TRANSACTION;
CREATE TABLE "assignments" (key TEXT PRIMARY KEY, slot TEXT, instructor TEXT);
INSERT INTO "assignments" VALUES('a1','1000','i');
CREATE TABLE "lessons" (key TEXT PRIMARY KEY, slot TEXT, info TEXT);
INSERT INTO "lessons" VALUES('l1','1000','初版');
COMMIT;
