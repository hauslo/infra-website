
# infra-website

Deploys a `public/` directory to AWS S3 Website

## Variables

[./variables.tf]

## Outputs

[./outputs.tf]

## Tests

Start localstack and init terraform

```bash
make start
```

Run the test suite

```bash
make apply
```

- validates terraform (`validate`) ;
- applies terraform (`apply`) ;
- ensures that `curl localhost:4572/test/index.html` return `200`

Stop localstack

```bash
make stop
```

*See [./Makefile] for more details.*
