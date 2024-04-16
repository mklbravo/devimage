# Dev Image

!TODO

### Secrets

DevImages make some preparations so that you can use secrets in your development environment. 

#### SSH Key

You can define your local SSH to be used inside the container. 
This way you don't need to configure a new SSH key inside the container each time you start the container,
and also you can use it to access your repositories.

To do this you need to define the `ssh_private_key` on your docker-compose.yml file. 

```yaml
secrets:
  ssh_private_key:
    file: ~/.ssh/<your_private_key>
```

Then configure the image based on `devimage` to use this secret.

```yaml
services:
  dev:
    image: devimage
    secrets:
      - ssh_private_key
```
