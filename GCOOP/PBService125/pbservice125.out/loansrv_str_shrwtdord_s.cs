//**************************************************************************
//
//                        Sybase Inc. 
//
//    THIS IS A TEMPORARY FILE GENERATED BY POWERBUILDER. IF YOU MODIFY 
//    THIS FILE, YOU DO SO AT YOUR OWN RISK. SYBASE DOES NOT PROVIDE 
//    SUPPORT FOR .NET ASSEMBLIES BUILT WITH USER-MODIFIED CS FILES. 
//
//**************************************************************************

#line 1 "c:\\gcoop_all\\core\\gcoop\\pbservice125\\pbsrvbiz\\loansrv.pbl\\loansrv.pblx\\str_shrwtdord.srs"
#line hidden
[Sybase.PowerBuilder.PBGroupAttribute("str_shrwtdord",Sybase.PowerBuilder.PBGroupType.Structure,"","c:\\gcoop_all\\core\\gcoop\\pbservice125\\pbsrvbiz\\loansrv.pbl\\loansrv.pblx",null,"pbservice125")]
internal class c__str_shrwtdord : Sybase.PowerBuilder.PBStructure
{
	public Sybase.PowerBuilder.PBString initfrom_type = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString member_no = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString memcoop_id = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBDateTime slip_date = Sybase.PowerBuilder.PBDateTime.DefaultValue;
	public Sybase.PowerBuilder.PBDateTime operate_date = Sybase.PowerBuilder.PBDateTime.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_sliphead = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_slipcutlon = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_slipcutetc = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_trncoll = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_trncollco = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_expense = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString entry_id = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString coop_id = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString payoutorder_no = Sybase.PowerBuilder.PBString.DefaultValue;

	public override object Clone()
	{
		c__str_shrwtdord vv = (c__str_shrwtdord)base.Clone();
 		vv.initfrom_type = initfrom_type;
		vv.member_no = member_no;
		vv.memcoop_id = memcoop_id;
		vv.slip_date = slip_date;
		vv.operate_date = operate_date;
		vv.xml_sliphead = xml_sliphead;
		vv.xml_slipcutlon = xml_slipcutlon;
		vv.xml_slipcutetc = xml_slipcutetc;
		vv.xml_trncoll = xml_trncoll;
		vv.xml_trncollco = xml_trncollco;
		vv.xml_expense = xml_expense;
		vv.entry_id = entry_id;
		vv.coop_id = coop_id;
		vv.payoutorder_no = payoutorder_no;
		return vv;
	}

	public static explicit operator c__str_shrwtdord(Sybase.PowerBuilder.PBAny v)
	{
		if (v.Value is Sybase.PowerBuilder.PBUnboundedArray)
		{
			Sybase.PowerBuilder.PBUnboundedArray a = (Sybase.PowerBuilder.PBUnboundedArray)v;
			c__str_shrwtdord vv = new c__str_shrwtdord();
			vv.initfrom_type = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[1]);
			vv.member_no = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[2]);
			vv.memcoop_id = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[3]);
			vv.slip_date = (Sybase.PowerBuilder.PBDateTime)((Sybase.PowerBuilder.PBAny)a[4]);
			vv.operate_date = (Sybase.PowerBuilder.PBDateTime)((Sybase.PowerBuilder.PBAny)a[5]);
			vv.xml_sliphead = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[6]);
			vv.xml_slipcutlon = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[7]);
			vv.xml_slipcutetc = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[8]);
			vv.xml_trncoll = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[9]);
			vv.xml_trncollco = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[10]);
			vv.xml_expense = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[11]);
			vv.entry_id = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[12]);
			vv.coop_id = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[13]);
			vv.payoutorder_no = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[14]);

			return vv;
		}
		else
		{
			return (c__str_shrwtdord) v.Value;
		}
	}

	public override Sybase.PowerBuilder.PBUnboundedAnyArray ToUnboundedAnyArray()
	{
		Sybase.PowerBuilder.PBUnboundedAnyArray a = new Sybase.PowerBuilder.PBUnboundedAnyArray();
		a.Add(new Sybase.PowerBuilder.PBAny(this.initfrom_type));
		a.Add(new Sybase.PowerBuilder.PBAny(this.member_no));
		a.Add(new Sybase.PowerBuilder.PBAny(this.memcoop_id));
		a.Add(new Sybase.PowerBuilder.PBAny(this.slip_date));
		a.Add(new Sybase.PowerBuilder.PBAny(this.operate_date));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_sliphead));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_slipcutlon));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_slipcutetc));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_trncoll));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_trncollco));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_expense));
		a.Add(new Sybase.PowerBuilder.PBAny(this.entry_id));
		a.Add(new Sybase.PowerBuilder.PBAny(this.coop_id));
		a.Add(new Sybase.PowerBuilder.PBAny(this.payoutorder_no));

		return a;
	}
}


