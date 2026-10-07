# with-love.lonkar.org, this repository's GitHub Pages custom domain. Every
# lonkar-org repository's Pages answers under it at its name, so a project's
# site needs no record of its own. Only this record lives here; the rest of
# the lonkar.org zone is lonkar-org/lonkar.org's.
#
# Not proxied: GitHub issues the certificate for the name itself and has to see
# its own address answer to do it. The org's domain verification for
# lonkar.org, a TXT record in lonkar-org/lonkar.org, covers the subdomain.

data "cloudflare_zone" "lonkar_org" {
  filter = {
    name = var.site_name
  }
}

resource "cloudflare_dns_record" "with_love" {
  name    = "with-love.${var.site_name}"
  type    = "CNAME"
  content = "lonkar-org.github.io"
  proxied = false
  ttl     = 1
  zone_id = data.cloudflare_zone.lonkar_org.zone_id
}

# Made by lonkar-org/lonkar.org on 2026-10-07 and handed over here: that
# repository forgot it with a `removed` block and this one takes it on.
import {
  to = cloudflare_dns_record.with_love
  id = "${data.cloudflare_zone.lonkar_org.zone_id}/fb8e6da22957bbf9dbff6c7b80cf0bfb"
}
