--------------------------------------------------------
--  File created - Tuesday-June-21-2016   
--------------------------------------------------------
DROP TABLE "ATMCONF";
--------------------------------------------------------
--  DDL for Table ATMCONF
--------------------------------------------------------

  CREATE TABLE "ATMCONF" 
   (	"ATMDBVER" NUMBER(5,0) DEFAULT 2, 
	"ATMCONF_ID" NUMBER(5,0), 
	"GENPERIODPAY_FLAG" NUMBER(2,0) DEFAULT 0, 
	"DOUBLEPERIODPAY_FLAG" NUMBER(2,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into ATMCONF
SET DEFINE OFF;
Insert into ATMCONF (ATMDBVER,ATMCONF_ID,GENPERIODPAY_FLAG,DOUBLEPERIODPAY_FLAG) values (11,1,0,0);
--------------------------------------------------------
--  DDL for Index ATMCONF_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ATMCONF_PK" ON "ATMCONF" ("ATMCONF_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table ATMCONF
--------------------------------------------------------

  ALTER TABLE "ATMCONF" ADD CONSTRAINT "ATMCONF_PK" PRIMARY KEY ("ATMCONF_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "ATMCONF" MODIFY ("ATMCONF_ID" NOT NULL ENABLE);