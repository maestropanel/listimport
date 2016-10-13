<#
.SYNOPSIS
	Text dosyasi içindeki domain listesini MaestroPanel'e aktarır.
.DESCRIPTION
	Text dosyasi içindeki domain listesini MaestroPanel'e aktarır.
	
.PARAMETER host
	MaestroPanel'in çalıştığı sunucu IP adresi veya host ismi.
	
.PARAMETER apikey
	MaestroPanel'de yetkili olan kullanıcıyı temsil eden API anahtarı.
	
.PARAMETER port
	MaestroPanel'in çalıştığı Port numarası.
	
.PARAMETER plan
	Domain'lerin açılacağı Domain Planı'nın Alias ismi. 
	
.PARAMETER list-file
	Domain'lerin bulunduğu liste. Text dosyası ve satır satır alt alta olarak formatlanması gerekir.
	
.PARAMETER active-domain-user
	Domain açıldığında Maestropanel üzerinde domain kullanıcısıda aktif edilmesini sağlar.
.EXAMPLE	
	.\listimport.ps1 -remote_host 192.168.0.4 -apikey 1_6c8a00e26765497698508b51622b3e25 -port 9715 -plan defaultPlan -list_file C:\import\domains.txt -active_domain_user $true
.LINK
	https://github.com/maestropanel/listimport
.Notes
	Author : Oğuzhan YILMAZ	
	Filename: listimport.ps1
#>

[Cmdletbinding()]
Param(
	[Parameter(Mandatory=$true)]
	[string] $REMOTE_HOST,
	
	[Parameter(Mandatory=$true)]
	[string] $APIKEY,
	
	[Parameter(Mandatory=$true)]
	[string] $PORT = "9715",
	
	[Parameter(Mandatory=$true)]
	[string] $PLAN,
	
	[Parameter(Mandatory=$true)]
	[string] $LIST_FILE,
		
	[bool] $ACTIVATE_DOMAIN_USER = $false
)

$Domains = Get-Content $LIST_FILE

function CreateDomain($name){
	$name = $name.Trim()
	$password = GetPassword(6)
	$requestUrl = "http://$($REMOTE_HOST):$PORT/Api/v1/Domain/Create?format=json&suppress_response_codes=false"
	$requestPrms = @{key=$APIKEY;name=$name;planAlias=$PLAN;username=$name;password=$password;activedomainuser=$ACTIVATE_DOMAIN_USER}
	
	$result = Invoke-WebRequest -Uri $requestUrl -Method POST -Body $requestPrms | ConvertFrom-Json
	
	Write-Host $result.Message
}

function GetPassword($length = 15) {
    $punc = 46..46
    $digits = 48..57
    $letters = 65..90 + 97..122

    # Thanks to
    # https://blogs.technet.com/b/heyscriptingguy/archive/2012/01/07/use-pow
    $password = get-random -count $length `
        -input ($punc + $digits + $letters) |
            % -begin { $aa = $null } `
            -process {$aa += [char]$_} `
            -end {$aa}

    return $password
}

foreach ($name in $Domains) {
    CreateDomain($name)
}

