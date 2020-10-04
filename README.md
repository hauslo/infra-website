
# infra-website

Deploys a `public/` directory to AWS S3 Website with terraform.

- [Provider](provider.tf)
- [Variables](variables.tf)
- [Outputs](outputs.tf)

See [test/main.tf](test/main.tf)

This modules expects aws secrets to be present in the environment (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables with valid credentials) although they are not required to [test](#test) the module locally.

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
