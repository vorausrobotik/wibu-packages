# WIBU packages

[![Nightly Artifactory installation check](https://github.com/vorausrobotik/wibu-packages/actions/workflows/nightly_artifactory_installable.yml/badge.svg)](https://github.com/vorausrobotik/wibu-packages/actions/workflows/nightly_artifactory_installable.yml)

WIBU customer runtimes are distributed via voraus robotik's [Artifactory](https://voraus.jfrog.io) instance.
This repository no longer hosts the package repository &mdash; it only retains two legacy `.deb` files for
[backward compatibility](#backward-compatibility) with older versions of our [ansible collection](https://github.com/vorausrobotik/voraus-ipc-tools-ansible).

> [!IMPORTANT]
> New installations must use the [Artifactory instructions](#installation-from-artifactory) below.

The software belongs to and is developed by [WIBU-SYSTEMS AG](https://www.wibu.com) and can be downloaded on their
[website](https://www.wibu.com/de/support/anwendersoftware/anwendersoftware.html) as well.

WIBU-SYSTEMS AG allows voraus robotik GmbH to redistribute the runtimes for you,
our customers, free of charge[^KB-0336].

## Installation from Artifactory

The packages are hosted on voraus robotik's [Artifactory](https://voraus.jfrog.io) instance and can be installed via `apt`.

> [!TIP]
> The easiest way to install the runtimes is via the
> [`wibu_packages`](https://github.com/vorausrobotik/voraus-ipc-tools-ansible/tree/main/voraus/ipc_tools/roles/wibu_packages)
> role of our ansible collection, which performs the steps below for you.

### 1. Add the signing key

Download the voraus robotik public signing key and install it as a trusted key for `apt`:

```console
curl -fsSL https://voraus.jfrog.io/ui/api/v1/ui/security/keyPairs/voraus-gpg/public | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/vorausrobotik.gpg
```

### 2. Add the apt source

Create `/etc/apt/sources.list.d/vorausrobotik.sources` with the following [deb822](https://manpages.ubuntu.com/manpages/noble/man5/sources.list.5.html) content:

```
Types: deb
URIs: https://voraus.jfrog.io/artifactory/debian
Suites: stable
Components: main
Signed-By: /etc/apt/trusted.gpg.d/vorausrobotik.gpg
```

### 3. Install a package

```console
sudo apt update

sudo apt install codemeter-lite
sudo apt install axprotector
```

From this point on the packages receive updates upon regular `apt upgrade` calls.

## Signing key change

> [!WARNING]
> The signing key has changed. The packages are now signed with the Artifactory key
> (`/etc/apt/trusted.gpg.d/vorausrobotik.gpg`), which replaces the old maintainers key.

If you previously installed from the old repository, remove the obsolete maintainers key:

```console
sudo rm -f /etc/apt/trusted.gpg.d/wibu-packages-maintainers.gpg
```

You should also remove the old apt source so it is no longer used:

```console
sudo rm -f /etc/apt/sources.list.d/voraus-wibu.list
```

## Backward compatibility

This repository exists solely to keep two legacy package versions reachable for older versions of our ansible role.
The following `.deb` files remain available under [`ubuntu/`](./ubuntu) and are served via
`https://wibu-packages.vorausrobotik.com/ubuntu/`:

- `codemeter-lite` 8.20.6539.500
- `axprotector` 11.70.7131.502

These files are frozen and receive no updates. New installations must use the
[Artifactory instructions](#installation-from-artifactory) above.

## License

> [!CAUTION]
> While the repo itself (folder structure, CI, ...) is licensed as MIT, the packages themselves are **NOT**.
> The license conditions of WIBU-SYSTEMS AG apply to these packages.

As stated above, the packages are property of WIBU-SYSTEMS AG. We are only allowed to redistribute them.
Their license is contained within the packages itself and is not affected by the MIT license of the rest of this repository.

[^KB-0336]: Only available after login: [KB-0336](https://support.wibu.com/tas/public/ssp/content/detail/knowledgeitem?unid=92be2713-a2f8-42a8-a5b3-27a4e6873883)
