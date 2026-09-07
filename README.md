# Bullgate

**Português (Brasil): [README.pt-BR.md](README.pt-BR.md)**

Bullgate is an open-source, mobile-first platform for application identity,
access, subscriptions, targeted offers, entitlements, and operations.

This repository contains the public website, product concepts, and technical
documentation for people who want to understand or integrate Bullgate.

The public website and technical documentation are currently available in
Brazilian Portuguese.

- [Discover Bullgate](https://bullgate.dev/)
- [Browse the technical documentation](https://bullgate.dev/docs/)
- [Integrate Bullgate Access](https://bullgate.dev/docs/access/)

## Current status

**Bullgate Access** is implemented and integrated with the BAYBO development
laboratory. It covers registration and login, opaque sessions, server-to-server
integration, an ASP.NET Core adapter, a React Native SDK, phone verification,
and the first phase of phone-conflict resolution. The integrated flow was
validated on a physical Android device on September 4, 2026.

Bootstrap uses one version 2 manifest per environment for policies, providers,
secrets, and public configuration. Each build identifies itself with a stable,
public `applicationClientKey`; `ApplicationClient` UUIDs remain internal database
details. The application communicates only with its BFF and never receives the
integration credential or provider secrets.

The published pages explicitly distinguish three states:

- behavior implemented and available in the current phase;
- a decided contract that has not yet been implemented;
- a future possibility that still requires design and validation.

The Bullgate Billing one-time-purchase core began on September 5, 2026. It now
includes PostgreSQL persistence, migrations, a server-to-server API, dedicated
authentication, manifest bootstrap, and concurrent database and HTTP tests. The
catalog supports new products and SKUs, and credentials have explicit rotation.
As of September 6, 2026, it also includes a .NET SDK, HTTP benefit delivery, a
repurchase policy, Google Play and App Store verifiers, and account-linking
preparation. Tests use simulated external HTTP services; the purchase flow is
not yet connected to a BFF or mobile application and has not been validated with
real store purchases. Finalization and recovery, along with the resolution of
blocked paid purchases, remain pending.

Billing, offers, entitlements, and other areas are presented as early
construction, product vision, or experience proven in the BAYBO laboratory
until they exist as public Bullgate modules. The documentation does not present
roadmap items as available functionality.

## Published documentation

| Page                                                                             | Content                                                                                     |
| -------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| [Overview](https://bullgate.dev/)                                                | Problems Bullgate addresses, product principles, and the status of each area.               |
| [Bullgate Lab Privacy Policy](https://bullgate.dev/privacy/)                     | Data processed by the mobile application, purposes, providers, and contact information.     |
| [Technical index](https://bullgate.dev/docs/)                                    | Entry point for choosing the appropriate integration document.                              |
| [Access integration](https://bullgate.dev/docs/access/)                          | Architecture, configuration, contracts, endpoints, backend adapter, and frontend SDK.       |
| [Policies](https://bullgate.dev/docs/access/politicas/)                          | Manifest, authenticators, identifiers, verification, permissions, and invariants.           |
| [Identity resolution](https://bullgate.dev/docs/access/resolucao-de-identidade/) | Conflict detection, proofs, actions, concurrency, transfers, and phase-one limits.          |
| [Errors and messages](https://bullgate.dev/docs/access/erros/)                   | Stable codes, HTTP statuses, recommended copy, interface actions, and operational handling. |

## Repository contents

| Path                                                   | Purpose                                                                                        |
| ------------------------------------------------------ | ---------------------------------------------------------------------------------------------- |
| [`html/`](html/)                                       | HTML sources for the website and published documentation.                                      |
| [`apresentacao-bullgate.md`](apresentacao-bullgate.md) | Master product vision, capabilities, and status document in Brazilian Portuguese.              |
| [`deploy-bullgate.ps1`](deploy-bullgate.ps1)           | Builds the local route tree; publishing to the legacy Pages project requires an explicit flag. |
| [`DEPLOY.md`](DEPLOY.md)                               | Operational publishing procedure maintained for the website owners, in Brazilian Portuguese.   |

## Documentation principles

- **Behavior before promises:** every capability states whether it is
  implemented, decided, or only planned.
- **Contracts before examples:** parameters, states, errors, and effects must be
  explained before an integration copies code.
- **Backend and frontend remain separate:** each side of the integration has an
  explicit responsibility; server secrets are never application configuration.
- **Text for people, structure for tools:** content must be readable today and
  stable enough to support tools and MCPs in the future.

## Contributing

Corrections, examples, accessibility improvements, and documentation proposals
are welcome. Read the [contribution guide](CONTRIBUTING.md) before opening a pull
request. Participation in this project is governed by our
[Code of Conduct](CODE_OF_CONDUCT.md).

## Security

Do not disclose vulnerabilities or sensitive data in issues. See the
[security policy](SECURITY.md) for scope and private reporting instructions.

## License

The code and content in this repository are licensed under the
[Apache License 2.0](LICENSE).

Under Section 6 of Apache-2.0, the license does not grant permission to use
Bullgate trade names, service marks, trademarks, product names, or visual
identity except for reasonable descriptive use required to identify the origin
of the work.
