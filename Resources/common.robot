*** Settings ***
Library         DatabaseLibrary
Library         DateTime
Library         Collections
Library         BuiltIn
Library         RequestsLibrary
Library         OperatingSystem
Library         FakerLibrary
Library         SeleniumLibrary    timeout=60
Library         String
Library         json
Library         JSONLibrary
Library         Process
Library         Libs/SchemaLibrary.py    Resources/schemas/
Library         Libs/CustomKeywords.py



Variables        apischema.yaml
Variables        ../Data/Config/live.yml

*** Variables ***
${VCS_BASE_URL}             https://api-vcs-staging.jumia.services/api/v2
# ${UVR_BASE_URL}             https://api-uvr-staging.jumia.services/api/v2




${GLOBALTIMEOUT}            200 ms

${validgetresponse}         200
${validcreateresponse}      201
${validupdateresponse}      200
${validdeleteresponse}      204

*** Keywords ***
Response Body Should Be Valid against schema
    [Documentation]    validate json respose against response schema
    [Arguments]    ${schema}    ${response}
    Log Many    ${schema}    ${response}
    Validate Json    ${schema}    ${response}

Count Should Be as expected
    [Arguments]    ${response}    ${locator}    ${expectedcount}
    ${data1}    get value from json    ${response}    ${locator}
    ${actual_count}    Get Length    ${data1}
    Should Be Equal As Integers    ${actual_count}    ${expectedcount}

Render the Query Params
    [Arguments]    ${templatefile}    &{params}
    ${qryparams}    Get File    ./Resources/templates/params/${templatefile}
    ${qryparams}    Render The Template    ${qryparams}    &{params}
    Log    ${qryparams} 
    ${qryparams}    Set Variable    ${qryparams.strip()}
    ${ln}    Get Length    ${qryparams}
    IF    ${ln}<1    RETURN    ${None}
    @{lines}    Split To Lines    ${qryparams}
    ${length}    Get Length    ${lines}
    &{qryParams}    Create Dictionary
    FOR    ${line}    IN    @{lines}
        @{row}    Split String    ${line}    :
        Log List    ${row}
        ${key}    Set Variable    ${row}[0]
        ${value}    Evaluate    ":".join($row[1:])    # ${row}[-1]
        Set To Dictionary    ${qryParams}    ${key.strip()}=${value.strip()}
    END
    RETURN    ${qryParams}



Render file dictionary
    [Arguments]    ${filedescriptor}    &{params}
    ${conetnts}    Get Binary File    ${filedescriptor}
    &{files}    Create Dictionary    file=${conetnts}
    RETURN    ${files}

Api call
    [Arguments]    ${apiname}    &{params}
    ${descriptor}    Set Variable    ${APIs.${apiname}}
    ${template}    Get File    ./Resources/templates/body/${descriptor.bodyTemplate}
    &{reqparams}    Create Dictionary    &{params}
    ${body}    Render The Template    ${template}    &{reqparams}
    log    ${body}

    ${headers}    get file    ./Resources/templates/header/${descriptor.headers}
    ${reqheaders}    Render The Template    ${headers}    &{reqparams}
    ${reqheaders}=    Evaluate    json.loads('${reqheaders}')
    log    ${reqheaders}



    ${uri}    Set Variable    ${descriptor.uri}
    ${uri}    Render The Template    ${uri}    &{reqparams}
    ${action}    Convert To Lower Case    ${descriptor.action}

    # ========================================================
    ${keys}    Get Dictionary Keys    ${descriptor}
    ${found}    Get Index From List    ${keys}    params
    Log    ${found}
    IF    ${found}>=0    Log    it is there and params= ${descriptor.params}

    # ===========================

    ${qryparams}    Set Variable    ${EMPTY}
    IF    ${found}>=0    Log    ${descriptor.params}
    IF    ${found}>=0
        ${qryparams}    Render the query params    ${descriptor.params}    &{reqparams}
    ELSE
        ${qryparams}    Set Variable    ${None}
    END

    log    ${qryparams}
    # =========================
    ${files}    Set Variable    ${EMPTY}
    ${filesfound}    Get Index From List    ${keys}    files
    IF    ${filesfound}>0
        &{files}    Render file dictionary    ${descriptor.files}    &{reqparams}
    ELSE
        &{files}    Set Variable    ${None}
    END
    # ...    Run Keywords    ${files}=    Get Binary File    ${descriptor.files}    AND    ${files}    Create Dictionary    file=${files}

    # =====================================
    IF    "${action}"=="post"
        ${response}    Post    url=${uri}    headers=${reqheaders}    data=${body}    files=${files}
    ELSE IF    "${action}"=="get"
        ${response}    Get    url=${uri}    headers=${reqheaders}    params=${qryparams}
    ELSE IF    "${action}"=="put"
        ${response}    Put    url=${uri}    headers=${reqheaders}    data=${body}
    ELSE IF    "${action}"=="delete"
        ${response}    Delete    url=${uri}    headers=${reqheaders}    params=${qryparams}
    ELSE IF    "${action}"=="patch"
        ${response}    Patch    url=${uri}    headers=${reqheaders}    data=${body}
    ELSE
        ${response}    Set Variable    ${None}
    END
    sleep    ${GLOBALTIMEOUT}
    Convert To Curl    ${response.request}
    Log    ${response.json()}
    RETURN    ${response}

Assert API response schema
    [Arguments]    ${apiname}    ${code}    ${reponse}
    ${descriptor}    Set Variable    ${APIs.${apiname}}
    ${expectedresponses}    Set Variable    ${descriptor.Responses}
    Log Many    ${expectedresponses}
    ${expectedresponse}    Set Variable    ${expectedresponses['${code}']}
    Log Many    ${reponse}
    Validate Json    ${expectedresponse}    ${reponse.json()}

getTime
    ${x}    Get Current Date
    log to console    ${x}

Assert returned data
    [Arguments]    ${result}    ${full_path}    ${expected}
    ${actualData}    Get Value From Json    ${result}    ${full_path}
    Should Not Be Equal    ${actualData}    ${expected}

Assert returned list data
    [Arguments]    ${result}    ${full_path}    ${expectedList}
    ${actualDataList}    Get Value From Json    ${result}    ${full_path}
    Lists Should Be Equal    ${actualDataList}    ${expectedList}
