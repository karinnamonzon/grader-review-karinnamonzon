CPATH=".;../lib/junit-4.13.2.jar;../lib/hamcrest-core-1.3.jar"

rm -rf student-submission

git clone $1 student-submission
echo 'Finished cloning student-submission'

if [[ -f "student-submission/ListExamples.java" ]]
then
    echo 'ListExamples.java found'
else
    echo 'ListExamples.java not found'
    exit 1
fi 

cp TestListExamples.java student-submission/

cd student-submission

javac ListExamples.java
if [[ -f "ListExamples.class" ]] 
then
    echo "SUCCESSFUL COMPILE"
else
    echo "FAILURE TO COMPILE"
    exit 2
fi

javac -cp $CPATH *.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples

java -cp $CPATH org.junit.runner.JUnitCore student-submission/*.java > output.txt

grep "Tests run" output.txt > results.txt

TESTSRUN=` cut -d ',' -f 1 results.txt `

FAILURES=` cut -d ',' -f 2 results.txt `

NUMFAILURES="${FAILURES//[^0-9]/}"

NUMTESTS="${TESTSRUN//[^0-9]/}"
