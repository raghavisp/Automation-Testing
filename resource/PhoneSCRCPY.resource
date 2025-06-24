*** Settings ***
Library     FlaUILibrary        WITH NAME    Micro
Library     BuiltIn
Library     Process
Library     DateTime
Library     XML



Resource    ../resource/config.resource
Resource    web_elements.resource

*** Keywords ***

#********************************************************************************************************************************************************************************************************************************************************************************

# PCY 1 46180785

#********************************************************************************************************************************************************************************************************************************************************************************


Launch PhoneCpy1
    [Documentation]    Launches the Phone Cpy Application.
    Log    📱 Launching Scrcpy for phone screen mirroring...
    Start Process    scrcpy -s ${DEVICE_ID} --max-size 620 --window-x 3080 --window-y 100 --stay-awake    shell=True    stdout=NONE    stderr=NONE
    Sleep    4s

MakeCall From PCY1
    [Documentation]    Make a phone call using ADB on a specific device.
    [Arguments]    ${phone_number}
    Log    📞 Dialing ${phone_number} on device ${DEVICE_ID}...
    Run Process    ${ADB_PATH1}    -s    ${DEVICE_ID}    shell    am    start    -a    android.intent.action.CALL    -d    tel:${phone_number}    stdout=NONE    stderr=NONE


Check Phone Is Ringing
    ${result}=    Run Process    ${ADB_PATH1}    -s    ${DEVICE_ID}    shell    dumpsys telephony.registry | grep mCallState    stdout=PIPE
    Log    ${result.stdout}
    ${lines}=    Split To Lines    ${result.stdout}
    ${ringing_found}=    Set Variable    False

    FOR    ${line}    IN    @{lines}
        IF    "mCallState=1" in $line
            ${ringing_found}=    Set Variable    True
        END
    END

    IF    not ${ringing_found}
        Fail    Phone is NOT ringing (no mCallState=1 found).
    END

Check If Call Is Active
    ${output}=    Run Process    ${ADB_PATH1}    -s    ${DEVICE_ID}    shell    dumpsys telephony.registry | grep mCallState  stdout=PIPE    shell=True
    Log    ${output.stdout}
    Should Contain    ${output.stdout}    mCallState

End Call From PCY1
    [Documentation]    Ends the ongoing call on the selected device.
    Log    🔴 Ending call on device ${DEVICE_ID}...
    Run Process    ${ADB_PATH1}    -s    ${DEVICE_ID}    shell    input    keyevent    KEYCODE_ENDCALL    stdout=NONE    stderr=NONE


Unlock Device Screen1
    Run Process    ${ADB_PATH1}    -s    ${DEVICE_ID}    shell    input keyevent KEYCODE_WAKEUP
    Sleep    1s
    Run Process    ${ADB_PATH1}    -s    ${DEVICE_ID}    shell    input swipe 1000 2000 1000 5150
    Sleep    1s


Open SMS Conversation From Caller
    [Arguments]    ${phone_number}
    Sleep    7s
    Start Process    ${ADB_PATH1}    -s    ${DEVICE_ID}    shell    input keyevent KEYCODE_HOME
    Sleep    1s
    Log    📨 Opening SMS thread with ${phone_number}...
    Run Process    ${ADB_PATH1}    -s    ${DEVICE_ID}    shell    am start -a android.intent.action.VIEW -d sms:${phone_number}
    Sleep    3s


Incoming Call PCY1
    Sleep    1s
    Start Process    ${ADB_PATH1}    -s    ${DEVICE_ID}    shell dumpsys telephony.registry
    Log    ✅ Incoming call
    Sleep    2s

Answer Call PCY1
    Run Process    ${ADB_PATH1}    -s    ${DEVICE_ID}    shell    input keyevent KEYCODE_CALL
    Sleep    1s
    Log    ✅ Call answered and active
    Sleep    5s

#********************************************************************************************************************************************************************************************************************************************************************************
#********************************************************************************************************************************************************************************************************************************************************************************

# PCY 2 46180517

#********************************************************************************************************************************************************************************************************************************************************************************

Launch PhoneCpy2
    [Documentation]    Launches scrcpy for Phone 2 (GS6).
    Log    📱 Launching Scrcpy for phone screen mirroring...
    Start Process    scrcpy    -s    ${DEVICE_GS10}    --max-size    620    --window-x    3080    --window-y    750    --stay-awake    stdout=log.txt    stderr=log.txt
    Sleep    5s


Launch PhoneCpy2 For SMS
    [Documentation]    Launches scrcpy for Phone 2 (GS6).
    Log    📱 Launching Scrcpy for phone screen mirroring...
    Start Process    scrcpy    -s    ${DEVICE_GS10}    --max-size    620    --window-x    2775    --window-y    750    --stay-awake    stdout=log.txt    stderr=log.txt
    Sleep    5s


