*** Settings ***
Library     FlaUILibrary        WITH NAME    Micro
Library     BuiltIn
Library     Process
Library     DateTime


Resource    ../resource/config.resource
Resource    web_elements.resource




*** Keywords ***
Launch PhoneCpy
    [Documentation]    Launches the Phone Cpy Application.
    Log    📱 Launching Scrcpy for phone screen mirroring...
    Start Process    scrcpy --max-size 500 --always-on-top --stay-awake    shell=True    stdout=NONE    stderr=NONE
    Sleep    4s


MakeCall From PCY
    [Documentation]    Make a phone call using ADB on a specific device.
    [Arguments]    ${phone_number}
    Log    📞 Dialing ${phone_number} on device ${DEVICE_ID}...
    Run Process    ${ADB_PATH}    -s    ${DEVICE_ID}    shell    am    start    -a    android.intent.action.CALL    -d    tel:${phone_number}    stdout=NONE    stderr=NONE

End Call From PCY
    [Documentation]    Ends the ongoing call on the selected device.
    Log    🔴 Ending call on device ${DEVICE_ID}...
    Run Process    ${ADB_PATH}    -s    ${DEVICE_ID}    shell    input    keyevent    KEYCODE_ENDCALL    stdout=NONE    stderr=NONE


Unlock Device Screen
    Run Process    ${ADB_PATH}    -s    ${DEVICE_ID}    shell    input keyevent KEYCODE_WAKEUP
    Sleep    1s
    Run Process    ${ADB_PATH}    -s    ${DEVICE_ID}    shell    input swipe 1000 2000 1000 5150
    Sleep    1s


Open SMS Conversation From Caller
    [Arguments]    ${phone_number}
    Sleep    7s
    Start Process    ${ADB_PATH}    -s    ${DEVICE_ID}    shell    input keyevent KEYCODE_HOME
    Sleep    1s
    Log    📨 Opening SMS thread with ${phone_number}...
    Run Process    ${ADB_PATH}    -s    ${DEVICE_ID}    shell    am start -a android.intent.action.VIEW -d sms:${phone_number}
    Sleep    3s


Incoming Call PCY
    Sleep    1s
    Start Process    ${ADB_PATH}    -s    ${DEVICE_ID}    shell dumpsys telephony.registry
    Log    ✅ Incoming call

Answer Call PCY
    Run Process    ${ADB_PATH}    -s    ${DEVICE_ID}    shell    input keyevent KEYCODE_CALL
    Sleep    1s
    Log    ✅ Call answered and active


Get Last SMS Information
    Sleep    1s
    ${command1}=    Set Variable    content query --uri content://sms
    ${command2}=    Set Variable    awk '/^Row:/ { if (NR!=1) print ""; printf "%s", $0; next } { printf " %s", $0 } END { print "" }'
    ${command3}=    Set Variable    grep 'Row: 0' | grep '46180220'
    ${command4}=    Set Variable    awk -F", body=" '{split($1,a,", "); for(i in a){ if(a[i] ~ /^address=/) addr=a[i]; if(a[i] ~ /^date_sent=/) datesent=a[i]; if(a[i] ~ /^date=/) date=a[i]; } split($2,b,", service_center="); print addr ":" date ":" datesent ":" "body=" b[1] }'
    ${command}=    Set Variable    ${command1} | ${command2} | ${command3} | ${command4}
    ${result}=    Run Process    ${ADB_PATH}    -s    ${DEVICE_ID}    shell    ${command}    shell=True    stdout=PIPE    output_encoding=UTF-8
    ${sms_raw}=    Convert To String   ${result.stdout}
    #address=+47123456:date=1746:date_sent=1746:body=Heixxxx.
    Log    ***************************************
    Log    SMS RAW body: ${sms_raw}
    Log    ***************************************

    # Split the sms raw with :
    ${parts}=          Split String    ${sms_raw}    :
    # Split the individual elements with = from parts :
    ${addr_pair}=      Split String    ${parts[0]}    =    #address=+47123456
    ${date_pair}=      Split String    ${parts[1]}    =
    ${sent_pair}=      Split String    ${parts[2]}    =
    ${body_pair}=      Split String    ${parts[3]}    =

    ${address}=        Get From List   ${addr_pair}    1
    ${date}=           Get From List   ${date_pair}    1
    ${timestamp_raw}=      Get From List   ${sent_pair}    1
    ${body}=           Get From List   ${body_pair}    1

    # Converting SMS Timestamp
    ${datetime}=    Evaluate    __import__('datetime').datetime.fromtimestamp(float(${timestamp_raw})/1000).strftime('%Y-%m-%d %H:%M:%S')

    # Printing address, SMS Timestamp, SMS body
    Log    ***************************************
    Log    Address: ${address}
    Log    Date Sent: ${datetime}
    Log    Body: ${body}
    Log    ***************************************

     ${status}=    Run Keyword And Return Status    Should Be Equal As Strings    ${body}    ${MBN_App_text}
     Log    result for  MBN App: ${status}


Click On Recent Apps Button And Close All
    Log To Console    Opening Recent Apps...
    Run Process    ${ADB_PATH}    shell    input keyevent KEYCODE_APP_SWITCH
    Log To Console    Tapping Close All...
    Sleep    5s
    Run Process    ${ADB_PATH}    shell    input tap    560    1876    # Use correct coordinates
    Sleep    2s
    Log To Console    Done

Click To Go Back Twice
    Log To Console    Going back twice
    Run Process    ${ADB_PATH}    shell    input keyevent KEYCODE_BACK
    Sleep    1s    # Optional: Wait for the first back press to take effect
    Run Process    ${ADB_PATH}    shell    input keyevent KEYCODE_BACK
    Sleep    3s    # Optional: Wait for the second back press to take effect
    Log To Console    Back button pressed twice


Close PCY
    Close Application By Name    ${PHONECPY_PATH}
    Sleep    2s
    Log To Console    scrcpy Application is closed



#************************************************************************************************************************************************************************************
 #FOF
 Open SMS App
    Launch PhoneCpy
    Unlock Device Screen
    Open SMS Conversation From Caller    ${PHONE_NUMBER_TO_Q}
    Get Last SMS Information
    Click To Go Back Twice
    Sleep    4s
    Click On Recent Apps Button And Close All
    Sleep    5s