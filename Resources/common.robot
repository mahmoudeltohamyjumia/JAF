*** Settings ***
Library         DatabaseLibrary
Library         DateTime
Library         Collections
Library         BuiltIn
Library         RequestsLibrary
Library         OperatingSystem
Library         FakerLibrary
Library         SeleniumLibrary    timeout=60    run_on_failure=None
Library         String
Library         json
Library         JSONLibrary
Library         Process
###################   Custom Libs  ###########################################
Library         Libs/SchemaLibrary.py    Resources/schemas/
Library         Libs/CustomKeywords.py
Library         Libs/AxeLibrary.py
###############################################################################

Variables        apischema.yaml
Variables        ../Data/common_errors.yml
Variables        ../Data/Config/staging_data.yml

*** Variables ***
${VCS_BASE_URL}             https://api-vcs-staging.jumia.services/api/v2
${UVR_BASE_URL}             https://api-uvr-staging.jumia.services/api/v2
# ${CON_BASE_URL}             https://api-consignment-staging.jumia.services/api/v2

${CON_BASE_URL}             http://api-consignment-staging.jumia.services/api


${GLOBALTIMEOUT}            200 ms

${validgetresponse}         200
${validcreateresponse}      201
${validupdateresponse}      200
${validdeleteresponse}      204
${base_auth_url}            https://vendor-api.jumia.com
${client_id}                250618051007-tpk26eoha2tpafs0atk4tu7kse3b4l6u.apps.googleusercontent.com
${code}                     4/0AVG7fiQcDcaBYAFRM14q7NerdMmG_TWt8fD_wvsvsftfLxqJP1iBEbFHG2qBQq-DpwJuBA
${redirectUri}              https://vendorcenter-staging.jumia.com
${instanceId}               internal

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
    [Arguments]    ${baseurl}    ${apiname}    ${status}    &{params}
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
    # =====================================
    Create Session    mytest    ${baseurl}
    # ======================================
    IF    "${action}"=="post"
        ${response}=    Post On Session  alias=mytest  url=${uri}    headers=${reqheaders}    data=${body}    files=${files}
    ELSE IF    "${action}"=="get"
        ${response}=    GET On Session  alias=mytest  url=${uri}    headers=${reqheaders}    expected_status=${status}    params=${qryparams}
    ELSE IF    "${action}"=="put"
        ${response}=    Put On Session  alias=mytest  headers=${reqheaders}    data=${body}
    ELSE IF    "${action}"=="delete"
        ${response}=    Delete On Session  alias=mytest  headers=${reqheaders}    params=${qryparams}
    ELSE IF    "${action}"=="patch"
        ${response}=    Patch On Session  alias=mytest  url=${uri}    headers=${reqheaders}    data=${body}
    ELSE
        ${response}    Set Variable    ${None}
    END
    sleep    ${GLOBALTIMEOUT}
    Convert To Curl    ${response}
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
