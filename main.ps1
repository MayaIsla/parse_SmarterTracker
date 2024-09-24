$APIHost = 'smartertrack.local';
$HTTPS = $true;
$API_ST = @{
    #API Call Default Values
    authUserName = 'username'
    authPassword = 'PW'
    method  = 'post'
    ContentType    = 'application/json'
    URI          = 'http' + $(if ($HTTPS -eq $true ) {'s'}) + '://' + $APIHost + '/'
};

### SHORT ###
$U = $API_ST.authUserName;
$P = $API_ST.authPassword;

function UpdateAndCall ( $a ) {
    $API_ST.URI = 'http' + $(if ($HTTPS -eq $true ) {'s'}) + '://' + $APIHost + $a
    New-WebServiceProxy -Uri $API_ST.URI -Verbose;
};

$svcTickets=(UpdateAndCall '/Services/svcTickets.asmx');

$searchResultsNum = $svcTickets.GetTicketPropertiesList($U, $P, 'ticket#')

$results = $searchResultsNum.RequestResults

$frontSubjectLine = 'subject='
$endSep = 'ticketid='

$seperate = ($results -split $frontSubjectLine)[1]

$Subject = ($seperate -split $endSep)[0]
$Subject
