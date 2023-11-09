using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CoreSavingLibrary;
using DataLibrary;
using System.Data;

namespace Saving.Applications.finance
{
    public class financeFunction
    {
        public class ResultClass 
        {
            public string text; 
            public decimal[] returnValue ;
        }
        public static string of_getcalendarinfo (string coop_control, DateTime work_date)
        {        
            int	li_year, li_month, li_day;
            string errMas = "";
            li_year 	=  work_date.Year + 543;
            li_month	=  work_date.Month;
            li_day      =  work_date.Day;

            string sqlStr = "";
            string ls_workdays = "";
            sqlStr = @"select workdays from amworkcalendar where coop_id={0}
                    and year={1}
                    and month={2}";
            sqlStr = WebUtil.SQLFormat(sqlStr, coop_control, li_year,li_month);
            Sdt dt = WebUtil.QuerySdt(sqlStr);
            if (dt.Next())
            {
                ls_workdays = dt.GetString("workdays").Trim();
                ls_workdays = ls_workdays.Substring(li_day-1, 1);
                if (ls_workdays == "H") {
                    errMas = "วันที่ระบบไม่ใช่วันทำการ กรุณาตรวจสอบวันทำการระบบ ที่ระบบ ADMIN";
                }
            }else{
                errMas = "ไม่พบข้อมูลปฏิทินประจำปี  (" +  li_year +") เดือน ("+li_month+")  "+"กรุณาติดต่อผู้ดูแลระบบ";
            }
            return errMas;
        }
        //ตรวจสอบการเปิดวัน
        public static Boolean of_chk_openday(string coop_id, DateTime work_date)
        { 
            string sqlStr = "";
            int ln_rc = 0;
            // is already open?
            sqlStr = @"select	count( operate_date ) as sql_value from	fincashflowmas
            where		( operate_date		= {1} ) and 
			            ( coop_id	        = {0} )";
            sqlStr = WebUtil.SQLFormat(sqlStr, coop_id, work_date);
            Sdt dt = WebUtil.QuerySdt(sqlStr);
            if (dt.Next())
            {
                ln_rc = dt.GetInt32("sql_value");
            }
            if (ln_rc > 0) {
                return false;
            }
            return true;
        }
        //ตรวจสอบการเปิดวัน/ปิดวัน ข้อมูลเงินยกมา ยกไป
        public static ResultClass of_is_openday(string coop_id, DateTime work_date)
        {
            // ตรวจสอบดูว่าวันนี้มีการเปิดงานไปแล้วหรือยัง           
            string sqlStr = "",errMas="";
            decimal ld_closestatus = 0, ld_cashamt = 0, ld_cashin = 0, ld_casout = 0, ld_cashbegin = 0;
            int ln_lastseqno = 0, ln_closestatus = 0;
            sqlStr = @"select count( operate_date ) as sql_value,cash_sumamt,close_status,
                    lastseq_no,cash_in,cash_out,cash_begin,entry_id from  fincashflowmas 
                    where coop_id = {0} and operate_date = {1} 
                    group by cash_sumamt,close_status,lastseq_no,cash_in,cash_out,cash_begin,entry_id";
            sqlStr = WebUtil.SQLFormat(sqlStr, coop_id, work_date);
            Sdt dt = WebUtil.QuerySdt(sqlStr);
            if (dt.Next())
            {
                ld_closestatus = dt.GetDecimal("sql_value");
                ld_cashamt = dt.GetDecimal("cash_sumamt");
                ln_closestatus = dt.GetInt32("close_status");
                ln_lastseqno = dt.GetInt32("lastseq_no");
                ld_cashin = dt.GetDecimal("cash_in");
                ld_casout = dt.GetDecimal("cash_out");
                ld_cashbegin = dt.GetDecimal("cash_begin");
                if (ld_closestatus < 1)
                {
                    errMas = "ไม่สามารถตรวจสอบสถานะการเปิดงานประจำวันได้ กรุณาตรวจสอบการเปิดวัน";
                }
                if (ln_closestatus == 1)
                {
                    errMas = "ได้ทำการปิดสิ้นวันแล้ว ไม่สามารถทำรายการได้";                  
                }
                ResultClass returnClass = new ResultClass();
                returnClass.text=  errMas ;
                returnClass.returnValue = new decimal[7] { ld_closestatus, ld_cashamt, ln_closestatus, ln_lastseqno, ld_cashin, ld_casout, ld_cashbegin };
                return returnClass;
            }
            else
            {
                ResultClass returnClass = new ResultClass();
                returnClass.text = "ไม่มีข้อมูลการเปิดวัน หรือ ไม่สามารถตรวจสอบข้อมูลได้";
                returnClass.returnValue = new decimal[1] { ld_closestatus = -1 };
                return returnClass;
            }
        }
        //ตรวจสอบการเปิดลิ้นชัก จำนวนคงเหลือ
        public static decimal[] of_is_teller(string coop_id, string entry_id, DateTime work_date)
        {
            string sqlStr = "";
            int ln_teller = 0, ln_status = 0, ln_stmno = 0;
            decimal ld_amount = 0;
            sqlStr = @"SELECT	count(*) ,AMOUNT_BALANCE  , status, laststm_no
                        FROM		FINTABLEUSERMASTER  
                        WHERE		( USER_NAME 		= {2} ) AND 
			                        ( OPDATEWORK		= {1} )  and
			                        ( coop_id	= {0})
                        group by AMOUNT_BALANCE  , status , laststm_no";
            sqlStr = WebUtil.SQLFormat(sqlStr, coop_id, work_date, entry_id);
            Sdt dt = WebUtil.QuerySdt(sqlStr);
            if (dt.Next())
            {
                ln_status = dt.GetInt32("status");
                ld_amount = dt.GetDecimal("AMOUNT_BALANCE");
                ln_stmno = dt.GetInt32("laststm_no");
                ln_teller = 1;
            }
            return new decimal[4] { ln_teller, ln_status, ld_amount, ln_stmno };
        }
        // ตรวจสอบรายการรับ-จ่ายประจำวัน
        public static int of_is_recvpay_pending(string coop_id, DateTime work_date)
        {
            int ln_chk = 0;
            string sqlStr = "";            
            sqlStr = @"select count(1) as value from finslip
            where	entry_date		= {1}
            and		payment_status	= 8 
            and		retail_flag		<> 3
            and		coop_id			= {0}
            and		from_system		<> 'FIN'
            and		cash_type		<> 'CHQ'";
            sqlStr = WebUtil.SQLFormat(sqlStr, coop_id, work_date);
            Sdt dt = WebUtil.QuerySdt(sqlStr);
            if (dt.Next()){
                ln_chk = dt.GetInt32("value");
            }
            return ln_chk;
        }
        // ตรวจสอบการผ่านรายการธนาคาร
        public static int of_is_posttobank(string coop_id, DateTime work_date)
        {
            int ln_chk = 0;
            string sqlStr = "";
            sqlStr = @"select	count( ACCOUNT_ID ) as value
            from		FINITEMPOSTTOBANK
            where		( POST_FLAG		= 0 ) and
			            ( ENTRY_DATE 	= {1} ) and 
			            ( COOP_ID		= {0} ) ";
            sqlStr = WebUtil.SQLFormat(sqlStr, coop_id, work_date);
            Sdt dt = WebUtil.QuerySdt(sqlStr);
            if (dt.Next())
            {
                ln_chk = dt.GetInt32("value");
            }
            return ln_chk;
        }
        //ตรวจสอบการปิดลิ้นชัก
        public static int of_is_open_allteller(string coop_id, DateTime work_date)
        {
            int ln_chk = 0;
            string sqlStr = "";
            sqlStr = @"select	count( user_name ) as value
            from		FINTABLEUSERMASTER
            where		status		= '11' and
			            OPDATEWORK	= {1} and
			            coop_id	= {0} ";
            sqlStr = WebUtil.SQLFormat(sqlStr, coop_id, work_date);
            Sdt dt = WebUtil.QuerySdt(sqlStr);
            if (dt.Next())
            {
                ln_chk = dt.GetInt32("value");
            }
            return ln_chk;
        }
        #region
        public static decimal[] of_getattribconstant(string coop_control, string cashtype)
        {
            // ตาราง finconstant     
            string sqlStr = "";
            sqlStr = "select *  from finconstant where coop_id={0}";
            sqlStr = WebUtil.SQLFormat(sqlStr, coop_control);
            Sdt dt = WebUtil.QuerySdt(sqlStr);
            int ln_accid = 0, ln_statuschq_flag = 0;
            decimal ld_tax_rate = 0, ld_includevat_flag = 0, ld_retail_cash=0;
            if (dt.Next())
            {
                ld_tax_rate = dt.GetDecimal("tax_rate");
                ld_includevat_flag = dt.GetDecimal("includevat_flag");
                ln_statuschq_flag = dt.GetInt32("statuschq_flag");
                ld_retail_cash = dt.GetDecimal("retail_cash");
                if (cashtype == "CSH")
                {
                    ln_accid = dt.GetInt32("cash_accid");
                }
                else if (cashtype == "CBT" || cashtype == "CHQ" || cashtype == "TRN" || cashtype == "CBO" || cashtype == "TBK" || cashtype == "DRF" || cashtype == "BEX" || cashtype == "KOT" || cashtype == "SAL")
                {
                    ln_accid = dt.GetInt32("bankdefault_accid");
                }
                else
                {
                    ln_accid = 0;
                }
            }
            return new decimal[5] { ln_accid, ld_tax_rate, ld_includevat_flag, ln_statuschq_flag, ld_retail_cash };
        }
        public static string of_getattribconstantFin(string coop_control,string columname)
        {
            // ตาราง finconstant     la_attribconstant
            string sqlStr = "";
            string la_attribconstant = "";
            DataTable dt = WebUtil.Query("select " + columname + " from finconstant where coop_id='" + coop_control.Trim() + " '");
            if (dt.Rows.Count < 1)
            {
                //ta.Close();
                throw new Exception("ไม่มีข้อมูล column " + columname);
            }
            la_attribconstant = dt.Rows[0][columname].ToString();
            return la_attribconstant;
        }
        #endregion
        public static decimal of_checkamsecapvlevel(string coop_id,string user_name)
        {
            decimal ld_return = 0;
            string sqlStr = "";
            sqlStr = @"select fin_maxbalance from amsecapvlevel,amsecusers where nvl(amsecusers.apvlevel_id,'00000')=amsecapvlevel.apvlevel_id
            and amsecusers.coop_id={0}
            and amsecusers.user_name={1} ";
            
            sqlStr = WebUtil.SQLFormat(sqlStr, coop_id, user_name);
            Sdt dt = WebUtil.QuerySdt(sqlStr);
            if (dt.Next())
            {
                ld_return = dt.GetDecimal("fin_maxbalance");
            }
            return ld_return;
        }
        public static string of_getnameuser(string coop_control, string coop_id, string user_name)
        {
            String ls_return = "";
            string sqlStr = @"select full_name from amsecusers where coop_control={0} and coop_id={1} and user_name={2}";
            sqlStr = WebUtil.SQLFormat(sqlStr, coop_control, coop_id, user_name);
            Sdt dt = WebUtil.QuerySdt(sqlStr);
            if (dt.Next())
            {
                ls_return = dt.GetString("full_name");
            }
            return ls_return;
        }
        public static string of_getdefaultaccid(string coop_control, string cashtype)
        {
            string sqlStr = "";
            sqlStr = "select cash_accid,bankdefault_accid  from finconstant where coop_id={0}";
            sqlStr = WebUtil.SQLFormat(sqlStr, coop_control);
            Sdt dt = WebUtil.QuerySdt(sqlStr);
            string ls_accid = "";
            if (dt.Next())
            {
                if (cashtype == "CSH")
                {
                    ls_accid = dt.GetString("cash_accid");
                }
                else if (cashtype == "CBT" || cashtype == "CHQ" || cashtype == "TRN" || cashtype == "CBO" || cashtype == "TBK" || cashtype == "DRF" || cashtype == "BEX" || cashtype == "KOT" || cashtype == "SAL")
                {
                    ls_accid = dt.GetString("bankdefault_accid");
                }
                else
                {
                    ls_accid = "";
                }
            }
            return ls_accid;
        }
        public static string[] of_getaddress(string coop_control, decimal member_flag, string member_no)
        {

            string sqlStr = "", ls_taxid = "", ls_address = "", ls_alladdress = "", ls_moo = "", ls_soi = "";
            string ls_vilage = "", ls_road = "", ls_subdistrict = "", ls_district = "", ls_province = "", ls_postcode = "";
            string as_taxaddr = "", as_taxid = "";
            if (member_flag == 1)
            {
                sqlStr = @"SELECT	MBMEMBMASTER.ADDRESS_NO,			MBMEMBMASTER.ADDRESS_MOO,			MBMEMBMASTER.ADDRESS_SOI,
					                MBMEMBMASTER.ADDRESS_VILLAGE,		MBMEMBMASTER.ADDRESS_ROAD,			MBUCFTAMBOL.TAMBOL_DESC,
					                MBUCFDISTRICT.DISTRICT_DESC,	MBUCFPROVINCE.PROVINCE_DESC,	MBMEMBMASTER.POSTCODE,
					                MBMEMBMASTER.CARD_PERSON
		                 FROM		MBMEMBMASTER,MBUCFDISTRICT,MBUCFPRENAME,MBUCFPROVINCE, MBUCFTAMBOL
		                 WHERE	    ( MBMEMBMASTER.POSTCODE    = MBUCFDISTRICT.POSTCODE) and
					                ( MBMEMBMASTER.PROVINCE_CODE	= MBUCFDISTRICT.PROVINCE_CODE  ) and  
					                ( MBMEMBMASTER.PRENAME_CODE 	= MBUCFPRENAME.PRENAME_CODE ) and  
					                ( MBMEMBMASTER.PROVINCE_CODE 	= MBUCFPROVINCE.PROVINCE_CODE ) and  
					                ( MBMEMBMASTER.DISTRICT_CODE 	    = MBUCFDISTRICT.DISTRICT_CODE ) and
					                ( MBUCFTAMBOL.DISTRICT_CODE		= MBUCFDISTRICT.DISTRICT_CODE ) and
					                ( MBMEMBMASTER.TAMBOL_CODE	    =  MBUCFTAMBOL.TAMBOL_CODE ) and
					                ( MBMEMBMASTER.MEMBER_NO 		= {1} )   and
					                ( MBMEMBMASTER.COOP_ID          = {0})";
                sqlStr = WebUtil.SQLFormat(sqlStr, coop_control, member_no);
                Sdt dt = WebUtil.QuerySdt(sqlStr);
                if (dt.Next())
                {
                    ls_address = dt.GetString("ADDRESS_NO");
                    ls_moo = dt.GetString("ADDRESS_MOO");
                    ls_soi = dt.GetString("ADDRESS_SOI");
                    ls_vilage = dt.GetString("ADDRESS_VILLAGE");
                    ls_road = dt.GetString("ADDRESS_ROAD");
                    ls_subdistrict = dt.GetString("TAMBOL_DESC");
                    ls_district = dt.GetString("DISTRICT_DESC");
                    ls_province = dt.GetString("PROVINCE_DESC");
                    ls_postcode = dt.GetString("ADDR_POSTCODE");
                    ls_taxid = dt.GetString("CARD_PERSON");
                }
            }
            else if (member_flag == 0)
            {
                sqlStr = @"SELECT	FINCONTACTMASTER.TAX_ID,				FINCONTACTMASTER.ADDRESS_NO,
                                    FINCONTACTMASTER.SOI_NO,			FINCONTACTMASTER.ROAD_NAME,
					                FINCONTACTMASTER.SUBDISTRICT,		MBUCFDISTRICT.DISTRICT_DESC,
					                MBUCFPROVINCE.PROVINCE_DESC,		FINCONTACTMASTER.POSTCODE
		                FROM		FINCONTACTMASTER, MBUCFDISTRICT,MBUCFPROVINCE  
		                WHERE	    ( FINCONTACTMASTER.DISTRICT			= MBUCFDISTRICT.DISTRICT_CODE ) and  
					                ( FINCONTACTMASTER.PROVINCE			= MBUCFDISTRICT.PROVINCE_CODE ) and  
					                ( FINCONTACTMASTER.PROVINCE			= MBUCFPROVINCE.PROVINCE_CODE ) and  
					                ( FINCONTACTMASTER.CONTACK_NO	    = {1} )   AND
					                ( FINCONTACTMASTER.COOP_ID          = {0} )";
                sqlStr = WebUtil.SQLFormat(sqlStr, coop_control, member_no);
                Sdt dt = WebUtil.QuerySdt(sqlStr);
                if (dt.Next())
                {
                    ls_taxid = dt.GetString("TAX_ID");
                    ls_address = dt.GetString("ADDRESS_NO");
                    ls_soi = dt.GetString("SOI_NO");
                    ls_road = dt.GetString("ROAD_NAME");
                    ls_subdistrict = dt.GetString("SUBDISTRICT");
                    ls_district = dt.GetString("DISTRICT_DESC");
                    ls_province = dt.GetString("PROVINCE_DESC");
                    ls_postcode = dt.GetString("POSTCODE");
                }
            }
            else
            {
                //
            }
            if (member_flag == 0 || member_flag == 1)
            {

                if (ls_address.Trim().Length > 0)
                {
                    ls_alladdress += ls_address;
                }
                if (ls_vilage.Trim().Length > 0)
                {
                    ls_alladdress += " หมู่บ้าน " + ls_vilage;
                }
                if (ls_moo.Trim().Length > 0)
                {
                    ls_alladdress += " ม." + ls_moo;
                }
                if (ls_soi.Trim().Length > 0)
                {
                    ls_alladdress += " ซ." + ls_soi;
                }
                if (ls_road.Trim().Length > 0)
                {
                    ls_alladdress += " ถ." + ls_road;
                }
                if (ls_subdistrict.Trim().Length > 0)
                {
                    ls_alladdress += " ต." + ls_subdistrict;
                }
                if (ls_district.Trim().Length > 0)
                {
                    ls_alladdress += " อ." + ls_district;
                }
                if (ls_province.Trim().Length > 0)
                {
                    ls_alladdress += " จ." + ls_province;
                }
                if (ls_postcode.Trim().Length > 0)
                {
                    ls_alladdress += " " + ls_postcode;
                }
            }
            as_taxaddr = ls_alladdress;
            as_taxid = ls_taxid;
            return new string[2] { as_taxaddr, as_taxid };
        }
//        public static string[] of_init_payrecv_member(string coop_control, decimal member_flag, string member_no)
//        {

//            string sqlStr = "", ls_membfullname = "", ls_prename = "", ls_membgroup = "";
//            if (member_flag == 1)
//            {
//                sqlStr = @"select  membgroup_code  from mbmembmaster where coop_id = {0}  and member_no = {1}";
//                sqlStr = WebUtil.SQLFormat(sqlStr, coop_control, member_no);
//                Sdt dt = WebUtil.QuerySdt(sqlStr);
//                if (dt.Next())
//                {
//                    ls_membgroup = dt.GetString("membgroup_code");
//                }
//                ls_membfullname = WebUtil.GetMembName(coop_control, member_no,1);
//            }            
//            else if (member_flag == 0)
//            {
//                sqlStr = @"select prename_desc , first_name ,last_name ,persontype_code,a.prename_code
//	                    from fincontactmaster a , mbucfprename b
//	                    where a.prename_code = b.prename_code	
//	                    and	a.coop_id = {0}
//	                    and contack_no = {1}";
//                sqlStr = WebUtil.SQLFormat(sqlStr, coop_control, member_no);
//                Sdt dt = WebUtil.QuerySdt(sqlStr);
//                if (dt.Next())
//                {
//                    ls_membfullname = dt.GetString("first_name").Trim() + " " + dt.GetString("last_name").Trim();
//                    ls_prename = dt.GetString("prename_desc");
//                }
//                // หากเป็นประเภทบุคคลธรรมดา
//                if (dt.GetString("persontype_code") == "01")
//                {
//                    if (dt.GetString("prename_code") != "ฮฮ")
//                    {
//                        ls_membfullname = ls_prename + ' ' + ls_membfullname;
//                    }
//                }
//            }
//            return new string[2] { ls_membfullname, ls_membgroup };
//        }

