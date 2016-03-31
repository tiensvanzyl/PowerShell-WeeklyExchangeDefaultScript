add-pssnapin Microsoft.Exchange.Management.PowerShell.E2010 -erroraction silentlyContinue
Set-ADServerSettings -ViewEntireForest $True
###################################################################################################################################################################################### 
# Exchange 2010 Exchange Quota Report 
# Author: Tiens van Zyl
# Date 20 November 2015
# Updated by Tiens van Zyl 7 December 2015
# Updates: Changed line 1 as the batch file errored out.
# This script outputs Exchange Quota Defaults True for our weekly report 
# 1. The script exports a CSV file with the current date.
# 2. The CSV file export displays the DisplayName, IssueWarningQuota, ProhibitSendQuota and ProhibitSendReceiveQuota 
# 3. The CSV file contains raw data that needs to be formatted in Excel
# 4. Enter your mailbox server/s name in place of "ServerName". Use a wilcard if you have more than one server you need to query i.e. mailbox0* if your servers names are mailbox01, mailbox02 etc.
# 5. Set the path to where you'd like to export the txt file. 
# 6. The FileName will be appended with the date that the script is run. i.e. WeeklyExchangeDefaultScript 2015-05-01.csv
######################################################################################################################################################################################
$file = "C:\Exchange_AutomatedScripts\WeeklyReports\ExchangeQuotaReport\Reports\ExchangeDefault $(get-date -f yyyy-MM-dd).csv"

Get-mailboxserver mailbox* | Get-mailbox -resultsize unlimited |Where{($_.UseDatabaseQuotaDefaults -eq $true)} | select DisplayName, IssueWarningQuota,ProhibitSendQuota,ProhibitSendReceiveQuota | 

export-csv "$file"

$smtpServer = "yourSMTPserver"

$att = new-object Net.Mail.Attachment($file)

$msg = new-object Net.Mail.MailMessage

$smtp = new-object Net.Mail.SmtpClient($smtpServer)

$msg.From = "from@email.com"

$msg.To.Add("email@email.com, email1@email.com, email2@email.com")

$msg.Subject = "SubjectOfYourMail"

$msg.Body = "Some text in body"

$msg.Attachments.Add($att)

$smtp.Send($msg)

$att.Dispose()





