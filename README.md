# Container Permission Squasher

🎃️👊️

Since the podman storage driver translates uid/gid 0 to your native ID when it
writes a new image on the filesystem, we need to "flatten permission" or make
everything in the container owned by root! Any other ID would require privileged namespaces.
Given a container you have just built, this action will allow you to flatten permissions
in this manner (and then likely push to a registry for later use).

## Example

Let's say our container is `library/ubuntu` and we want to squash to `ubuntu:squashed`.
We would generate the action as follows:

```yaml
name: Squash Image
on:
  pull_request: []

jobs:
  squash-container:
    name: Squash Ubuntu
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3
      - name: Squash Container
        uses: rse-ops/container-permission-squasher@main
        with:
          container: library/ubuntu
          squashed: ubuntu:squashed
      - name: View images
        run: |
          docker images
          podman images
```

You can see a full example workflow (building a primary container and adding a squashed tag)
in [examples](examples/squash-permissions.yaml).

## License

Copyright (c) 2017-2023, Lawrence Livermore National Security, LLC. 
Produced at the Lawrence Livermore National Laboratory.

RADIUSS Docker is licensed under the MIT license [LICENSE](./LICENSE).

Copyrights and patents in the RADIUSS Docker project are retained by
contributors. No copyright assignment is required to contribute to RADIUSS
Docker.

This work was produced under the auspices of the U.S. Department of
Energy by Lawrence Livermore National Laboratory under Contract
DE-AC52-07NA27344.

