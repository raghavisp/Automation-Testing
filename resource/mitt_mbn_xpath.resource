*** Variables ***
#Web elements Xpath

#MITT MBN xpath

${mittmbn_application_entry}=    //div[@class='application-entry']

${mittmbn_call_detected}=    //div[@class="mat-mdc-snack-bar-label mdc-snackbar__label"]
${mittmbn_call_active_tile}=    //gt-call-duration[normalize-space()="00:01"]
${mittmbn_call_active_outline}=     //div[@class="active-call-title"]

${mitt_mbn_contact_card_outline}=    //mat-card[contains(@class, 'mat-mdc-card') and contains(@class, 'primary-call')]
${mitt_mbn_caller_name}=    //h1[contains(@class, 'caller-name-title')]
${mitt_mbn_telephonenumber}=    //body[1]/gt-root[1]/mat-sidenav-container[1]/mat-sidenav-content[1]/user-main[1]/mat-drawer-container[1]/mat-drawer-content[1]/div[1]/user-contacts-and-calls[1]/mat-card[1]/div[2]/user-call-log[1]/div[1]/ngx-datatable[1]/div[1]/div[1]/datatable-body[1]/datatable-selection[1]/datatable-scroller[1]/datatable-row-wrapper[1]/datatable-body-row[1]/div[2]/datatable-body-cell[5]/div[1]/div[1]/div[1]
${mitt_mbn_tele_num}=    //div[contains(text(),"22 39 14 28")]
${mittmbn_Anropslogg_tab}=    //span[contains(text(),"Anropslogg")]
${mittmbn_searchbox_button}=    //mat-icon[@svgicon="search"]//*[name()="svg"]
${mittbmn_searchbox}=    //input[@placeholder="Søk på navn eller nummer"]
${mittmbn_name_frm_anropslogg}=    //div[@class="font-normal truncate-text" and normalize-space()="Move Tst At3-Ph3-4 22391307"]

${mittmbn_profile_section}=    //div[@class="profile"]
${mittmbn_profile_close_dialog}=    //button[@class="close-dialog-button mdc-icon-button mat-mdc-icon-button mat-unthemed mat-mdc-button-base cdk-focused cdk-program-focused"]//mat-icon[@role="img"]//*[name()="svg"]//*[name()="path" and contains(@d,"M8.03044 6")]

${mittmbn_Leggpå_outline}=    //button[@aria-label="active_call.disconnect_call"]//span[@class="mat-mdc-button-touch-target"]
${mittmbn_Leggpå}=    //span[normalize-space()="Legg på"]

${mittmbn_settpåvent_outline}=    //button[@aria-label="Sett på vent"]//span[@class="mat-mdc-button-touch-target"]
${mittmbn_settpåvent}=    //span[normalize-space()="Sett på vent"]

${mittmbn_gjenoppta_outline}=    //button[@aria-label="Hent inn aktivt anrop"]//span[@class="mat-mdc-button-touch-target"]
${mittmbn_gjenoppta}=    //span[normalize-space()="Gjenoppta"]

${mittmbn_Ledig_status_icon}=    //div[@fxlayoutalign="start start"]//div[@class="ng-star-inserted"]//*[name()="svg"]//*[name()="circle" and contains(@class,"ng-star-in")]
${mittmbn_isamtale_status_icon}=    //div[@fxlayoutalign="start start"]//div[@class="ng-star-inserted"]//*[name()="svg"]//*[name()="path" and contains(@class,"ng-star-in")]
${mittmbn_frakoblet_status_icon}=    //div[@fxlayoutalign="start start"]//div[@class="ng-star-inserted"]//*[name()="svg"]//*[name()="path" and contains(@fill,"#b3b1b1")]
${mittmbn_Ledig_status_text}=    //div[normalize-space()="Ledig"]
${mittmbn_isamtale_status_text}=    //div[normalize-space()="I samtale"]
${mittmbn_frakoblet_status_text}=    //div[normalize-space()="Frakoblet"]

${mitt_mbn_ring_button}=    //button[@class="mat-mdc-tooltip-trigger small-icon-button action-button btn-call mdc-icon-button mat-mdc-icon-button mat-unthemed mat-mdc-button-base ng-star-inserted"]//mat-icon[@role="img"]//*[name()="svg"]