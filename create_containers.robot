*** Settings ***
Library    SSHLibrary

*** Variables ***

*** Keywords ***
Command Exec
     Open Connection    9.86.132.28    port=22156    timeout=5s
     Login    root    password=cluster
     Set client Configuration    prompt=${EMPTY}
     Write    /home/fab3/csc-dev/ESS3kAutomation/main3k.sh
     Read Until    W3
     Write    ${EMAIL}
     ${result}=    Read Until    password
     Write    ${PASSWORD}
     ${result}=    Read Until    Data
     Validate result    ${result}

Validate result
     [Arguments]    ${var}
     Should Not Contain    ${var}    ERROR    msg=Failure!
     ${DataAccess}=     Run Keyword And Ignore Error    Should Contain    ${var}    DataAccess
     ${DataManagement}=     Run Keyword And Ignore Error    Should Contain    ${var}    DataManagement
     Run Keyword If    ${DataAccess} or ${DataManagement}    Pass Execution    Entro





*** Test Cases ***
Test Commands
     [Documentation]    Esta prueba es una prueba
     Command Exec
