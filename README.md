## Timeweb-LetsEncrypt

### About

LetsEncrypt certificate gainer for TimeWeb dns.
This is repo contains OCI image and Podman pod definition for setting up LetsEncrypt certificate updating systemd/kubernetes service. Below you can find usage cases and useful commands.

### Usage

Create **timeweb-getssl-twcrc** podman [secret](https://www.redhat.com/sysadmin/new-podman-secrets-command) before first run:

`podman secret create timeweb-getssl-twcrc your-secret-file`

The secret content is a Timeweb CLI config file. Example:

```
[default]
token = "your token here"
```

Then you can run shell in container and work with your certificates:

`make exec`

Inside container shell you can test Timeweb cli tool configuration via command:

`getssl@c296d5f117e7:~$ twc account status`

You should see something similar to:

```
Company                 	:	ООО "ТАЙМВЭБ.КЛАУД"     
Yandex.Metrika client ID	:	None                    
Blocked                 	:	False                   
Permanently blocked     	:	False                   
Send bill emails        	:	False                   
```

The certificates can be managed via [getssl](https://github.com/srvrco/getssl) utility in container shell.

```
getssl -c your-domain.com
getssl --all
```

### Podman service setup

Podman systemd services generation [HOWTO](https://www.redhat.com/sysadmin/podman-run-pods-systemd-services).
Also [here is](https://access.redhat.com/documentation/ru-ru/red_hat_enterprise_linux/8/html/building_running_and_managing_containers/assembly_porting-containers-to-systemd-using-podman_building-running-and-managing-containers) great feature reference.
The sample pod definition you can find in `pod.yml`.

### Deploy to Kubernetes

The supposed approach to use this image is to create Kubernetes stateful CronJob which will periodically check and update configured certificates.
The example terraform configuration for kubernetes provider can be found in `main.tf.example` file. 
The only thing you should do, is to provide required configuration in
`kubernetes_config_map_v1.config` and `kubernetes_config_map_v1.custom_scripts` configmaps and create `getssl-twc-config` named secret. 
The secret should contain Timeweb CLI config file. `kubernetes_config_map_v1.config` configmap contains your domain names, 
the second is customized getssl config, which is specific for each certificate and would be mounted into related getssl work subfolder.