Open SMS Conversation From Caller2
    [Arguments]    ${phone_number}
    Sleep    7s
    Start Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    input keyevent KEYCODE_HOME
    Sleep    1s
    Log    📨 Opening SMS thread with ${phone_number}...
    Run Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    am start -a android.intent.action.SENDTO -d sms:${phone_number} --es sms_body "" --ez exit_on_sent true
    Sleep    3s

Unlock Device Screen2
    Run Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    input keyevent KEYCODE_WAKEUP
    Sleep    1s
    Run Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    input swipe 1000 2000 1000 5150
    Sleep    1s

Click Home in PCY2
    Start Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    input keyevent KEYCODE_HOME
    Sleep    1s

MakeCall From PCY2
    [Documentation]    Make a phone call using ADB on a specific device.
    [Arguments]    ${phone_number}
    Log    📞 Dialing ${phone_number} on device ${DEVICE_GS10}...
    Run Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    am    start    -a    android.intent.action.CALL    -d    tel:${phone_number}    stdout=NONE    stderr=NONE


Incoming Call PCY2
    Sleep    1s
    Start Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell dumpsys telephony.registry
    Log    ✅ Incoming call
    Sleep    2s


Answer Call PCY2
    [Documentation]    Unlocks phone and answers incoming call on GS6
    Run Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    input keyevent KEYCODE_CALL
    Sleep    1s
    Log    ✅ Call answered and active
    Sleep    5s


End Call From PCY2
    [Documentation]    Ends the ongoing call on the selected device.
    Log    🔴 Ending call on device ${DEVICE_GS10}...
    Run Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    input    keyevent    KEYCODE_ENDCALL    stdout=NONE    stderr=NONE
    Log    ✅ Call Ended
    Sleep    1s


Check Phone Is Ringing2
    ${result}=    Run Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    dumpsys telephony.registry | grep mCallState    stdout=PIPE
    Log    ${result.stdout}
    ${lines}=    Split To Lines    ${result.stdout}
    ${ringing_found}=    Set Variable    False

    FOR    ${line}    IN    @{lines}
        IF    "mCallState=1" in $line
            ${ringing_found}=    Set Variable    True
        END
    END

    IF    not ${ringing_found}
        Fail    Phone is NOT ringing (no mCallState=1 found).
    END

Check If Call Is Active2
    ${output}=    Run Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    dumpsys telephony.registry | grep mCallState  stdout=PIPE    shell=True
    Log    ${output.stdout}
    Should Contain    ${output.stdout}    mCallState

#************************************************************************************************************************************************************************************

# PCY External bruker 46180033

#************************************************************************************************************************************************************************************


Launch PhoneCpy3
    [Documentation]    Launches scrcpy for Phone 2 (GS6).
    Log    📱 Launching Scrcpy for phone screen mirroring...
    Start Process    scrcpy    -s    ${Device_ID_EX_033}    --max-size    620    --window-x    2775    --window-y    150    --stay-awake    stdout=log.txt    stderr=log.txt
    Sleep    5s


Answer Call PCY3
    [Documentation]    Unlocks phone and answers incoming call on GS6
    Run Process    ${ADB_PATH3}    -s    ${Device_ID_EX_033}    shell    input keyevent KEYCODE_CALL
    Sleep    1s
    Log    ✅ Call answered and active
    Sleep    5s


Unlock Device Screen3
    Run Process    ${ADB_PATH3}    -s    ${Device_ID_EX_033}    shell    input keyevent KEYCODE_WAKEUP
    Sleep    1s
    Run Process    ${ADB_PATH3}    -s    ${Device_ID_EX_033}    shell    input swipe 500 2000 1000 5150
    Sleep    1s


Click To Go Back Twice3
    Log To Console    Going back twice
    Run Process    ${ADB_PATH3}    shell    input    keyevent    KEYCODE_BACK
    Sleep    1s    # Optional: Wait for the first back press to take effect
    Run Process    ${ADB_PATH3}    shell    input    keyevent    KEYCODE_BACK
    Sleep    3s    # Optional: Wait for the second back press to take effect
    Log To Console    Back button pressed twice


Open SMS Conversation From Caller3
    [Arguments]    ${phone_number}
    Sleep    7s
    Start Process    ${ADB_PATH3}    -s    ${Device_ID_EX_033}    shell    input keyevent KEYCODE_HOME
    Sleep    1s
    Log    📨 Opening SMS thread with ${phone_number}...
    Run Process    ${ADB_PATH3}    -s    ${Device_ID_EX_033}    shell    am start -a android.intent.action.SENDTO -d sms:${phone_number} --es sms_body "" --ez exit_on_sent true
    Sleep    3s


