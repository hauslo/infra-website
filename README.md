
# infra-website

Deploys a `public/` directory to AWS S3 Website with terraform.

- [Variables](variables.tf)
- [Outputs](outputs.tf)

## Test

### Auto

Start and wait for localstack, init terraform, run the test suite and stop localstack

```bash
make auto-test
```

### Manual

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

*See the [Makefile](Makefile) for more details.*
