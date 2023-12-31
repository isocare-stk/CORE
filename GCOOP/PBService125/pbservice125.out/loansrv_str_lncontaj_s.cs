//**************************************************************************
//
//                        Sybase Inc. 
//
//    THIS IS A TEMPORARY FILE GENERATED BY POWERBUILDER. IF YOU MODIFY 
//    THIS FILE, YOU DO SO AT YOUR OWN RISK. SYBASE DOES NOT PROVIDE 
//    SUPPORT FOR .NET ASSEMBLIES BUILT WITH USER-MODIFIED CS FILES. 
//
//**************************************************************************

#line 1 "c:\\gcoop_all\\core\\gcoop\\pbservice125\\pbsrvbiz\\loansrv.pbl\\loansrv.pblx\\str_lncontaj.srs"
#line hidden
[Sybase.PowerBuilder.PBGroupAttribute("str_lncontaj",Sybase.PowerBuilder.PBGroupType.Structure,"","c:\\gcoop_all\\core\\gcoop\\pbservice125\\pbsrvbiz\\loansrv.pbl\\loansrv.pblx",null,"pbservice125")]
internal class c__str_lncontaj : Sybase.PowerBuilder.PBStructure
{
	public Sybase.PowerBuilder.PBString loancontract_no = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString contaj_docno = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBDateTime contaj_date = Sybase.PowerBuilder.PBDateTime.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_contdetail = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_contpayment = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_contloanpay = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_contcoll = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_contint = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_contintspc = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_oldcontintspc = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_oldcontcoll = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString entry_id = Sybase.PowerBuilder.PBString.DefaultValue;

	public override object Clone()
	{
		c__str_lncontaj vv = (c__str_lncontaj)base.Clone();
 		vv.loancontract_no = loancontract_no;
		vv.contaj_docno = contaj_docno;
		vv.contaj_date = contaj_date;
		vv.xml_contdetail = xml_contdetail;
		vv.xml_contpayment = xml_contpayment;
		vv.xml_contloanpay = xml_contloanpay;
		vv.xml_contcoll = xml_contcoll;
		vv.xml_contint = xml_contint;
		vv.xml_contintspc = xml_contintspc;
		vv.xml_oldcontintspc = xml_oldcontintspc;
		vv.xml_oldcontcoll = xml_oldcontcoll;
		vv.entry_id = entry_id;
		return vv;
	}

	public static explicit operator c__str_lncontaj(Sybase.PowerBuilder.PBAny v)
	{
		if (v.Value is Sybase.PowerBuilder.PBUnboundedArray)
		{
			Sybase.PowerBuilder.PBUnboundedArray a = (Sybase.PowerBuilder.PBUnboundedArray)v;
			c__str_lncontaj vv = new c__str_lncontaj();
			vv.loancontract_no = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[1]);
			vv.contaj_docno = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[2]);
			vv.contaj_date = (Sybase.PowerBuilder.PBDateTime)((Sybase.PowerBuilder.PBAny)a[3]);
			vv.xml_contdetail = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[4]);
			vv.xml_contpayment = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[5]);
			vv.xml_contloanpay = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[6]);
			vv.xml_contcoll = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[7]);
			vv.xml_contint = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[8]);
			vv.xml_contintspc = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[9]);
			vv.xml_oldcontintspc = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[10]);
			vv.xml_oldcontcoll = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[11]);
			vv.entry_id = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[12]);

			return vv;
		}
		else
		{
			return (c__str_lncontaj) v.Value;
		}
	}

	public override Sybase.PowerBuilder.PBUnboundedAnyArray ToUnboundedAnyArray()
	{
		Sybase.PowerBuilder.PBUnboundedAnyArray a = new Sybase.PowerBuilder.PBUnboundedAnyArray();
		a.Add(new Sybase.PowerBuilder.PBAny(this.loancontract_no));
		a.Add(new Sybase.PowerBuilder.PBAny(this.contaj_docno));
		a.Add(new Sybase.PowerBuilder.PBAny(this.contaj_date));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_contdetail));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_contpayment));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_contloanpay));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_contcoll));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_contint));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_contintspc));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_oldcontintspc));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_oldcontcoll));
		a.Add(new Sybase.PowerBuilder.PBAny(this.entry_id));

		return a;
	}
}


