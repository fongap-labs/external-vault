# Third-party notices

The root [licensing notice](LICENSE) defines the repository's mixed-license scope. Its MIT terms apply only to original repository-authored material unless a more specific notice says otherwise.

## AdFilter data

Files under `output/adfilter/` are generated from third-party filter rules. Those rules remain subject to the terms, notices, attribution requirements, and copyright of their respective upstream projects. The MIT License in this repository does not replace or relicense third-party rule data.

| Upstream project | Repository | License | Usage |
| --- | --- | --- | --- |
| AdGuard Base Filter | [AdguardTeam/AdguardFilters](https://github.com/AdguardTeam/AdguardFilters) | MIT | Core ad-blocking rules |
| AdGuard Chinese Filter | [AdguardTeam/AdguardFilters/tree/master/ChineseFilter](https://github.com/AdguardTeam/AdguardFilters/tree/master/ChineseFilter) | MIT | Chinese-region specific rules |
| cjxlist | [cjx82630/cjxlist](https://github.com/cjx82630/cjxlist) | MIT | Chinese ad/privacy/annoyance rules |
| EasyList | [easylist/easylist](https://github.com/easylist/easylist) | CC BY 3.0 | International general ad-blocking rules |
| EasyList Cookie | [easylist/easylistcookie](https://github.com/easylist/easylistcookie) | CC BY 3.0 | Cookie-related rules |
| Fanboy Annoyance | [ryanbr/fanboy-adblock](https://github.com/ryanbr/fanboy-adblock) | CC BY 3.0 | Annoyance/social widget rules |
| uBlock Origin Annoyances | [uBlockOrigin/uAssets/filters/annoyances](https://github.com/uBlockOrigin/uAssets/tree/master/filters/annoyances) | Various | Annoyance rules |
| uBlock Origin Cookie | [uBlockOrigin/uAssets/filters/cookie](https://github.com/uBlockOrigin/uAssets/tree/master/filters/cookie) | Various | Cookie-related rules |

Released third-party program assets must carry their own license and attribution metadata through Release notes or the corresponding `tools/` metadata.


## OpenCodeReview

OpenCodeReview binaries distributed through this repository's GitHub Releases remain licensed by Alibaba Group under Apache License 2.0. The repository does not modify or relicense those binaries. Mirrored assets are published only after validating the upstream SHA256 checksum and GitHub release asset digest.

- Upstream: alibaba/open-code-review
- License: Apache-2.0
- Distribution: latest two stable releases, Linux amd64
