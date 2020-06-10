Define Class FoxPropertyTests As FxuTestCase Of FxuTestCase.prg

	#If .F.
		Local This As FoxPropertyTests Of FoxPropertyTests.prg
	#Endif

	icTestPrefix = "Test"
	cProcAct = ""
&& ======================================================================== &&
&& Function Setup
&& ======================================================================== &&
	Function Setup
		This.cProcAct = Set("Procedure")
		Set Path To "Src" Additive
		Do FoxProperty.prg
		Public myProp
		myProp = NewProperty()
	Endfunc
&& ======================================================================== &&
&& Function TearDown
&& ======================================================================== &&
	Function TearDown
		Local lcProcAct As String
		lcProcAct = This.cProcAct
		=DeleteAllProperties()
		Clear Class FoxProperty
		Release Procedure FoxProperty
		If Not Empty(lcProcAct)
			Set Procedure To (lcProcAct)
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestObject
&& ======================================================================== &&
	Function TestObject
		If This.AssertNotNull(myProp, "Test Failed")
			This.MessageOut("object created successfully")
		Endif
	EndFunc
&& ======================================================================== &&
&& Function TestGetProperty
&& ======================================================================== &&
	Function TestGetProperty
		This.MessageOut("My name is: " + MyProp.GetProperty("name"))
	EndFunc
&& ======================================================================== &&
&& Function TestPut
&& ======================================================================== &&
	Function TestPut
		MyProp.put("name", "irwin")
		If This.AssertEquals(MyProp.GetProperty("name"), "irwin", "test failed")
			This.MessageOut("My name is: " + MyProp.GetProperty("name"))
		EndIf
	EndFunc
&& ======================================================================== &&
&& Function TestIterator
&& ======================================================================== &&
	Function TestIterator
		This.FillData()
		Do while MyProp.HasNext()
			lcProp = MyProp.Next()
			This.MessageOut("Property " + lcProp + "  = " + Transform(MyProp.GetProperty(lcProp)))
		EndDo
	EndFunc
&& ======================================================================== &&
&& Function FillData
&& ======================================================================== &&
	Function FillData
		With MyProp
			.put("name", "irwin")
			.put("lastname", "rodriguez")
			.put("age", 34)
			.put("gender", "male")
			.put("birth", Date(1985, 11, 15))
			.put("childrens", 2)
			.put("earnings", 4.500)
		EndWith
	EndFunc
Enddefine