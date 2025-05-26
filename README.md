# opa-tools

> A collection of tools for Open Policy Agent (OPA) development and deployment.

Based on [alpine](https://hub.docker.com/_/alpine/tags).

Includes:

- [OPA](https://github.com/open-policy-agent/opa) - Open Policy Agent
- [regal](https://github.com/StyraInc/regal) - OPA Rego Linter
- [policy](https://github.com/opcr-io/policy) - CLI for managing authorization policies and pushing them to OCI registries
- [oras](https://github.com/oras-project/oras) - OCI Registry As Storage
- [raygun](https://github.com/mheers/opa-raygun) - Blackbox OPA Rego Policy Tester
- [raygun2x](https://github.com/mheers/raygun2x) - CLI tool that converts raygun test suites into either an OpenAPI specification or a Postman Collection
- [cosign](https://hub.docker.com/r/bitnami/cosign) - Cosign supports container signing, verification, and storage in an OCI registry
- [mcp-language-server](https://github.com/isaacphi/mcp-language-server) - General Language server MCP implementation

## Image signature creation

```bash
cosign sign mheers/opa-tools:1.1.0
```

## Image signature verification

```bash
cosign verify mheers/opa-tools:1.1.0 --certificate-identity=github@NightSteam.de --certificate-oidc-issuer=https://github.com/login/oauth
```
