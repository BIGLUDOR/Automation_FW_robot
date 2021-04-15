*** Settings ***
Library    SSHLibrary
*** Variables ***

*** Keywords ***
Command Exec
     [Arguments]    ${ip}    ${comando}    ${port}=22156    ${user}=${USER}    ${pass}=${PASSWORD}
     Open Connection    ${ip}    port=${port}    timeout=5s
     Login    ${user}    password=${pass}
     Set client Configuration    prompt=${EMPTY}
     ${outcommand}    Execute Command    ${comando}    return_stdout=True
     Log    ${outcommand}
     Close Connection