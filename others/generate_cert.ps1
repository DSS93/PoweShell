
#Create Root Cert
$rootCert = New-SelfSignedCertificate `
    -Type Custom `
    -KeyUsage CertSign, CRLSign, DigitalSignature `
    -Subject "CN=RegulatoryConnect Root CA, O=dss, C=GB" `
    -KeyAlgorithm RSA `
    -KeyLength 2048 `
    -HashAlgorithm SHA256 `
    -NotAfter (Get-Date).AddYears(10) `
    -CertStoreLocation "Cert:\CurrentUser\My" `
    -KeyExportPolicy Exportable
    #-Provider "Microsoft Enhanced RSA and AES Cryptographic Provider"

#Export Root Cert
$rootCertPath = "C:\Certificates\PERF\RootCert.cer"
Export-Certificate -Cert $rootCert -FilePath $rootCertPath

#Create Intermediate Cert
$intermediateCert = New-SelfSignedCertificate `
    -Type Custom `
    -DnsName "RegulatoryConnect Intermediate CA" `
    -KeyUsage CertSign, CRLSign, DigitalSignature `
    -Subject "CN=RegulatoryConnect Intermediate CA, O=dss, C=GB" `
    -KeyAlgorithm RSA `
    -KeyLength 2048 `
    -HashAlgorithm SHA256 `
    -Signer $rootCert `
    -NotAfter (Get-Date).AddYears(5) `
    -CertStoreLocation "Cert:\CurrentUser\My" `
    -KeyExportPolicy Exportable

#Export intermediate cert
$intermediateCertPath = "C:\Certificates\PERF\IntermediateCert.cer"
Export-Certificate -Cert $intermediateCert -FilePath $intermediateCertPath


#Create regulatoryconnect-perf-api.privatelink.dss.gov.uk cert
$primaryCert = New-SelfSignedCertificate `
    -Type Custom `
    -DnsName "regulatoryconnect-perf-api.privatelink.dss.gov.uk" `
    -Subject "CN=regulatoryconnect-perf-api.privatelink.dss.gov.uk, O=dss, C=GB" `
    -KeyAlgorithm RSA `
    -KeyLength 2048 `
    -HashAlgorithm SHA256 `
    -Signer $intermediateCert `
    -NotAfter (Get-Date).AddYears(2) `
    -CertStoreLocation "Cert:\CurrentUser\My" `
    -KeyExportPolicy Exportable

#Export Primary cert
$primaryCertPfxPath = "C:\Certificates\PERF\regulatoryconnect-perf-api.pfx"
$plainPassword = "cO7HeCpMjzE"
$primaryCertPassword = ConvertTo-SecureString -String $plainPassword -Force -AsPlainText

Export-PfxCertificate -Cert $primaryCert `
    -FilePath $primaryCertPfxPath `
    -Password $primaryCertPassword


#Create  regulatoryconnect-perf-portal.privatelink.dss.gov.uk cert
$primaryCert = New-SelfSignedCertificate `
    -Type Custom `
    -DnsName "regulatoryconnect-perf-portal.privatelink.dss.gov.uk" `
    -Subject "CN=regulatoryconnect-perf-portal.privatelink.dss.gov.uk, O=dss, C=GB" `
    -KeyAlgorithm RSA `
    -KeyLength 2048 `
    -HashAlgorithm SHA256 `
    -Signer $intermediateCert `
    -NotAfter (Get-Date).AddYears(2) `
    -CertStoreLocation "Cert:\CurrentUser\My" `
    -KeyExportPolicy Exportable

#Export Primary cert
$primaryCertPfxPath = "C:\Certificates\PERF\regulatoryconnect-perf-portal.pfx"
$plainPassword = "cO7HeCpMjzE"
$primaryCertPassword = ConvertTo-SecureString -String $plainPassword -Force -AsPlainText

Export-PfxCertificate -Cert $primaryCert `
    -FilePath $primaryCertPfxPath `
    -Password $primaryCertPassword


#Create regulatoryconnect-perf-management.privatelink.dss.gov.uk cert
$primaryCert = New-SelfSignedCertificate `
    -Type Custom `
    -DnsName "regulatoryconnect-perf-management.privatelink.dss.gov.uk" `
    -Subject "CN=regulatoryconnect-perf-management.privatelink.dss.gov.uk, O=dss, C=GB" `
    -KeyAlgorithm RSA `
    -KeyLength 2048 `
    -HashAlgorithm SHA256 `
    -Signer $intermediateCert `
    -NotAfter (Get-Date).AddYears(2) `
    -CertStoreLocation "Cert:\CurrentUser\My" `
    -KeyExportPolicy Exportable

#Export Primary cert
$primaryCertPfxPath = "C:\Certificates\PERF\regulatoryconnect-perf-management.pfx"
$plainPassword = "cO7HeCpMjzE"
$primaryCertPassword = ConvertTo-SecureString -String $plainPassword -Force -AsPlainText

Export-PfxCertificate -Cert $primaryCert `
    -FilePath $primaryCertPfxPath `
    -Password $primaryCertPassword

 

#Export full chain
$combinedCertPath = "C:\Certificates\PERF\fullchain.pem"
Get-Content $primaryCertPfxPath, $intermediateCertPath, $rootCertPath | Set-Content $combinedCertPath
