CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

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


