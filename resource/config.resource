*** Variables ***

${MICROSIP_1_APP_NAME}    MicroSIP - 22391420
${MICROSIP_2_APP_NAME}    MicroSIP - 22391307
${MICROSIP_3_APP_NAME}    MicroSIP - 22391428

${MICROSIP_1_APP}   C:\\Users\\Skype og Lync test\\AppData\\Local\\MicroSIP\\microsip.exe
${MICROSIP_2_APP}   C:\\Users\\Skype og Lync test\\AppData\\Local\\MicroSIP2\\microsip.exe
${MICROSIP_3_APP}   C:\\Users\\Skype og Lync test\\AppData\\Local\\MicroSIP3\\microsip.exe

${PHONECPY_PATH}    C:\\Users\\Skype og Lync test\\scrcpy-win64-v3.1\\scrcpy.exe
${ADB_PATH}    C:\\Users\\Skype og Lync test\\scrcpy-win64-v3.1\\adb.exe


${PHONE_NUMBER_1}   22391420
${PHONE_NUMBER_2}   22391307
${PHONE_NUMBER_3}   22391428

${PHONE_NUMBER_3_S}   22 39 14 28
${PHONE_NUMBER_TO_Q}    46180220
${PHONE_NUMBER_SCRCPY_S}    461 80 785
${PHONE_NUMBER_SCRCPY}    46180785
${PHONE_NUMBER_EX}    46180033

${MBN_App_text}    Hei! For at Sentralbordet skal kunne betjene innringere på en enda bedre måte, er det viktig at du laster ned og bruker appen til Mobilt Bedriftsnett! Appen har en rekke funksjoner som fraværsmarkering, navneoppslag, konferanse, etc. Last ned appen "Telenor MBN" via App Store eller Google Play. Hilsen Sentralbordet
${Ring_SB}    Hei. Kan du ringe sentralbordet på telefonnummer 461 80 220.
${Ring til}    Hei. Kan du ringe  på telefonnummer  når du blir ledig? Hilsen Sentralbordet.
${Ingen mal valgt}    Hi, from Q via MicroSIP

${CRM}    http://www.1881.no/?query=<telefonnummer>
${CRM_07}    http://www.1881.no/?query=22391307
${EXPECTED_TEXT}    Move Tst At3-Ph3-4
${BUTTON_IMAGE}    aksepter_alt.png


${AD_SELECTOR}             css:.ad-banner, .popup-ad, .adsbygoogle
${OVERLAY_SELECTOR}        css:.overlay, .modal-backdrop, .popup-overlay
${DIALOG_CLOSE_BUTTON}     css:.dialog-close, .modal-close, .popup-close


${DEVICE_ID}    RFCR10EJB9N
${DEVICE_ID_46180517_GS6}    03157df3f0660025
#Login Credentials for SwitchBoard

${URL}    https://cpbx-at.telenor.no
${LOGIN_HINT}    22391420
${OTP}    12345
${BROWSER}    Chrome

${expected_color}=    Set Variable    (255, 255, 255, 0)

&{STATUS_COLORS}
...    Ledig=green
...    I samtale=red
...    Frakoblet=yellow

${IMAGE_PATH}     ${CURDIR}${/}images${/}account_22391428.png