Get Email Body

    Run Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    uiautomator dump
    Run Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    pull    /sdcard/window_dump.xml    view.xml
    ${xml}=    Get File    view.xml
    Log    ***************************************
    Log    UI Dump XML:
    Log    ${xml}
    Log    ***************************************
    ${tree}=    Parse XML    ${xml}
    ${root}=    Get Element    ${tree}    .
    ${nodes}=    Get Elements    ${root}    .//node[@resource-id='com.google.android.gm:id/viewified_conversation_item_view']
    ${text}=    XML.Get Element Attribute    ${nodes[0]}    text
    Log    ****************************************
    Log    Email Body: ${text}
    Log    ****************************************

Get Email Access
    Run Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    am start -n com.google.android.gm/com.google.android.gm.ConversationListActivityGmail
    Sleep    3s
    # Tap Search Bar
    Run Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    input tap 626 300
    Sleep    2s
    # Input sender name, replace spaces by %s
    ${text}=    Replace String    ${SENDER_NAME}    ${SPACE}    %s
    Run Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    input text ${text}
    Sleep    4s
    # Tap latest email — **replace with real coordinates**
    Run Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    input tap 612 874
    Sleep    3s

#************************************************************************************************************************************************************************************
 #COMMON FUNCTION

Get Last SMS Information
    [Arguments]    ${adbpath}    ${deviceid}
    Sleep    1s
    ${command1}=    Set Variable    content query --uri content://sms
    ${command2}=    Set Variable    awk '/^Row:/ { if (NR!=1) print ""; printf "%s", $0; next } { printf " %s", $0 } END { print "" }'
    ${command3}=    Set Variable    grep 'Row: 0' | grep '46180220'
    ${command4}=    Set Variable    awk -F", body=" '{split($1,a,", "); for(i in a){ if(a[i] ~ /^address=/) addr=a[i]; if(a[i] ~ /^date_sent=/) datesent=a[i]; if(a[i] ~ /^date=/) date=a[i]; } split($2,b,", service_center="); print addr ":" date ":" datesent ":" "body=" b[1] }'
    ${command}=    Set Variable    ${command1} | ${command2} | ${command3} | ${command4}
    ${result}=    Run Process    ${adbpath}    -s    ${deviceid}    shell    ${command}    shell=True    stdout=PIPE    output_encoding=UTF-8
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

    IF    '${body}' == '${MBN_App_text}'
    Log    result for MBN App: ${body}
    ELSE IF    '${body}' == '${Ring_SB}'
        Log    result for Ring SB Option: ${body}
    ELSE IF    '${body}' == '${Ring til}'
        Log    result for Ring SB Option: ${body}
    ELSE IF    '${body}' == '${Ingen mal valgt}'
        Log    result for Custom Message: ${body}
    ELSE
        Log    none of the above
    END



Click On Recent Apps Button And Close All
    [Arguments]    ${ADB_PATHS}
    Log To Console    Opening Recent Apps...
    Run Process    ${ADB_PATHS}    shell    input keyevent KEYCODE_APP_SWITCH
    Log To Console    Tapping Close All...
    Sleep    5s
    Run Process    ${ADB_PATHS}    shell    input tap    560    1876    # Use correct coordinates
    Sleep    2s
    Log To Console    Done

Click To Go Back Twice
    [Arguments]    ${ADB_PATH}
    Log To Console    Going back twice
    Run Process    ${ADB_PATH}    shell    input    keyevent    KEYCODE_BACK
    Sleep    1s    # Optional: Wait for the first back press to take effect
    Run Process    ${ADB_PATH}    shell    input    keyevent    KEYCODE_BACK
    Sleep    3s    # Optional: Wait for the second back press to take effect
    Log To Console    Back button pressed twice


Close PCY
    [Arguments]    ${Phonecpypath}
    Close Application By Name    ${Phonecpypath}
     Sleep    2s
    Log To Console    scrcpy Application is closed

#********************************************************************************************************************************************************************************************************************************************************************************
 #FOF

Open SMS App3
    #Launch PhoneCpy3
    Open SMS Conversation From Caller3    ${PHONE_NUMBER_TO_Q}
    Get Last SMS Information    ${ADB_PATH3}    ${Device_ID_EX_033}
    Click To Go Back Twice3
    Sleep    2s
    Click On Recent Apps Button And Close All    ${ADB_PATH3}
    Sleep    5s


Open SMS App2
    #Launch PhoneCpy2
    Unlock Device Screen2
    Open SMS Conversation From Caller2    ${PHONE_NUMBER_TO_Q}
    Get Last SMS Information    ${ADB_PATH2}    ${DEVICE_GS10}
    Click To Go Back Twice    ${ADB_PATH2}
    Sleep    2s
    Click On Recent Apps Button And Close All    ${ADB_PATH2}
    Sleep    5s

#********************************************************************************************************************************************************************************************************************************************************************************

# EMAIL

check email
    Launch PhoneCpy2
    Unlock Device Screen2
    Run Process    ${ADB_PATH2}    -s    ${DEVICE_GS10}    shell    am start -n com.google.android.gm/com.google.android.gm.ConversationListActivityGmail




