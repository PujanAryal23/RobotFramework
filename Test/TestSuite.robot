*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

Suite Setup    Log    Suite Setup
Test Setup    Log     Test ${TEST NAME} Setup   

Suite Teardown    Log    Suite Completed
Test Teardown     Log    Test ${TEST NAME} Completed

Default Tags    sanity

*** Variable ***
${testsRootFolder}    ${EXECDIR}/driver/
${searchField}        //input[@name="q"]
${buttonSearch}       //input[@name="btnK"]
${userName}           //input[@id="txtUsername"]
${passWord}           //input[@id="txtPassword"]
${loginBtn}           //input[@id="btnLogin"]
@{urls}               https://opensource-demo.orangehrmlive.com    https://google.com
&{credentials}        username=Admin    password=admin123

*** Keywords ***
Open Browser Locally
    Append To Environment Variable  PATH    ${testsRootFolder}	
    ${chrome_options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    ${options}=     Call Method     ${chrome_options}    to_capabilities    
    Open Browser   ${urls}[0]     chrome    desired_capabilities=${options}

*** Test Cases ***

FirstTest
    [Tags]    smoke
    Log    test   
    
FirstSeleniumTest
    Append To Environment Variable  PATH    ${testsRootFolder}	
    ${chrome_options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    ${options}=     Call Method     ${chrome_options}    to_capabilities    
    Open Browser   ${urls}[1]     chrome    desired_capabilities=${options}
    Set Browser Implicit Wait    5
    Input Text    ${searchField}    Test
    Sleep    2
    Click Button    ${buttonSearch}        
    Close Browser
    
LoginTest
    [Documentation]    This is a sample login test
    Open Browser Locally
    Set Browser Implicit Wait    3
    Input Text    ${userName}    ${credentials}[username]    
    Input Text    ${passWord}    ${credentials}[password]
    Click Button    ${loginBtn}
    Sleep    3   
    Close Browser
    Log    Login Complete
    Log    This test was executed by %{HOME}
    
Sample Test
    Log    Just For Testing
     


