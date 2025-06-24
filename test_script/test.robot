*** Settings ***
Library     FlaUILibrary
Library     BuiltIn

Suite Setup     #FOF eg.log in to SB
Suite Teardown  #FOF    eg. close SB and Kill MicrpSIP


#resource    asdf.robot

*** Variables ***
${MICROSIP_1_APP}   C:\\Users\\Skype og Lync test\\AppData\\Local\\MicroSIP\\microsip.exe
${MICROSIP_2_APP}   C:\\Users\\Skype og Lync test\\AppData\\Local\\MicroSIP2\\microsip.exe
${MICROSIP_3_APP}   C:\\Users\\Skype og Lync test\\AppData\\Local\\MicroSIP3\\microsip.exe

${PHONE_NUMBER_1}   22391428
${MICROSIP_1_PROCESS}    None

${MICROSIP_1_APP_NAME}    MicroSIP - 22391420
${MICROSIP_2_APP_NAME}    MicroSIP - 22391307
${MICROSIP_3_APP_NAME}    MicroSIP - 22391428


*** Test Cases ***
Launch MicroSIP
    Log    FlaUILibrary is working!
    Launch MicroSIP    ${MICROSIP_1_APP}
    Launch MicroSIP    ${MICROSIP_2_APP}
    Launch MicroSIP    ${MICROSIP_3_APP}

Close MicroSIP
    Close MicroSIP    ${MICROSIP_1_APP_NAME}
    Close MicroSIP    ${MICROSIP_2_APP_NAME}
    Close MicroSIP    ${MICROSIP_3_APP_NAME}

*** Keywords ***
Launch MicroSIP
    [Arguments]    ${app_path}
    [Documentation]    Launches the MicroSIP application.
    ${pid}    Launch Application    ${app_path}
    Log    ${pid}
    BuiltIn.Sleep    3s


Close MicroSIP
    [Arguments]    ${MICROSIP_APP_NAME}
    [Documentation]    Launches the MicroSIP application.
    Click    /Window[@Name='${MICROSIP_APP_NAME}']/TitleBar/Button[@Name='Close']
    BuiltIn.Sleep    3s