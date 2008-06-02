

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Conference List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New Conference</g:link></span>
        </div>
        <div class="body">
            <h1>Conference List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                   	        <g:sortableColumn property="name" title="Name" />
                        
                   	        <g:sortableColumn property="number" title="Number" />
                        
                   	        <g:sortableColumn property="pin" title="Pin" />
                        
                   	        <g:sortableColumn property="startDateTime" title="Start Date Time" />
                        
                   	        <g:sortableColumn property="endDateTime" title="End Date Time" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${conferenceList}" status="i" var="conference">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link action="show" id="${conference.id}">${conference.name?.encodeAsHTML()}</g:link></td>
                        
                            <td>${conference.number?.encodeAsHTML()}</td>
                        
                            <td>${conference.pin?.encodeAsHTML()}</td>
                        
                            <td>${conference.startDateTime?.encodeAsHTML()}</td>
                        
                            <td>${conference.endDateTime?.encodeAsHTML()}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${Conference.count()}" />
            </div>
        </div>
    </body>
</html>