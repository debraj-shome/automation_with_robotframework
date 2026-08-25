*** Settings ***
Library             SeleniumLibrary

*** Keywords ***
Enter Username
        [Arguments]    ${username}
        Wait Until Element Is Visible    xpath=//*[@id="app"]/div[1]/div/div[1]/div/div[2]/div[2]/form/div[1]/div/div[2]/input
        Input Text    xpath=//*[@id="app"]/div[1]/div/div[1]/div/div[2]/div[2]/form/div[1]/div/div[2]/input    ${username}

Enter Password
        [Arguments]    ${password}
        Wait Until Element Is Visible    xpath=//*[@id="app"]/div[1]/div/div[1]/div/div[2]/div[2]/form/div[2]/div/div[2]/input
        Input Text    xpath=//*[@id="app"]/div[1]/div/div[1]/div/div[2]/div[2]/form/div[2]/div/div[2]/input    ${password}

Click Login Button
        Wait Until Element Is Visible    xpath=//*[@id="app"]/div[1]/div/div[1]/div/div[2]/div[2]/form/div[3]/button
        Click Button    xpath=//*[@id="app"]/div[1]/div/div[1]/div/div[2]/div[2]/form/div[3]/button

Login With Credentials
        [Arguments]    ${username}=${VALID_USERNAME}    ${password}=${VALID_PASSWORD}
    Enter Username    ${username}
    Enter Password    ${password}
        Click Login Button

Verify Dashboard
    Wait Until Element Is Visible
    ...    xpath=//*[@id="app"]/div[1]/div[1]/header/div[1]/div[1]
    ...    ${TIMEOUT}

Verify Invalid Credentials Message
    Wait Until Element Is Visible
    ...    xpath=//*[@id="app"]/div[1]/div/div[1]/div/div[2]/div[2]/div/div[1]/div[1]
    ...    ${TIMEOUT}

Element Should Contain
    ...    xpath=//*[@id="app"]/div[1]/div/div[1]/div/div[2]/div[2]/div/div[1]
    ...    Invalid credentials

Verify Username Required Message
    Wait Until Page Contains Element
    ...    xpath=//*[@id="app"]/div[1]/div/div[1]/div/div[2]/div[2]/form/div[1]/div/span
    ...    ${TIMEOUT}


Verify Password Required Message
    Wait Until Page Contains Element
    ...    xpath=//*[@id="app"]/div[1]/div/div[1]/div/div[2]/div[2]/form/div[2]/div/span
    ...    ${TIMEOUT}


Verify Login Page Is Displayed
    Wait Until Element Is Visible
    ...    name=username
    ...    ${TIMEOUT}


Clear Login Fields
    Clear Element Text    name=username
    Clear Element Text    name=password


Logout From OrangeHRM
    Click Element
    ...    xpath=//*[@id="app"]/div[1]/div[1]/header/div[1]/div[3]/ul/li/span/i

    Wait Until Element Is Visible
    ...    xpath=//*[@id="app"]/div[1]/div[1]/header/div[1]/div[3]/ul/li/ul/li[4]/a

    Click Element
    ...    xpath=//*[@id="app"]/div[1]/div[1]/header/div[1]/div[3]/ul/li/ul/li[4]/a

    Verify Login Page Is Displayed