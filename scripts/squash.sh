#!/bin/bash

URI=${1}
SQUASHED=${2}

echo "🎃️ Preparing to squash ${URI} into ${SQUASHED}..."
export BUILDID=$(uuidgen -r | head -c 8)

export CONTAINERID=$(podman create ${URI}) \
&& ( \
     podman unshare sh -c '
       export IMG=$(podman mount $CONTAINERID) \
       && tar --group=root --owner=root --mode a+rX,g+rwX -cf $BUILDID-rootfs.tar -C $IMG . \
     ' \
  && podman import $BUILDID-rootfs.tar ${SQUASHED} \
)
podman rm $CONTAINERID
