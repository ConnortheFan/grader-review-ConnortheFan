#CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'
CPATH=".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar"

# if [[ $# -lt 1]]
# then 
#     echo "Missing arguments!"
#     exit 1
# fi

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

if [[ -e student-submission/ListExamples.java ]]
then 
    echo "ListExamples.java found"
else
    echo "File ListExamples.java not found"
    exit 1
fi

cp -r lib student-submission/
cp TestListExamples.java student-submission/
cd student-submission/

set +e
javac -cp $CPATH *.java

if [[ $? -eq 0 ]]
then
    echo "Compile succeeded"
else
    echo "Failed to compile" 
    exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test-results.txt

echo "--------- Test results ------------"
# cat test-results.txt
#grep --color -w "OK\|FAILURES!!!" test-results.txt 
#grep --color "Failures:" test-results.txt 

GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

if grep -q "OK" test-results.txt; then
    echo -e "${GREEN}Test is all good, very nice 10/10${NC}"
fi


if grep --color "FAILURES!!!" test-results.txt; then
    grep --color "Failures:" test-results.txt
    #grep 'There were ' test-results.txt
    NUMBER=$(grep 'There were ' test-results.txt | tr -dc '0-9')

    for i in $( eval echo {1..$NUMBER} )
    do
        grep "$i)" test-results.txt
    done
    
    echo -e "${RED}Test failed. Try harder next time ${NC};("
fi



