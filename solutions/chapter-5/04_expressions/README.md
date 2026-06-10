# Expressions

> [!IMPORTANT]
> **This challenge is OPTIONAL.**
> Both examples below create resources in **both Azure _and_ GitHub**.
> If you do not have a personal GitHub account and a Personal Access
> Token, **skip this challenge** and continue with
> [05_state](../05_state/README.md). You will not miss any Azure
> content — the Azure parts of this lab are identical patterns to what
> you already saw in [03_variables](../03_variables/README.md).
>
> If you _do_ have a GitHub account and want to try it, follow the
> README inside each subfolder for the exact setup steps.

## Overview

This folder has two small practical examples using expressions in Terraform:

1. [foreach](./foreach): use `for_each` to create multiple resources from a generated list.
2. [json](./json): use `jsondecode` to read a JSON file and drive multiple resources from it.
