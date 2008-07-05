

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Create CallDetailRecord</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">CallDetailRecord List</g:link></span>
        </div>
        <div class="body">
            <h1>Create CallDetailRecord</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${callDetailRecord}">
            <div class="errors">
                <g:renderErrors bean="${callDetailRecord}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="callerName">Caller Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:callDetailRecord,field:'callerName','errors')}">
                                    <input type="text" id="callerName" name="callerName" value="${fieldValue(bean:callDetailRecord,field:'callerName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="callerNumber">Caller Number:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:callDetailRecord,field:'callerNumber','errors')}">
                                    <input type="text" id="callerNumber" name="callerNumber" value="${fieldValue(bean:callDetailRecord,field:'callerNumber')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="channelId">Channel Id:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:callDetailRecord,field:'channelId','errors')}">
                                    <input type="text" id="channelId" name="channelId" value="${fieldValue(bean:callDetailRecord,field:'channelId')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="conferenceNumber">Conference Number:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:callDetailRecord,field:'conferenceNumber','errors')}">
                                    <input type="text" id="conferenceNumber" name="conferenceNumber" value="${fieldValue(bean:callDetailRecord,field:'conferenceNumber')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateJoined">Date Joined:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:callDetailRecord,field:'dateJoined','errors')}">
                                    <g:datePicker name="dateJoined" value="${callDetailRecord?.dateJoined}" ></g:datePicker>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateLeft">Date Left:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:callDetailRecord,field:'dateLeft','errors')}">
                                    <g:datePicker name="dateLeft" value="${callDetailRecord?.dateLeft}" ></g:datePicker>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="userNumber">User Number:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:callDetailRecord,field:'userNumber','errors')}">
                                    <input type="text" id="userNumber" name="userNumber" value="${fieldValue(bean:callDetailRecord,field:'userNumber')}" />
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Create" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>