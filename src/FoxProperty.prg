&& ======================================================================== &&
&& Name:    FoxProperty.prg
&& Descrip: The FoxProperty class represents a persistent set of properties.
&& Author:  <Irwin Rodriguez> rodriguez.irwin@gmail.com
&& Version: 1.0.1
&& ======================================================================== &&
&& ======================================================================== &&
&& Default code snippet when user performs: do FoxProperty.prg
&& ======================================================================== &&
Set Procedure To "FoxProperty" Additive
* Internal Property counter.
If Type("_Screen.nPropSize") = "U"
    =AddProperty(_Screen, "nPropSize", 0)
Endif
* Properties pool.
If Type("_Screen.aProps") = "U"
    =AddProperty(_Screen, "aProps[1]", .Null.)
Endif
&& ======================================================================== &&
&& NewProperty.
&& ======================================================================== &&
Function NewProperty() As FoxProperty
    _Screen.nPropSize = _Screen.nPropSize + 1
    Dimension _Screen.aProps(_Screen.nPropSize)
    _Screen.aProps[_Screen.nPropSize] = CreateObject("FoxProperty")
    Return _Screen.aProps[_Screen.nPropSize]
EndFunc
&& ======================================================================== &&
&& DeleteAllProperties.
&& ======================================================================== &&
Function DeleteAllProperties() As Void
    For i = 1 To Alen(_Screen.aProps, 1)
        loProp = _Screen.aProps[i]
        If Type("loProp") = "O"
            loProp.Destroy()
        Endif
    EndFor
    =RemoveProperty(_Screen, "nPropSize")
    =RemoveProperty(_Screen, "aProps")
EndFunc
&& ======================================================================== &&
&& Class FoxProperty
&& ======================================================================== &&
Define Class FoxProperty As Custom
    cSupportedTypes = "CDTNIYLO"
    lError    = .F.
    cErrorMsg = ""
    Hidden nPropIndex
    Hidden nCurIndex
    Hidden oProperty
    Dimension aPropName(1)
&& ======================================================================== &&
&& Function Init
&& ======================================================================== &&
    Function Init
        With This
            .oProperty = CreateObject("Empty")
        * this seal cannot be counted as a user property.
            .nPropIndex = 0
            .nCurIndex  = 0
            AddProperty(.oProperty, "Class", "FoxProperty")
        EndWith
    EndFunc
&& ======================================================================== &&
&& Function Put
&& ======================================================================== &&
    Function Put As Void
        lParameters tcPropKey As String, tvValue As Variant
        tcPropKey = evl(tcPropKey, "")
        If !Empty(tcPropKey) And Type("tvValue") $ This.cSupportedTypes
            =AddProperty(This.oProperty, tcPropKey, tvValue)
            This.nPropIndex = This.nPropIndex + 1
            Dimension This.aPropName(This.nPropIndex)
            This.aPropName[This.nPropIndex] = tcPropKey
        EndIf
    EndFunc
&& ======================================================================== &&
&& Function GetProperty
&& ======================================================================== &&
    Function GetProperty As Variant
        lParameters tcPropKey As String, tcDefaultValue As String
        Local lvValue As Variant
        tcDefaultValue = evl(tcDefaultValue, "")
        lvValue = tcDefaultValue
        If !Empty(tcPropKey)
            Try
                lvValue = Evaluate("This.oProperty." + tcPropKey)
            Catch
                lvValue = tcDefaultValue
            Endtry
        Endif
        Return lvValue
    EndFunc
&& ======================================================================== &&
&& Function HasNext
&& ======================================================================== &&
    Function HasNext As Boolean
        Local llHasNext As Boolean
        llHasNext = This.nCurIndex <= This.nPropIndex
        If Not llHasNext
            * end of iterations and reset for new ones.
            This.nCurIndex = 0
        Endif
        Return llHasNext
    EndFunc
&& ======================================================================== &&
&& Function Next
&& ======================================================================== &&
    Function Next As Boolean
        Local lvValue As Variant
        lvValue = .Null.
        If This.HasNext()
            If This.nCurIndex <= This.nPropIndex
                If Empty(This.nCurIndex)
                    This.nCurIndex = 1
                Endif
                lvValue = This.aPropName[This.nCurIndex]
                This.nCurIndex = This.nCurIndex + 1
            Endif
        Endif
        Return lvValue
    EndFunc
EndDefine