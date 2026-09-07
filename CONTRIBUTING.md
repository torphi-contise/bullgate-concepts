# Contributing to Bullgate Concepts

Thank you for considering a contribution. This repository contains Bullgate's
public presentation and technical documentation. Changes here can influence
integration decisions, so clarity and accuracy are part of the product.

By participating, you agree to follow the project's
[Code of Conduct](CODE_OF_CONDUCT.md).

## Before you begin

Open an issue before investing in a substantial implementation that changes
behavior, architecture, scope, or visual identity. Objective corrections to
text, links, accessibility, and small errors may go directly to a pull request.

Do not include credentials, tokens, personal data, integration secrets, or
internal information in examples, screenshots, commits, or descriptions.

If a change is related to a vulnerability or could expose data, do not open a
public issue or pull request. Follow the [security policy](SECURITY.md).

## What you can contribute

- content, spelling, and link corrections;
- readability, navigation, responsiveness, and accessibility improvements;
- complete and verifiable technical examples;
- documentation of parameters, states, errors, and integration decisions;
- proposals for new pages or a better organization of existing content.

Changes to the Bullgate brand, product positioning, or the classification of a
capability as implemented require prior discussion.

## Primary editorial rule

Do not present intent as existing behavior. Every product statement must make
clear whether it describes:

1. something implemented in the current version;
2. a decided contract that has not yet been implemented;
3. a hypothesis or future capability.

When documenting technical behavior, identify the supporting evidence in the
pull request description. When code and documentation disagree, investigate the
current code behavior before changing the documentation.

## Preparing the environment

The website has no application dependencies. Building locally with the same
route structure used for publication requires Windows PowerShell or PowerShell 7.

Clone the repository using the URL provided by the **Code** button on the
project page. From inside the checkout, run:

```powershell
cd bullgate-concepts
.\deploy-bullgate.ps1 -BuildOnly
```

The result is created in `deploy-dist/`. Use any static HTTP server to browse
the local routes. With Python installed, for example:

```powershell
python -m http.server 3000 --directory deploy-dist
```

Open `http://localhost:3000/`. The `-BuildOnly` mode does not access Cloudflare
and does not require credentials. Publication is a maintainer responsibility.

## Making a change

Create a short-lived branch from the default branch and keep the pull request
focused on one subject. Edit the source files in `html/`; do not edit
`deploy-dist/`, because it is generated and ignored by Git.

Preserve the navigation contracts between these routes:

| Source                 | Published route                         |
| ---------------------- | --------------------------------------- |
| `html/bullgate.html`   | `/`                                     |
| `html/privacy.html`    | `/privacy/`                             |
| `html/docs-index.html` | `/docs/`                                |
| `html/docs.html`       | `/docs/access/`                         |
| `html/policies.html`   | `/docs/access/politicas/`               |
| `html/resolution.html` | `/docs/access/resolucao-de-identidade/` |
| `html/errors.html`     | `/docs/access/erros/`                   |

## Verifying before submission

1. Run `.\scripts\validate-repository.ps1`.
2. If you changed community or GitHub configuration files and have Node.js,
   run `npx --yes prettier@3.6.2 --check README.md README.pt-BR.md CONTRIBUTING.md CODE_OF_CONDUCT.md SECURITY.md ".github/**/*.{yml,md}"`.
3. Browse the changed page at desktop and mobile widths.
4. Confirm that there is no unintended horizontal scrolling.
5. Test links, menus, keyboard focus, and content displayed without JavaScript.
6. Confirm that examples contain no secrets and that future features are marked
   as not implemented.
7. Review the diff to ensure the pull request contains no generated files or
   unrelated changes.

In the pull request description, explain the problem, the solution, how it was
verified, and which pages or contracts were affected. Include images for visual
changes.

## Contribution license

By intentionally submitting a contribution for inclusion in this repository,
you agree that it may be made available under the
[Apache License 2.0](LICENSE), according to Section 5 of that license.

The repository license does not grant rights to Bullgate names, marks, or visual
identity beyond the descriptive use permitted by Section 6.
