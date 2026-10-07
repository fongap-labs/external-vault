# Third-party notices

The root [licensing notice](LICENSE) defines the repository's mixed-license scope. Its MIT terms apply only to original repository-authored material unless a more specific notice says otherwise.

## AdFilter data

Files under `output/adfilter/` are generated from third-party filter rules. Those rules remain subject to the terms, notices, attribution requirements, and copyright of their respective upstream projects. The MIT License in this repository does not replace or relicense third-party rule data.

| Upstream list | Fetched from | Licence stated by the upstream | Evidence | Legal review |
| --- | --- | --- | --- | --- |
| AdGuard Base Filter | [AdguardTeam/FiltersRegistry](https://github.com/AdguardTeam/FiltersRegistry) `filters/filter_2_Base/filter.txt` (rules maintained in [AdguardTeam/AdguardFilters](https://github.com/AdguardTeam/AdguardFilters)) | GPL-3.0 (AdguardFilters); the FiltersRegistry repository itself is LGPL-3.0 | List header "License:" links to the AdguardFilters `LICENSE`; GitHub reports GPL-3.0 and LGPL-3.0 respectively | Needed |
| AdGuard Chinese Filter | [AdguardTeam/FiltersRegistry](https://github.com/AdguardTeam/FiltersRegistry) `filters/filter_224_Chinese/filter.txt` | GPL-3.0 (AdguardFilters) | Same list header as above | Needed |
| CJX's Annoyance List | [cjx82630/cjxlist](https://github.com/cjx82630/cjxlist) `cjx-annoyance.txt` | LGPL-3.0 | Repository `LICENSE`; list header "License:" links to it | Needed |
| Fanboy's Annoyance List | `https://secure.fanboy.co.nz/fanboy-annoyance.txt` (project: [ryanbr/fanboy-adblock](https://github.com/ryanbr/fanboy-adblock)) | CC BY 3.0 | List header "License:" links to creativecommons.org/licenses/by/3.0/; the GitHub repository has no licence file | Needed |
| uBlock filters – Other Annoyances, Cookie Notices | [uBlockOrigin/uAssets](https://github.com/uBlockOrigin/uAssets) `filters/annoyances-others.txt`, `filters/annoyances-cookies.txt` | GPL-3.0 | Repository `LICENSE`; list headers link to it | Needed |
| EasyList China + EasyList | `https://easylist-downloads.adblockplus.org/easylistchina+easylist.txt` (projects: [easylist/easylist](https://github.com/easylist/easylist), [easylist/easylistchina](https://github.com/easylist/easylistchina)) | EasyList repository: dual GPL-3.0-or-later and CC BY-SA 3.0-or-later, attribution "The EasyList authors (https://easylist.to/)". The EasyList China repository carries no licence metadata on GitHub | [easylist.to/pages/licence.html](https://easylist.to/pages/licence.html) (linked from the list header). That page also says files hosted externally may be under other conditions | Needed |

Notes on the previous version of this table:

- The AdGuard lists were listed as MIT. The upstream licence is GPL-3.0 (see the evidence above).
- uBlock Origin lists were listed as "Various"; the uAssets repository is GPL-3.0.
- `easylist/easylistcookie` no longer exists (HTTP 404). The EasyList cookie list is maintained inside [easylist/easylist](https://github.com/easylist/easylist) (`easylist_cookie/`), and it is not fetched as a separate source. The row was removed.
- EasyList was listed as "CC BY 3.0". Its official licence page states the dual GPL-3.0-or-later / CC BY-SA 3.0-or-later terms above.
- Licence statements were checked on 2026-10-07 from the upstream repositories and list headers. They are facts about what the upstream projects state, not a legal conclusion.

Legal review needed: whether and how the GPL, LGPL, CC BY and CC BY-SA terms of these lists apply to the aggregated `output/adfilter/adfilter.txt` (including attribution and share-alike duties), and under which terms the aggregate may be distributed. This repository makes no such determination. See [output/adfilter/NOTICE](output/adfilter/NOTICE).

Released third-party program assets must carry their own license and attribution metadata through Release notes or the corresponding `tools/` metadata.


## OpenCodeReview

OpenCodeReview binaries distributed through this repository's GitHub Releases remain licensed by Alibaba Group under Apache License 2.0. The repository does not modify or relicense those binaries. Mirrored assets are published only after validating the upstream SHA256 checksum and GitHub release asset digest.

- Upstream: alibaba/open-code-review
- License: Apache-2.0
- Distribution: latest two stable releases, Linux amd64
