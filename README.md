Create **timeweb-getssl-twcrc** podman secret before first run:

`podman secret create timeweb-getssl-twcrc your-secret-file`

Then you can run into getssl shell and work with your certificates:

`make exec`

Inside container shell you can test TimeWeb cli tool configuration via command:

`getssl@c296d5f117e7:~$ twc account status`

You should see something similar to:

```
Company                 	:	ООО "ТАЙМВЭБ.КЛАУД"     
Yandex.Metrika client ID	:	None                    
Blocked                 	:	False                   
Permanently blocked     	:	False                   
Send bill emails        	:	False                   
```
