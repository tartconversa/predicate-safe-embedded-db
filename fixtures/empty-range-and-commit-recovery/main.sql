BEGIN TRANSACTION;
CREATE TABLE "assignments" (key TEXT PRIMARY KEY, slot TEXT, instructor TEXT);
INSERT INTO "assignments" VALUES('a000','0800','i');
CREATE TABLE "lessons" (key TEXT PRIMARY KEY, slot TEXT, info TEXT);
INSERT INTO "lessons" VALUES('l000','0800','首次备课');
COMMIT;
