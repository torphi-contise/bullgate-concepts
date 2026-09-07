# Security Policy

The security of people who browse, integrate, and maintain Bullgate is part of
the product. This policy explains how to report a potential vulnerability
without exposing others before the issue can be understood and corrected.

## Supported versions

Security fixes apply to:

- the version currently published at <https://bullgate.dev/>;
- the current files on this repository's default branch.

Historical artifacts and copies maintained by third parties do not receive
retroactive fixes. If an older issue also affects the current version, it
remains in scope.

## What to report

Report privately any issue involving:

- credentials, tokens, personal data, or other secrets present in the
  repository or published website;
- script execution, content injection, or unauthorized redirects on the
  website;
- build or publication failures that could allow unauthorized content changes
  or credential disclosure;
- official documentation or examples that recommend unsafe handling of
  secrets, authentication, sessions, or personal data;
- any reproducible issue that could compromise the project's confidentiality,
  integrity, or availability.

If a finding affects a Bullgate service that does not yet have its own public
policy, you may use the same private channel. The report will be forwarded to
the responsible repository without premature disclosure.

## How to report

Email `acp.marco@outlook.com` with the subject `Security — Bullgate`.

When possible, include:

1. the affected component, page, route, or file;
2. the observed or potential impact;
3. the minimum steps required to reproduce the issue;
4. the relevant environment, browser, version, or commit;
5. only the evidence required to understand the issue, with personal data and
   secrets removed;
6. a safe way to contact you with follow-up questions.

Do not send valid tokens, passwords, identity documents, or third-party data. If
sensitive evidence is indispensable, describe its existence first so that an
appropriate transfer method can be arranged.

## What to expect

Our initial goals are to:

- acknowledge receipt within five business days;
- provide an initial impact and reproducibility assessment within ten business
  days;
- keep the reporter informed when the status changes materially;
- coordinate disclosure after an appropriate fix, mitigation, or agreed date
  exists.

These are communication targets, not resolution guarantees. Complexity,
external dependencies, and maintainer availability may affect resolution time.
If a report is out of scope, we will explain why and identify a more appropriate
channel when one is known.

## Responsible disclosure

Please do not publish details that could facilitate exploitation before a fix,
mitigation, or coordinated disclosure date exists. Credit will be offered when
requested and when publishing it does not increase risk.

This project does not operate a paid bug bounty program. Do not promise payment,
benefits, or recognition on behalf of Bullgate.

## Testing boundaries

Responsible research must:

- use only accounts, data, and systems owned by the researcher or covered by
  explicit authorization;
- avoid outages, degradation, spam, social engineering, and access to
  third-party data;
- stop testing upon encountering data the researcher is not authorized to
  access;
- collect only the minimum evidence required to demonstrate the issue;
- respect third-party services and their own policies.

This policy does not authorize testing third-party accounts, infrastructure, or
services, and it does not authorize denial-of-service attacks.

## Outside the private channel

Typos, broken links, layout problems, and proposals without security impact may
be handled in a public issue or pull request. Conduct concerns are governed by
the [Code of Conduct](CODE_OF_CONDUCT.md), not this policy.
