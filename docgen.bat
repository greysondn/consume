@REM far from elegant but it gets the job done

@ECHO "-----------------------------------"
@ECHO "Generating required XML"
@ECHO "This might fail if compilation fails"
@ECHO "-----------------------------------"
lime build flash -debug -Dfdb -xml


@REM Gen docs
@ECHO "-----------------------------------"
@ECHO "Generating Docs from XML"
@ECHO "-----------------------------------"
haxelib run dox -i export\flash\types.xml -o export\codedoc