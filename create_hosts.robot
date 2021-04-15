*** Settings ***
Library    SSHLibrary
Resource    /Library_keywords/command_exec.robot

*** Variables ***


*** Keywords ***
Delete keys
    [Documentation]    with this Keywork We can delete SSH keys
    [Arguments]    ${ip}
    Command Exec    ${ip}    rm -rf /root/.ssh/*
    #ssh-keygen -q -trs a -N '' -f ~/.ssh/id_rsa >/2dev/null <<< y >/dev/null

Generate Keys
    [Documentation]    Generating keys to SSH
    Open Connection    ${ip}    port=${port}    timeout=5s
    Login    ${user}    password=${pass}
    Set client Configuration    prompt=${EMPTY}
    Write    ssh-keygen
    Read Until    "(/root/.ssh/id_rsa):"
    Write    ${EMPTY}
    Read Until    "(empty for no passphrase):"
    Write    ${EMPTY}
    Read Until    "same passphrase again:"
    Write    ${EMPTY}
    Close Connection


    

*** Test Cases ***
Append And Review Hosts
     [Documentation]    Revision de Hosts
     Command Exec    ${JUMP_IP}   echo "127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4" > /etc/hosts    port=${GEMS_PORT}
     Command Exec    ${JUMP_IP}   cat /etc/hosts    port=${GEMS_PORT}
     ${len_ips}    Get Length    ${MGMT_IPS}
     FOR    ${index}    IN RANGE    ${len_ips}
         Command Exec    ${JUMP_IP}    echo "${MGMT_IPS}[${index}] ${MGMT_HOSTNAMES}[${index}]${DOMAIN} ${MGMT_HOSTNAMES}[${index}]" >> /etc/hosts    port=${GEMS_PORT}
     END
     ${len_HS}    Get Length    ${HS_IPS}
     FOR    ${index}    IN RANGE    ${len_HS}
        Command Exec    ${JUMP_IP}    echo "${HS_IPS}[${index}] ${HS_HOSTNAMES}[${index}]${DOMAIN} ${HS_HOSTNAMES}[${index}]" >> /etc/hosts    port=${GEMS_PORT}
     END
     Command Exec    ${JUMP_IP}   cat /etc/hosts    port=${GEMS_PORT}
