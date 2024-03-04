output "languagetool_api_url" {
  value = <<-EOV
    USAGE IN CHROME EXTENSION:
    --------------------------
    Install https://chromewebstore.google.com/detail/rechtschreibpr%C3%BCfung-%E2%80%93-lan/oldceeleldhonbafppcapldpdifcinji
    Open the options of the extension and scroll down to "Experimental Einstellungen (nur für Profis)" and select
    "Sonstiger Server – benötigt dort einen LanguageTool-Server" and enter:
    http://${aws_lb.languagetool.dns_name}:${local.languagetool_port}/v2

    USAGE IN OBSIDIAN:
    ------------------
    Install the "LanguageTool Integration" Community Plugin and used
    http://${aws_lb.languagetool.dns_name}:${local.languagetool_port}
    as the "Endpoint" Custom URL

  EOV
}
