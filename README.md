# listimport
Domain listesini MaestroPanel'e aktarır

###Download
----------

###Parametreler

| İsim  | Açıklama  |
|---|---|
|host|MaestroPanel'in çalıştığı sunucu IP adresi veya host ismi.|
|apikey|MaestroPanel'de yetkili olan kullanıcıyı temsil eden API anahtarı.|	
|port|MaestroPanel'in çalıştığı Port numarası.|	
|plan|Domain'lerin açılacağı Domain Planı'nın Alias ismi.|
|list_file|Domain'lerin bulunduğu liste. Text dosyası ve satır satır alt alta olarak formatlanması gerekir.|	
|active_domain_user|Domain açıldığında Maestropanel üzerinde domain kullanıcısıda aktif edilmesini sağlar.|

###Kullanım

Domain listesini MaestroPanel'de oluşturur

	.\listimport.ps1 -remote_host 192.168.0.4 -apikey 1_6c8a00e26765497698508b51622b3e25 -port 9715 -plan defaultPlan -list_file C:\import\domains.txt -active_domain_user $true
	
	
###İleitşim

MaestroPanel

ping@maestropanel.com