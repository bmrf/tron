------------------------------------------------------
|
|	Product   - SwithMail
|	Version   - 2.1.5.0
|	Author    - Tim Bare
|	Copyright - 2012-2013 - Tim Bare
|
|	Website   - http://www.tbare.com
|	Project   - http://swithmail.tbare.com
|
|	Description:
|	   SwithMail is an application
|	   that allows you to send SSL/TLS SMTP
|	   email silently from command line (CLI), 
|	   or a batch file using Exchange, Gmail, 
|	   Hotmail, Yahoo! Plus, or Any custom server
|	    - for FREE!
|
------------------------------------------------------

Usage:

SwithMail.exe [/s] [/to "..."] [/CC "..."] [/from "..."] [/name "..."] [/sub "..."] [/Body "..."] [/HTML] [/Attachment "C:\Path\To\File.txt"] [/Param1 "value"] [/enc "..."] [/rr] [/drnl]


---------------------
Sample Usage:

SwithMail.exe /s /x "C:\path\to\settings.xml" /btxt "c:\path\to\bodyText.txt" /p1 "Mr. Smith" /enc "iso-8859-1"


---------------------
Error Codes: 
When running silently from command line (or more specifically a batch file), Swithmail now supports error codes.
0 - No error - email delivered
1 - Error - something went wrong

Example usage in a .bat file:
@echo off
rem ...
set errorlevel=
C:\SwithMail\SwithMail.exe /s /x "SwithMailSettings.xml"
IF %errorlevel% ==0 GOTO SUCCESS
IF %errorlevel% ==1 GOTO ERROR

:SUCCESS
echo Success!
GOTO END

:ERROR
echo Error!
GOTO END

:END


---------------------
Parameters:

/Silent -- [also '/s' and '/q'] send an email without any prompt.
/XML -- [also '/x'] "C:\Path\To\Settings.xml"
/FromAddress -- [also '/from'] email address
/FromName -- [also '/name'] name displayed
/Server -- server address - no port specified
/Port -- [also '/p'] server port - needed if /Server is used
/Username -- [also '/u'] specified different username to use when logging in with SSL / TSL
/Password [also '/pass'] password - in plain text
/SSL -- [also '/TSL'] "true" or "false" depending on if SSL / TLS is enabled
/ToAddress -- [also '/to'] email address(es); multiple separated by ';' or ','
/CC -- email address(es); multiple separated by ';' or ','
/BCC -- email address(es); multiple separated by ';' or ','
/ReplyTo -- [also '/rt'] address to set as the "Reply To" address
/Subject -- [also '/sub'] subject "in quotes"
/Body -- [also '/b'] email body "in quotes" - html tags allowed when /HTML=true
/BodyTxt -- [also '/btxt'] full path of a text file to be used as the message body.
/HTML -- "true" or "false" depending on if HTML tags are allowed in the body
/Attachment -- [also '/a'] "C:\Path\To\File.txt|C:\PathTo\2.txt" - separate with pipe (|) symbol
/Param{1-5} -- [also '/p{1-5}'] use %Param1% in subject or body, && replace it with this value
/Test -- use when testing from CLI. Message will appear with errors or success 
/Encoding -- [also '/enc'] Specify different charset to be used (UTF8 by default)
/ReadReceipt -- [also '/rr'] Request Read Receipt (where the client acknowledges and agrees)
/DontReplace -- [also '/drnl'] Don't replace New Line with '<br />' on HTML email

---------------------
Global variables (use in email subject & body):

%now% - displays current date & time
%computername% - displays computer name
%username% - displays username of account running SwithMail


---------------------
History:

Revision: v2.1.5.0
========================
-Enhancement / Bug Fix - Added fix for Wildcard attachments that doesn't ignore text before the asterisk.

Revision: v2.1.4.0
========================
-Enhancement - Added option to not auto replace new lines with '<br/>' for html email (fixes .html file body text files)
-Enhancement - Added alternate "plain text" view for HTML emails to help reduce SPAM score.


Revision: v2.1.3.0
========================
-Enhancement - Added Support for wildcards on attachments ("c:\path\to\files\*.csv" will attach all .csv files in the folder -- NOTE: You must specify the file extension -- *.* will not work).


Revision: v2.1.2.0
========================
-Enhancement - Added /ReadReceipt (or /rr) to request a read receipt (where the client acknowledges and agrees)


Revision: v2.1.1.1
========================
-Bug Fix - fixed encoding issues when using non-US characters in ANSI text file for /bodytxt


Revision: v2.1.1.0
========================
-Enhancement - Added /Encoding (or /enc) argument - Specify different charset to be used (UTF8 by default)
-Enhancement - Updated GUI to allow for /BodyTxt file selection and /Encoding field
-Enhancement - Updated XML to hold /BodyTxt and /Encoding arguments


Revision: v2.1.0.0
========================
-Enhancement - Added /BodyTxt (or /btxt) argument - specify a text file to be used as the message body. (%Param1% - %Param5% CAN be used in the text file and be replaced by arguments.


Revision: v2.0.9.0
========================
-Enhancement - Added Exit Codes ('0' for success, '1' for error) for batch file use


Revision: v2.0.8.0
========================
-Bug Fix- Fixed hang when running as scheduled task as different user


Revision: v2.0.7.0
========================
-Added "Username" field - now you can specify a different "Username" other than the send from email address


Revision: v2.0.6.0
========================
-Added "Reply To" field - now you can specify a different "Reply To" address


Revision: v2.0.5.0
========================
-Removed Colon (:) and Equal sign (=) separator for CLI arguments - was causing issue when those characters were in the strings behind them.


Revision: v2.0.4.0
========================
-Bug Fix - fixed /sub argument string changing to "true" when using the long CLI form.


Revision: v2.0.3.0
========================
-Added option to Obscure password in XML file from the GUI


Revision: v2.0.2.0
========================
-Added global variables %now%, %computername%, and %username%


Revision: v2.0.1.0
========================
-Fixed error where CLI string would clear from clipboard when program closed


Revision: v2.0 (Changes from v1.5)
========================
- Removed settings from saving "in-app" - now all settings are saved to an XML file, and the XML file is called from the command line
- Added support for multiple file attachments - up to 4 in-app, unlimited** in XML file and in command line
- Added support for generating CLI string for you, taking the guess work out of your arguments
- Changed Usage screen to be slightly easier to read
- Changed Settings screen to be tab-based, allowing for smaller screen, and more settings
- Several other minor tweaks and enhancements


** "Unlimited" means that SwithMail will try to deliver all attachments - email providers may have limits not enforced by SwithMail - If that limit is exceeded, emails may fail to send.


---------------------
Disclaimer:
This software is provided by the copyright holder and contributors "as is" and any express or implied warranties, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose are disclaimed. In no event shall the copyright owner or contributors be liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including, but not limited to, procurement of substitute goods or services; loss of use, data, or profits; or business interruption) however caused and on any theory of liability, whether in contract, strict liability, or tort (including negligence or otherwise) arising in any way out of the use of this software, even if advised of the possibility of such damage.

--Basically, I am not responsible for the way this application is used, nor can I ensure that no damage will be caused by using this program. Don't use it to send SPAM. Please... that's not why I wrote it, and nobody likes SPAM!