        public static string[] of_save_bank(string ls_coopid, string ls_tofromaccid, string ls_usename, DateTime work_date, decimal itemamt_net, string ls_clien, string ls_slipno, decimal ln_cashflag, string ls_itemcode, int bank_status, int seqno_bank, String ls_itemdesc)
        {
            string sql_finslipbank = "", sql_Istatement = "", sql_Umaster = "";
            string sql = @"SELECT * FROM FINBANKACCOUNT  WHERE COOP_ID = {0} AND CLOSE_STATUS=0 AND ACCOUNT_ID = {1}";
            sql = WebUtil.SQLFormat(sql, ls_coopid , ls_tofromaccid);
            Sdt dt = WebUtil.QuerySdt(sql);
            if (dt.Next())
            {
                if (ls_itemdesc == "" || ls_itemdesc == null)
                {
                    if (ls_itemcode == "WCA" || ls_itemcode == "DCA")
                    {
                        ls_itemdesc = (ln_cashflag >= 1) ? "ฝากเงิน" : "ถอนเงิน";
                    }
                    else { ls_itemdesc = (ln_cashflag >= 1) ? "เปิด บ/ช" : "ปิด บ/ช"; }
                }                
                sql_finslipbank = @"
                  INSERT INTO FINSLIPBANK  
                ( 
                COOP_ID,           SLIP_NO,      ENTRY_ID,       ENTRY_DATE,   OPERATE_DATE,   MACHINE_ID,     ACCOUNT_NO,   
                BANK_CODE,         BANK_BRANCH,  ACCOUNT_NAME,   ITEM_AMT,     BALANCE,        ITEM_CODE,      BOOK_NO,   
                ACCOUNT_TYPE,      SIGN_OPERATE, SEQ_NO 
                )  
                SELECT  COOP_ID,   {0},          {1},            {2},          {2} ,             {3},           ACCOUNT_NO,
                BANK_CODE,         BANKBRANCH_CODE, ACCOUNT_NAME,   {4} ,         BALANCE+({5}*{4}),{6},           BOOK_NO,
                ACCOUNT_TYPE,      {5} ,           {9}
                FROM  FINBANKACCOUNT WHERE COOP_ID={7}
                AND CLOSE_STATUS=0
                AND ACCOUNT_ID={8}
                 ";
                sql_finslipbank = WebUtil.SQLFormat(sql_finslipbank, ls_slipno, ls_usename, work_date, ls_clien
                , itemamt_net, ln_cashflag, ls_itemcode
                , ls_coopid, ls_tofromaccid, seqno_bank);

                sql_Istatement = @"INSERT INTO FINBANKSTATEMENT  
                ( 
                COOP_ID,                ACCOUNT_NO,              SEQ_NO,                BANK_CODE,           BANKBRANCH_CODE,   
                DETAIL_DESC,            ENTRY_ID,                ENTRY_DATE,            OPERATE_DATE,        REF_SEQ,   
                ITEM_STATUS,            BALANCE,                 BALANCE_BEGIN,         MACHINE_ID,          REFER_SLIPNO,
                ITEM_AMT,               SIGN_OPERATE 
                )  
                SELECT  COOP_ID,   		ACCOUNT_NO,   		     LASTSTM_SEQ+1,	        BANK_CODE,			BANKBRANCH_CODE,
                {8},			        {2},			         {3},	                {3},			    null,
                1,			            BALANCE+({7}*{4}),		 BALANCE,				{5},		        {6},
                {4},                    {7}
                FROM  FINBANKACCOUNT WHERE COOP_ID={0}
                AND CLOSE_STATUS=0
                AND ACCOUNT_ID={1}";
                sql_Istatement = WebUtil.SQLFormat(sql_Istatement, ls_coopid, ls_tofromaccid, ls_usename, work_date
                , itemamt_net, ls_clien, ls_slipno, ln_cashflag, ls_itemdesc);
                decimal close_flag = 0;
                DateTime close_date ;
                if (ls_itemcode == "CCA")
                {
                    close_flag = 1;
                    close_date = work_date;
                }
                else { 
                    close_flag = 0;
                    close_date = Convert.ToDateTime(null); 
                }
                if (bank_status == 0)
                {
                    sql_Umaster = @" UPDATE  FINBANKACCOUNT  SET BALANCE =BALANCE+({4}*{2}),LASTSTM_SEQ=LASTSTM_SEQ+1, LASTACCESS_DATE = {3}
                ,CLOSE_STATUS = {5},CLOSE_DATE = {6}
                WHERE COOP_ID={0}
                AND CLOSE_STATUS=0
                AND ACCOUNT_ID={1}";
                    sql_Umaster = WebUtil.SQLFormat(sql_Umaster, ls_coopid, ls_tofromaccid, itemamt_net, work_date, ln_cashflag, close_flag, close_date);
                }
                else {
                    //update bank
                    sql_Umaster = @" UPDATE  FINBANKACCOUNT  SET BALANCE =BALANCE+({4}*{2}),SCO_BALANCE =SCO_BALANCE+({4}*{2}),LASTSTM_SEQ=LASTSTM_SEQ+1, LASTACCESS_DATE = {3}
                ,CLOSE_STATUS = {5},CLOSE_DATE = {6}
                WHERE COOP_ID={0}
                AND CLOSE_STATUS=0
                AND ACCOUNT_ID={1}";
                    sql_Umaster = WebUtil.SQLFormat(sql_Umaster, ls_coopid, ls_tofromaccid, itemamt_net, work_date, ln_cashflag, close_flag, close_date);
                }
                        
            }
            return new string[3] { sql_finslipbank,sql_Istatement, sql_Umaster };
       
       } 

    }
}