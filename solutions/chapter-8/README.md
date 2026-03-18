# Solutions Chapter 8 - Lab: Terraform modularization (Modular Deployments)

## Results

The results should look like shown in [here](./labs/).

### Modularized Terraform code

This sample implementation is a suggestion on how to modularize the Terraform code. The implementation is based on the previous lab and the refactoring that had been shown previously. All generic things like resource group or randomizing strings will be kept in the `main.tf`. You could also create a `misc` module. The modules are split like this:

```bash
── main.tf
├── variables.tf
├── modules
│   ├── network
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── compute
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── k8s
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── db
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── ai
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
```

You successfully completed chapter 8. 🚀

## Continue

**[< back to Chapter](../../chapters/chapter-8/README.md) | [home](../../README.md)**
