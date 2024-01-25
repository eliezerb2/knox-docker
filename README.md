A failed attempt to fork from and improve https://github.com/pzampino/knox-docker.
Continued work on https://github.com/eliezerb2/apache-knox-docker.

# Apache Knox Release Docker Container

By default, this Dockerfile creates an image for Apache Knox 1.1.0

The release version can be overridden by modifying the __RELEASE_VER__ value in the __.env__ file.

If a different mirror is needed for the release version, modify the __RELEASE_MIRROR__ argument in the __docker-compose__ file.

Run *docker compose* to create and start the Knox container based on this image (and the demo LDAP server)

    docker-compose up --build

This creates a container named __knox__, and it also creates a bridge network named __knox-docker_knox-test__

The Knox Admin UI will be accessible at https://localhost:8443/gateway/manager/admin-ui/


If running other Docker containers, with which this Knox instance must be able to interact, those other containers  must be connected to this network.

For example, if running the [HDP Docker Sandbox](https://hortonworks.com/products/sandbox/), it can be connected to the overlay network using this command:

    docker network connect knox-docker_knox-test sandbox-hdp




