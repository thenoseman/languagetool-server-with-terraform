data "aws_network_interface" "ecs" {
  filter {
    name   = "tag:aws:ecs:serviceName"
    values = ["languagetool"]
  }
}

output "languagetool_api_url" {
  value = <<-EOV
    Install https://chromewebstore.google.com/detail/rechtschreibpr%C3%BCfung-%E2%80%93-lan/oldceeleldhonbafppcapldpdifcinji
    Then open the options of the extension and scroll down to "Experimental Einstellungen (nur für Profis)" and select
    "Sonstiger Server – benötigt dort einen LanguageTool-Server" and enter:
    http://${data.aws_network_interface.ecs.association[0].public_ip}:8010/v2
  EOV
}
