//**************************************************************************
//
//                        Sybase Inc. 
//
//    THIS IS A TEMPORARY FILE GENERATED BY POWERBUILDER. IF YOU MODIFY 
//    THIS FILE, YOU DO SO AT YOUR OWN RISK. SYBASE DOES NOT PROVIDE 
//    SUPPORT FOR .NET ASSEMBLIES BUILT WITH USER-MODIFIED CS FILES. 
//
//**************************************************************************

#line 1 "c:\\gcoop_all\\core\\gcoop\\pbservice125\\pbsrvbiz\\keepingservice.pbl\\keepingservice.pblx\\str_keep_proc.srs"
#line hidden
[Sybase.PowerBuilder.PBGroupAttribute("str_keep_proc",Sybase.PowerBuilder.PBGroupType.Structure,"","c:\\gcoop_all\\core\\gcoop\\pbservice125\\pbsrvbiz\\keepingservice.pbl\\keepingservice.pblx",null,"pbservice125")]
internal class c__str_keep_proc : Sybase.PowerBuilder.PBStructure
{
	public Sybase.PowerBuilder.PBString xml_option = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString sqlrpt_desc = Sybase.PowerBuilder.PBString.DefaultValue;

	public override object Clone()
	{
		c__str_keep_proc vv = (c__str_keep_proc)base.Clone();
 		vv.xml_option = xml_option;
		vv.sqlrpt_desc = sqlrpt_desc;
		return vv;
	}

	public static explicit operator c__str_keep_proc(Sybase.PowerBuilder.PBAny v)
	{
		if (v.Value is Sybase.PowerBuilder.PBUnboundedArray)
		{
			Sybase.PowerBuilder.PBUnboundedArray a = (Sybase.PowerBuilder.PBUnboundedArray)v;
			c__str_keep_proc vv = new c__str_keep_proc();
			vv.xml_option = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[1]);
			vv.sqlrpt_desc = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[2]);

			return vv;
		}
		else
		{
			return (c__str_keep_proc) v.Value;
		}
	}

	public override Sybase.PowerBuilder.PBUnboundedAnyArray ToUnboundedAnyArray()
	{
		Sybase.PowerBuilder.PBUnboundedAnyArray a = new Sybase.PowerBuilder.PBUnboundedAnyArray();
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_option));
		a.Add(new Sybase.PowerBuilder.PBAny(this.sqlrpt_desc));

		return a;
	}
}


[Sybase.PowerBuilder.PBStructureLayoutAttribute("str_keep_proc")]
[ System.Runtime.InteropServices.StructLayout( System.Runtime.InteropServices.LayoutKind.Sequential, Pack = 1, CharSet = System.Runtime.InteropServices.CharSet.Ansi )]
internal struct c__str_keep_proc_ansi
{
	public string xml_option;
	public string sqlrpt_desc;

	public static implicit operator c__str_keep_proc_ansi(c__str_keep_proc other)
	{

		c__str_keep_proc_ansi ret = new c__str_keep_proc_ansi();

		ret.xml_option = other.xml_option;

		ret.sqlrpt_desc = other.sqlrpt_desc;

		return ret;
	}

	public static implicit operator c__str_keep_proc(c__str_keep_proc_ansi other)
	{

		c__str_keep_proc ret = new c__str_keep_proc();

		ret.xml_option = other.xml_option;

		ret.sqlrpt_desc = other.sqlrpt_desc;

		return ret;
	}
}


[Sybase.PowerBuilder.PBStructureLayoutAttribute("str_keep_proc")]
[ System.Runtime.InteropServices.StructLayout( System.Runtime.InteropServices.LayoutKind.Sequential, Pack = 1, CharSet = System.Runtime.InteropServices.CharSet.Unicode )]
internal struct c__str_keep_proc_unicode
{
	public string xml_option;
	public string sqlrpt_desc;

	public static implicit operator c__str_keep_proc_unicode(c__str_keep_proc other)
	{

		c__str_keep_proc_unicode ret = new c__str_keep_proc_unicode();

		ret.xml_option = other.xml_option;

		ret.sqlrpt_desc = other.sqlrpt_desc;

		return ret;
	}

	public static implicit operator c__str_keep_proc(c__str_keep_proc_unicode other)
	{

		c__str_keep_proc ret = new c__str_keep_proc();

		ret.xml_option = other.xml_option;

		ret.sqlrpt_desc = other.sqlrpt_desc;

		return ret;
	}
}
 