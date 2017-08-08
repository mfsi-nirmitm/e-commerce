<cfoutput>

    <h1>
        Application And Session Overview
    </h1>

    <p>
        Application initialized:#dateDiff("s",application.dateInitialized,now())# seconds ago.
    </p>

    <p>
        Session initialized:#dateDiff("s",session.dateInitialized,now())# seconds ago.
    </p>

</cfoutput>