[Sybase.PowerBuilder.PBStructureLayoutAttribute("str_lncontaj")]
[ System.Runtime.InteropServices.StructLayout( System.Runtime.InteropServices.LayoutKind.Sequential, Pack = 1, CharSet = System.Runtime.InteropServices.CharSet.Ansi )]
internal struct c__str_lncontaj_ansi
{
	public string loancontract_no;
	public string contaj_docno;
	public System.DateTime contaj_date;
	public string xml_contdetail;
	public string xml_contpayment;
	public string xml_contloanpay;
	public string xml_contcoll;
	public string xml_contint;
	public string xml_contintspc;
	public string xml_oldcontintspc;
	public string xml_oldcontcoll;
	public string entry_id;

	public static implicit operator c__str_lncontaj_ansi(c__str_lncontaj other)
	{

		c__str_lncontaj_ansi ret = new c__str_lncontaj_ansi();

		ret.loancontract_no = other.loancontract_no;

		ret.contaj_docno = other.contaj_docno;

		ret.contaj_date = other.contaj_date;

		ret.xml_contdetail = other.xml_contdetail;

		ret.xml_contpayment = other.xml_contpayment;

		ret.xml_contloanpay = other.xml_contloanpay;

		ret.xml_contcoll = other.xml_contcoll;

		ret.xml_contint = other.xml_contint;

		ret.xml_contintspc = other.xml_contintspc;

		ret.xml_oldcontintspc = other.xml_oldcontintspc;

		ret.xml_oldcontcoll = other.xml_oldcontcoll;

		ret.entry_id = other.entry_id;

		return ret;
	}

	public static implicit operator c__str_lncontaj(c__str_lncontaj_ansi other)
	{

		c__str_lncontaj ret = new c__str_lncontaj();

		ret.loancontract_no = other.loancontract_no;

		ret.contaj_docno = other.contaj_docno;

		ret.contaj_date = other.contaj_date;

		ret.xml_contdetail = other.xml_contdetail;

		ret.xml_contpayment = other.xml_contpayment;

		ret.xml_contloanpay = other.xml_contloanpay;

		ret.xml_contcoll = other.xml_contcoll;

		ret.xml_contint = other.xml_contint;

		ret.xml_contintspc = other.xml_contintspc;

		ret.xml_oldcontintspc = other.xml_oldcontintspc;

		ret.xml_oldcontcoll = other.xml_oldcontcoll;

		ret.entry_id = other.entry_id;

		return ret;
	}
}


[Sybase.PowerBuilder.PBStructureLayoutAttribute("str_lncontaj")]
[ System.Runtime.InteropServices.StructLayout( System.Runtime.InteropServices.LayoutKind.Sequential, Pack = 1, CharSet = System.Runtime.InteropServices.CharSet.Unicode )]
internal struct c__str_lncontaj_unicode
{
	public string loancontract_no;
	public string contaj_docno;
	public System.DateTime contaj_date;
	public string xml_contdetail;
	public string xml_contpayment;
	public string xml_contloanpay;
	public string xml_contcoll;
	public string xml_contint;
	public string xml_contintspc;
	public string xml_oldcontintspc;
	public string xml_oldcontcoll;
	public string entry_id;

	public static implicit operator c__str_lncontaj_unicode(c__str_lncontaj other)
	{

		c__str_lncontaj_unicode ret = new c__str_lncontaj_unicode();

		ret.loancontract_no = other.loancontract_no;

		ret.contaj_docno = other.contaj_docno;

		ret.contaj_date = other.contaj_date;

		ret.xml_contdetail = other.xml_contdetail;

		ret.xml_contpayment = other.xml_contpayment;

		ret.xml_contloanpay = other.xml_contloanpay;

		ret.xml_contcoll = other.xml_contcoll;

		ret.xml_contint = other.xml_contint;

		ret.xml_contintspc = other.xml_contintspc;

		ret.xml_oldcontintspc = other.xml_oldcontintspc;

		ret.xml_oldcontcoll = other.xml_oldcontcoll;

		ret.entry_id = other.entry_id;

		return ret;
	}

	public static implicit operator c__str_lncontaj(c__str_lncontaj_unicode other)
	{

		c__str_lncontaj ret = new c__str_lncontaj();

		ret.loancontract_no = other.loancontract_no;

		ret.contaj_docno = other.contaj_docno;

		ret.contaj_date = other.contaj_date;

		ret.xml_contdetail = other.xml_contdetail;

		ret.xml_contpayment = other.xml_contpayment;

		ret.xml_contloanpay = other.xml_contloanpay;

		ret.xml_contcoll = other.xml_contcoll;

		ret.xml_contint = other.xml_contint;

		ret.xml_contintspc = other.xml_contintspc;

		ret.xml_oldcontintspc = other.xml_oldcontintspc;

		ret.xml_oldcontcoll = other.xml_oldcontcoll;

		ret.entry_id = other.entry_id;

		return ret;
	}
}
 