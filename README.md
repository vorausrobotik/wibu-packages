# wibu-packages

This repository is a first approach to provide wibu customer runtimes in
package manager friendly manner.

The software belongs to and is developed by [WIBU-SYSTEMS AG](https://www.wibu.com) and can be downloaded on their
[website](https://www.wibu.com/de/support/anwendersoftware/anwendersoftware.html) as well.

WIBU-SYSTEMS AG allows us to redistribute the runtimes for you,
our customers, free of charge[^KB-0336].

## Development deployment

For development purposes it might be interesting to deploy e.g. the ubuntu repo locally.

In one terminal a webserver should be launched:

```bash
cd ubuntu/
python -m http.server 8080
```

While in another terminal, the installation of both the public key and the sources list can take place:

```bash
curl -s --compressed http://localhost:8080/burfeind_jan-niklas.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/burfeind_jan-niklas.gpg
echo "deb [signed-by=/etc/apt/trusted.gpg.d/burfeind_jan-niklas.gpg] http://localhost:8080 ./" | sudo tee /etc/apt/sources.list.d/localrepo.list
sudo apt-get update
```

After this, the repo can be used as in production.
Please note that it's not a good idea to have both the production and the development repo
activated at the same time.



[^KB-0336]: Only available after login: [KB-0336](https://support.wibu.com/tas/public/ssp/content/detail/knowledgeitem?unid=92be2713-a2f8-42a8-a5b3-27a4e6873883)

