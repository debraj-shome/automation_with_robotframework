*** Settings ***
Library             SeleniumLibrary

*** Keywords ***
Open Browser To OrangeHRM
        Open Browser    ${url}      ${browser}
        Maximize Browser Window
        Set Selenium Timeout        ${TIMEOUT}
        Set Selenium Speed          ${ACTION_DELAY}

Close Application
        Sleep    3s
        Close All Browsers

Capture Screenshot on Failure
        Run Keyword If Test Failed    Capture Page Screenshot