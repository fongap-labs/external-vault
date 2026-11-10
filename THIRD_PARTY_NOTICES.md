# Third-party notices

This repository has **no default repository-wide license**. File-specific declarations and upstream licenses govern the relevant materials. Public availability is not a blanket grant of reuse rights.

## AdFilter data

The aggregated file [`output/adfilter/adfilter.txt`](output/adfilter/adfilter.txt) is marked **GPL-3.0-only** using [`output/adfilter/adfilter.txt.license`](output/adfilter/adfilter.txt.license) and the corresponding [`GPL-3.0 license text`](output/adfilter/LICENSE). This records the intended license for Fongap Labs' original compilation and contributions to this file; it **does not relicense third-party source rules**. Those rules remain subject to their individual upstream terms, notices, attribution requirements, and copyrights.

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

Legal review still needed: whether all GPL-3.0, LGPL-3.0, CC BY 3.0 and CC BY-SA 3.0 upstream terms can be satisfied when combining and distributing `output/adfilter/adfilter.txt`, including attribution, share-alike and license compatibility. The file-specific GPL-3.0-only label must not be taken as a legal conclusion that incompatible upstream rights were relicensed.

Released third-party program assets must carry their own license and attribution metadata through Release notes or the corresponding `tools/` metadata.


## OpenCodeReview

OpenCodeReview binaries distributed through this repository's GitHub Releases remain licensed by Alibaba Group under Apache License 2.0. The repository does not modify or relicense those binaries. Mirrored assets are published only after validating the upstream SHA256 checksum and GitHub release asset digest.

- Upstream: alibaba/open-code-review
- License: Apache-2.0
- Distribution: latest two stable releases, Linux amd64

## R Base Package

The R base source tarball distributed through this repository's GitHub Releases remains licensed by the R Project under the GNU General Public License version 2 or later. The repository redistributes the unmodified upstream source tarball and does not modify or relicense it. The tarball is published only after the SHA-256 pinned in `tools/r-base/tool.json` matches the upstream download.

- Upstream: https://cran.r-project.org/src/base/R-4/R-4.6.0.tar.gz
- License: GPL-2.0-or-later
- Distribution: R 4.6.0 source tarball (`R-4.6.0.tar.xz`)
- License text: [`tools/r-base/LICENSE`](tools/r-base/LICENSE), the `COPYING` file of the R sources, shipped verbatim
