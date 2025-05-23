*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Highlight Controls
    [Arguments]    ${element}    ${log_message}
    Execute JavaScript    if(arguments[0]) arguments[0].style.border='3px solid red';    ARGUMENTS    ${element}
    Sleep    2s
    Execute JavaScript    if(arguments[0]) arguments[0].style.border='';    ARGUMENTS    ${element}
    Log    ${log_message}


Click And Highlight
    [Arguments]    ${element}
    Click Element    ${element}
    Sleep    1s  # Wait for UI update
    Highlight Controls    ${element}    VIP Marked Successfully

Flash Element
    [Arguments]    ${element}    ${log_message}
    FOR    ${i}    IN RANGE    3
        Execute JavaScript    arguments[0].style.backgroundColor='yellow'    ARGUMENTS    ${element}
        Sleep    0.3s
        Execute JavaScript    arguments[0].style.backgroundColor=''    ARGUMENTS    ${element}
        Sleep    0.3s
    END
