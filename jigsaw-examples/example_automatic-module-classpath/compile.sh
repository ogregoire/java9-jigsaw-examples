. ../env.sh

mkdir -p amlib
mkdir -p classes
mkdir -p cplib

pushd src > /dev/null 2>&1

# create non-modular jar cpa to be put onto the classpath
export dir=cpa
echo "$JAVA_HOME/bin/javac $JAVAC_OPTIONS   -d ../classes/${dir}   \$(find ${dir} -name \"*.java\")"
$JAVA_HOME/bin/javac $JAVAC_OPTIONS   -d ../classes/${dir}   $(find ${dir} -name "*.java")

echo "jar $JAR_OPTIONS --create --file=../cplib/${dir}.jar -C ../classes/${dir} ."
$JAVA_HOME/bin/jar $JAR_OPTIONS --create --file=../cplib/${dir}.jar -C ../classes/${dir} .

# compile automodmain as automatic module, i.e create an ordinary jar file
export dir=automodmain
echo "$JAVA_HOME/bin/javac $JAVAC_OPTIONS   -d ../classes/${dir}   \$(find ${dir} -name \"*.java\")"
$JAVA_HOME/bin/javac $JAVAC_OPTIONS  -cp ../cplib/* -d ../classes/${dir}   $(find ${dir} -name "*.java")

echo "jar $JAR_OPTIONS --create --file=../amlib/${dir}.jar -C ../classes/${dir} ."
$JAVA_HOME/bin/jar $JAR_OPTIONS --create --file=../amlib/${dir}.jar -C ../classes/${dir} .

popd >/dev/null 2>&1
