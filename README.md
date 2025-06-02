# languagetool deployment in AWS ECS via terraform

These files will deploy a languagetool server on AWS ECS using the docker image from [meyayl/docker-languagetool](https://github.com/meyayl/docker-languagetool).

This server can then be used with the official [chrome extension](https://chromewebstore.google.com/detail/rechtschreibpr%C3%BCfung-%E2%80%93-lan/oldceeleldhonbafppcapldpdifcinji) and the obsidian languagetool integration plugin.

Once deployed you will get a notice on how to use it like this:

MAKE SURE YOU HAVE docker RUNNING LOCALLY (For pull and push of the image)

```
Outputs:

languagetool_api_url = <<EOT
USAGE IN CHROME EXTENSION:
--------------------------
Install https://chromewebstore.google.com/detail/rechtschreibpr%C3%BCfung-%E2%80%93-lan/oldceeleldhonbafppcapldpdifcinji
Open the options of the extension and scroll down to "Experimental Einstellungen (nur für Profis)" and select
"Sonstiger Server – benötigt dort einen LanguageTool-Server" and enter:
http://languagetool-1234567890.elb.eu-central-1.amazonaws.com:8081/v2

USAGE IN OBSIDIAN:
------------------
Install the "LanguageTool Integration" Community Plugin and used
http://languagetool-1234567890.elb.eu-central-1.amazonaws.com:8081
as the "Endpoint" Custom URL
EOT
```