[Sybase.PowerBuilder.PBStructureLayoutAttribute("str_shrwtdord")]
[ System.Runtime.InteropServices.StructLayout( System.Runtime.InteropServices.LayoutKind.Sequential, Pack = 1, CharSet = System.Runtime.InteropServices.CharSet.Ansi )]
internal struct c__str_shrwtdord_ansi
{
	public string initfrom_type;
	public string member_no;
	public string memcoop_id;
	public System.DateTime slip_date;
	public System.DateTime operate_date;
	public string xml_sliphead;
	public string xml_slipcutlon;
	public string xml_slipcutetc;
	public string xml_trncoll;
	public string xml_trncollco;
	public string xml_expense;
	public string entry_id;
	public string coop_id;
	public string payoutorder_no;

	public static implicit operator c__str_shrwtdord_ansi(c__str_shrwtdord other)
	{

		c__str_shrwtdord_ansi ret = new c__str_shrwtdord_ansi();

		ret.initfrom_type = other.initfrom_type;

		ret.member_no = other.member_no;

		ret.memcoop_id = other.memcoop_id;

		ret.slip_date = other.slip_date;

		ret.operate_date = other.operate_date;

		ret.xml_sliphead = other.xml_sliphead;

		ret.xml_slipcutlon = other.xml_slipcutlon;

		ret.xml_slipcutetc = other.xml_slipcutetc;

		ret.xml_trncoll = other.xml_trncoll;

		ret.xml_trncollco = other.xml_trncollco;

		ret.xml_expense = other.xml_expense;

		ret.entry_id = other.entry_id;

		ret.coop_id = other.coop_id;

		ret.payoutorder_no = other.payoutorder_no;

		return ret;
	}

	public static implicit operator c__str_shrwtdord(c__str_shrwtdord_ansi other)
	{

		c__str_shrwtdord ret = new c__str_shrwtdord();

		ret.initfrom_type = other.initfrom_type;

		ret.member_no = other.member_no;

		ret.memcoop_id = other.memcoop_id;

		ret.slip_date = other.slip_date;

		ret.operate_date = other.operate_date;

		ret.xml_sliphead = other.xml_sliphead;

		ret.xml_slipcutlon = other.xml_slipcutlon;

		ret.xml_slipcutetc = other.xml_slipcutetc;

		ret.xml_trncoll = other.xml_trncoll;

		ret.xml_trncollco = other.xml_trncollco;

		ret.xml_expense = other.xml_expense;

		ret.entry_id = other.entry_id;

		ret.coop_id = other.coop_id;

		ret.payoutorder_no = other.payoutorder_no;

		return ret;
	}
}


[Sybase.PowerBuilder.PBStructureLayoutAttribute("str_shrwtdord")]
[ System.Runtime.InteropServices.StructLayout( System.Runtime.InteropServices.LayoutKind.Sequential, Pack = 1, CharSet = System.Runtime.InteropServices.CharSet.Unicode )]
internal struct c__str_shrwtdord_unicode
{
	public string initfrom_type;
	public string member_no;
	public string memcoop_id;
	public System.DateTime slip_date;
	public System.DateTime operate_date;
	public string xml_sliphead;
	public string xml_slipcutlon;
	public string xml_slipcutetc;
	public string xml_trncoll;
	public string xml_trncollco;
	public string xml_expense;
	public string entry_id;
	public string coop_id;
	public string payoutorder_no;

	public static implicit operator c__str_shrwtdord_unicode(c__str_shrwtdord other)
	{

		c__str_shrwtdord_unicode ret = new c__str_shrwtdord_unicode();

		ret.initfrom_type = other.initfrom_type;

		ret.member_no = other.member_no;

		ret.memcoop_id = other.memcoop_id;

		ret.slip_date = other.slip_date;

		ret.operate_date = other.operate_date;

		ret.xml_sliphead = other.xml_sliphead;

		ret.xml_slipcutlon = other.xml_slipcutlon;

		ret.xml_slipcutetc = other.xml_slipcutetc;

		ret.xml_trncoll = other.xml_trncoll;

		ret.xml_trncollco = other.xml_trncollco;

		ret.xml_expense = other.xml_expense;

		ret.entry_id = other.entry_id;

		ret.coop_id = other.coop_id;

		ret.payoutorder_no = other.payoutorder_no;

		return ret;
	}

	public static implicit operator c__str_shrwtdord(c__str_shrwtdord_unicode other)
	{

		c__str_shrwtdord ret = new c__str_shrwtdord();

		ret.initfrom_type = other.initfrom_type;

		ret.member_no = other.member_no;

		ret.memcoop_id = other.memcoop_id;

		ret.slip_date = other.slip_date;

		ret.operate_date = other.operate_date;

		ret.xml_sliphead = other.xml_sliphead;

		ret.xml_slipcutlon = other.xml_slipcutlon;

		ret.xml_slipcutetc = other.xml_slipcutetc;

		ret.xml_trncoll = other.xml_trncoll;

		ret.xml_trncollco = other.xml_trncollco;

		ret.xml_expense = other.xml_expense;

		ret.entry_id = other.entry_id;

		ret.coop_id = other.coop_id;

		ret.payoutorder_no = other.payoutorder_no;

		return ret;
	}
}
 