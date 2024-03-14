# languagetool deployment in AWS ECS via terraform

These files will deploy a languagetool server on AWS ECS using the docker image from [meyayl/docker-languagetool](https://github.com/meyayl/docker-languagetool).

This server can then be used with the official [chrome extension](https://chromewebstore.google.com/detail/rechtschreibpr%C3%BCfung-%E2%80%93-lan/oldceeleldhonbafppcapldpdifcinji).

Once deployed you will get a notice on how to use it like this:

```
Outputs:

languagetool_api_url = <<EOT
Install https://chromewebstore.google.com/detail/rechtschreibpr%C3%BCfung-%E2%80%93-lan/oldceeleldhonbafppcapldpdifcinji
Then open the options of the extension and scroll down to "Experimental Einstellungen (nur für Profis)" and select
"Sonstiger Server – benötigt dort einen LanguageTool-Server" and enter:
http://127.0.0.1:8010/v2

EOT
```

# State

Choose a region and updaze `setup.tf`.
Create a bucket for the terrraform state before `terraform init` in that region:

`AWS_REGION=eu-central-1 aws s3api create-bucket --acl private --bucket languagetool-terraform-state --create-bucket-configuration "LocationConstraint=${AWS_REGION}"`

There is no concurrent terraform check via a DynamoDB table!
